// =============================================================================
// Vapor Gleam Theme - TypeScript Syntax Test
// =============================================================================
// Exercises: keywords, types, interfaces, generics, decorators, template
// literals, async/await, classes, enums, namespaces, type guards, mapped types,
// conditional types, string literals, regex, JSX-adjacent patterns.
//
// Expected token colors:
//   Comments ............. #6c7086 italic
//   Keywords ............. #c4a7e7 bold
//   Functions ............ #8bbec7
//   Types/Interfaces ..... #ffc1eb
//   Variables ............ #ffc1eb
//   Parameters ........... #e4c87b italic
//   Strings .............. #7dd3fc
//   Numbers/Constants .... #e4c87b
//   Punctuation .......... #ffc1eb
//   Escape chars ......... #c4a7e7
//   Regex ................ #8bbec7
// =============================================================================

// --- Imports ---
import { readFile, writeFile } from "fs/promises";
import * as path from "path";
import type { IncomingMessage } from "http";

// --- Constants and primitives ---
const MAX_RETRIES = 5;
const PI = 3.14159;
const GREETING = "Hello, Vapor Gleam!";
const TEMPLATE = `Value is ${MAX_RETRIES} and pi is ${PI}`;
const ENABLED = true;
const NOTHING = null;
const MISSING = undefined;
const BIG = 9007199254740991n;
const HEX = 0xff00ff;
const OCTAL = 0o777;
const BINARY = 0b1010;
const REGEX_PATTERN = /^[a-z]+@[a-z]+\.[a-z]{2,}$/gi;

// --- Enums ---
enum Direction {
  Up = "UP",
  Down = "DOWN",
  Left = "LEFT",
  Right = "RIGHT",
}

const enum Status {
  Active = 1,
  Inactive = 0,
}

// --- Interfaces ---
interface Serializable {
  serialize(): string;
  deserialize(data: string): void;
}

interface User {
  readonly id: number;
  name: string;
  email?: string;
  age: number;
  role: "admin" | "user" | "guest";
  metadata: Record<string, unknown>;
}

// --- Type aliases, union, intersection, conditional, mapped ---
type Nullable<T> = T | null;
type ReadonlyUser = Readonly<User>;
type PartialUser = Partial<User>;
type UserKeys = keyof User;
type StringKeys<T> = { [K in keyof T]: T[K] extends string ? K : never }[keyof T];
type IsString<T> = T extends string ? true : false;
type DeepPartial<T> = { [K in keyof T]?: T[K] extends object ? DeepPartial<T[K]> : T[K] };

// --- Generic class with constraints ---
class Repository<T extends { id: number }> implements Serializable {
  private items: Map<number, T> = new Map();
  protected readonly name: string;

  constructor(name: string) {
    this.name = name;
  }

  add(item: T): void {
    this.items.set(item.id, item);
  }

  get(id: number): T | undefined {
    return this.items.get(id);
  }

  getAll(): T[] {
    return Array.from(this.items.values());
  }

  find(predicate: (item: T) => boolean): T | undefined {
    for (const item of this.items.values()) {
      if (predicate(item)) {
        return item;
      }
    }
    return undefined;
  }

  serialize(): string {
    return JSON.stringify(Array.from(this.items.entries()));
  }

  deserialize(data: string): void {
    const entries: [number, T][] = JSON.parse(data);
    this.items = new Map(entries);
  }
}

// --- Abstract class ---
abstract class Shape {
  abstract area(): number;
  abstract perimeter(): number;

  describe(): string {
    return `Shape with area ${this.area().toFixed(2)}`;
  }
}

class Circle extends Shape {
  constructor(private radius: number) {
    super();
  }

  area(): number {
    return Math.PI * this.radius ** 2;
  }

  perimeter(): number {
    return 2 * Math.PI * this.radius;
  }
}

// --- Decorators (stage 3) ---
function logged(target: any, key: string, descriptor: PropertyDescriptor) {
  const original = descriptor.value;
  descriptor.value = function (...args: any[]) {
    console.log(`Calling ${key} with`, args);
    return original.apply(this, args);
  };
  return descriptor;
}

