export interface Logger {
  debug(msg: string): void;
  warn(msg: string): void;
}

export const consoleLogger: Logger = {
  debug: (msg) => console.debug(`[cart] ${msg}`),
  warn: (msg) => console.warn(`[cart] ${msg}`),
};
