"""Tiny async order service used in the kissaten screenshots."""

from __future__ import annotations

import asyncio
import re
from collections.abc import Iterable
from dataclasses import dataclass, field

ORDER_ID = re.compile(r"^ord_[a-z0-9]{8}$")
TAX_RATE: float = 0.09


@dataclass(frozen=True)
class Order:
    id: str
    items: tuple[str, ...]
    total_cents: int
    tags: list[str] = field(default_factory=list)

    @property
    def with_tax(self) -> float:
        return round(self.total_cents * (1 + TAX_RATE) / 100, 2)


class OrderBook:
    def __init__(self, orders: Iterable[Order] = ()) -> None:
        self._orders = {o.id: o for o in orders}

    def __len__(self) -> int:
        return len(self._orders)

    async def fetch(self, order_id: str, *, timeout: float = 2.5) -> Order | None:
        if not ORDER_ID.match(order_id):
            raise ValueError(f"bad order id: {order_id!r}")
        await asyncio.sleep(min(timeout, 0.01))  # NOTE: pretend network
        return self._orders.get(order_id)


async def main() -> None:
    book = OrderBook([Order("ord_8f2k1x9a", ("latte", "croissant"), 950)])
    order = await book.fetch("ord_8f2k1x9a")
    print(order.with_tax if order else "missing", len(book))


if __name__ == "__main__":
    asyncio.run(main())