// --- Async/await, promises, error handling ---
async function fetchData(url: string): Promise<string> {
  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }
    return await response.text();
  } catch (error) {
    if (error instanceof TypeError) {
      console.error("Network error:", error.message);
    } else if (error instanceof Error) {
      console.error("Fetch error:", error.message);
    }
    throw error;
  } finally {
    console.log("Fetch attempt completed");
  }
}

// --- Generators ---
function* fibonacci(): Generator<number, void, unknown> {
  let [a, b] = [0, 1];
  while (true) {
    yield a;
    [a, b] = [b, a + b];
  }
}

async function* asyncRange(start: number, end: number): AsyncGenerator<number> {
  for (let i = start; i < end; i++) {
    await new Promise((resolve) => setTimeout(resolve, 10));
    yield i;
  }
}

// --- Type guards and narrowing ---
function isUser(value: unknown): value is User {
  return (
    typeof value === "object" &&
    value !== null &&
    "id" in value &&
    "name" in value &&
    typeof (value as User).id === "number"
  );
}

function processValue(value: string | number | boolean | null): string {
  if (value === null) return "null";
  if (typeof value === "string") return value.toUpperCase();
  if (typeof value === "number") return value.toFixed(2);
  return value ? "yes" : "no";
}

// --- Destructuring, spread, rest ---
function mergeUsers(defaults: User, ...overrides: Partial<User>[]): User {
  const merged = { ...defaults };
  for (const override of overrides) {
    Object.assign(merged, override);
  }
  return merged;
}

const { name: userName, age: userAge, ...rest } = {
  name: "Alice",
  age: 30,
  email: "alice@example.com",
  role: "admin" as const,
  id: 1,
  metadata: {},
};

// --- Template literal types ---
type EventName = `on${Capitalize<string>}`;
type HttpMethod = "GET" | "POST" | "PUT" | "DELETE";
type Endpoint = `/${string}`;
type Route = `${HttpMethod} ${Endpoint}`;

// --- Symbols, iterators, computed properties ---
const uniqueKey = Symbol("unique");
const TAG = Symbol.for("tag");

interface Iterable<T> {
  [Symbol.iterator](): Iterator<T>;
}

// --- Namespace ---
namespace Validation {
  export function isEmail(value: string): boolean {
    return REGEX_PATTERN.test(value);
  }

  export function isNonEmpty(value: string): boolean {
    return value.trim().length > 0;
  }
}

// --- Tuple types ---
type Pair<A, B> = [A, B];
type Triple<A, B, C> = [A, B, C];
type NamedTuple = [first: string, second: number, ...rest: boolean[]];

// --- Infer keyword ---
type ReturnTypeOf<T> = T extends (...args: any[]) => infer R ? R : never;
type ElementType<T> = T extends (infer E)[] ? E : never;

// --- Satisfies operator ---
const palette = {
  red: [255, 0, 0],
  green: "#00ff00",
  blue: [0, 0, 255],
} satisfies Record<string, string | number[]>;

// --- String escapes ---
const escapes = "tab:\tnewline:\nnull:\0quote:\"backslash:\\";
const unicode = "\u0041\u{1F600}";

// --- Switch exhaustiveness ---
function handleDirection(dir: Direction): string {
  switch (dir) {
    case Direction.Up:
      return "Going up";
    case Direction.Down:
      return "Going down";
    case Direction.Left:
      return "Going left";
    case Direction.Right:
      return "Going right";
    default: {
      const _exhaustive: never = dir;
      return _exhaustive;
    }
  }
}

// --- Index signatures and utility types ---
interface StringMap {
  [key: string]: string;
}

type RequiredUser = Required<User>;
type PickedUser = Pick<User, "id" | "name">;
type OmittedUser = Omit<User, "metadata">;
type ExtractedRole = Extract<User["role"], "admin" | "user">;
type ExcludedRole = Exclude<User["role"], "guest">;

// --- Main ---
async function main(): Promise<void> {
  const repo = new Repository<User>("users");
  const circle = new Circle(5);

  console.log(circle.describe());
  console.log(handleDirection(Direction.Up));
  console.log(Validation.isEmail("test@example.com"));

  const fib = fibonacci();
  for (let i = 0; i < 10; i++) {
    console.log(fib.next().value);
  }

  for await (const n of asyncRange(0, 5)) {
    console.log(n);
  }
}

main().catch(console.error);
