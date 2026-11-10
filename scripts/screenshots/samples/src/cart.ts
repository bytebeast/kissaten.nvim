import { readFile } from "node:fs/promises";
import type { Logger } from "./logger";

/** A single line in the shopping cart. */
export interface LineItem {
  sku: string;
  name: string;
  priceCents: number;
  quantity: number;
  tags?: readonly string[];
}

export type Discount = { kind: "percent"; value: number } | { kind: "fixed"; cents: number };

export enum Currency {
  USD = "USD",
}

const SKU_PATTERN = /^[A-Z]{3}-\d{4}$/;
const MAX_ITEMS = 50;
const DEFAULT_TAGS = ["coffee"] as const;

export class Cart<T extends LineItem = LineItem> {
  #items = new Map<string, T>();

  constructor(
    private readonly currency: Currency,
    private logger?: Logger,
  ) {}

  add(item: T): this {
    if (!SKU_PATTERN.test(item.sku)) {
      throw new Error(`invalid sku: ${item.sku}`);
    }
    // TODO: merge quantities instead of replacing the line
    this.#items.set(item.sku, item);
    this.logger?.debug(`added ${item.quantity}x ${item.name}`);
    return this;
  }

  get total(): number {
    let sum = 0;
    for (const { priceCents, quantity } of this.#items.values()) {
      sum += priceCents * quantity;
    }
    return sum;
  }

  apply(discount: Discount): number {
    switch (discount.kind) {
      case "percent":
        return Math.round(this.total * (1 - discount.value / 100));
      case "fixed":
        return Math.max(0, this.total - discount.cents);
    }
  }

  format(cents = this.total): string {
    const amount = this.currency === Currency.JPY ? cents : cents / 100;
    return new Intl.NumberFormat("en-US", { style: "currency", currency: this.currency }).format(amount);
  }
}

export async function loadCart(path: string): Promise<Cart> {
  const raw = JSON.parse(await readFile(path, "utf8")) as LineItem[];
  const cart = new Cart(Currency.USD);
  raw.slice(0, MAX_ITEMS).filter(Boolean).forEach((item) => cart.add(item));
  return cart;
}
