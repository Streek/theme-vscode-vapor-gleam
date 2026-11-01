# =============================================================================
# Vapor Gleam Theme - Python Syntax Test
# =============================================================================
# Exercises: decorators, type hints, f-strings, comprehensions, generators,
# async/await, metaclasses, dataclasses, pattern matching, walrus operator,
# context managers, magic methods, exception chaining.
#
# Expected token colors:
#   Comments ............. #6c7086 italic
#   Keywords ............. #c4a7e7 bold
#   Functions ............ #8bbec7
#   Types/Classes ........ #ffc1eb / #c4a7e7
#   Variables ............ #ffc1eb
#   Parameters ........... #e4c87b italic
#   Strings .............. #7dd3fc
#   Numbers/Constants .... #e4c87b
#   Decorators ........... #c4a7e7
#   Escape chars ......... #c4a7e7
# =============================================================================

from __future__ import annotations

import asyncio
import json
import re
from abc import ABC, abstractmethod
from collections.abc import AsyncIterator, Generator, Iterator
from dataclasses import dataclass, field
from enum import Enum, auto
from functools import wraps
from pathlib import Path
from typing import (
    Any,
    ClassVar,
    Final,
    Generic,
    Literal,
    NamedTuple,
    Never,
    Optional,
    Protocol,
    Self,
    TypeAlias,
    TypeGuard,
    TypeVar,
    Union,
    overload,
    runtime_checkable,
)

# --- Constants ---
MAX_RETRIES: Final[int] = 5
PI: Final[float] = 3.14159
GREETING: Final[str] = "Hello, Vapor Gleam!"
HEX_VALUE: int = 0xFF00FF
OCTAL_VALUE: int = 0o777
BINARY_VALUE: int = 0b1010
COMPLEX_VALUE: complex = 3 + 4j
NONE_VALUE: None = None
REGEX_PATTERN: re.Pattern[str] = re.compile(r"^[a-z]+@[a-z]+\.[a-z]{2,}$", re.IGNORECASE)

# --- Type aliases ---
JsonValue: TypeAlias = Union[str, int, float, bool, None, list["JsonValue"], dict[str, "JsonValue"]]
T = TypeVar("T")
K = TypeVar("K")
V = TypeVar("V")


# --- Enums ---
class Color(Enum):
    RED = auto()
    GREEN = auto()
    BLUE = auto()
    CUSTOM = "custom"


class Status(Enum):
    ACTIVE = 1
    INACTIVE = 0


# --- Protocol (structural typing) ---
@runtime_checkable
class Serializable(Protocol):
    def serialize(self) -> str: ...
    def deserialize(self, data: str) -> None: ...


# --- Dataclass ---
@dataclass(frozen=True, slots=True)
class Point:
    x: float
    y: float
    label: str = ""
    tags: list[str] = field(default_factory=list)

    def distance_to(self, other: Point) -> float:
        return ((self.x - other.x) ** 2 + (self.y - other.y) ** 2) ** 0.5


# --- NamedTuple ---
class UserRecord(NamedTuple):
    id: int
    name: str
    email: str
    role: Literal["admin", "user", "guest"] = "user"


# --- Abstract class ---
class Shape(ABC):
    @abstractmethod
    def area(self) -> float: ...

    @abstractmethod
    def perimeter(self) -> float: ...

    def describe(self) -> str:
        return f"Shape with area {self.area():.2f}"


class Circle(Shape):
    def __init__(self, radius: float) -> None:
        self._radius = radius

    @property
    def radius(self) -> float:
        return self._radius

    @radius.setter
    def radius(self, value: float) -> None:
        if value < 0:
            raise ValueError("Radius must be non-negative")
        self._radius = value

    def area(self) -> float:
        return PI * self._radius**2

    def perimeter(self) -> float:
        return 2 * PI * self._radius

    def __repr__(self) -> str:
        return f"Circle(radius={self._radius})"

    def __eq__(self, other: object) -> bool:
        if not isinstance(other, Circle):
            return NotImplemented
        return self._radius == other._radius

    def __hash__(self) -> int:
        return hash(self._radius)


# --- Generic class ---
class Repository(Generic[T]):
    _class_count: ClassVar[int] = 0

    def __init__(self, name: str) -> None:
        self._items: dict[int, T] = {}
        self._name = name
        Repository._class_count += 1

    def add(self, key: int, item: T) -> None:
        self._items[key] = item

    def get(self, key: int) -> T | None:
        return self._items.get(key)

    def __len__(self) -> int:
        return len(self._items)

    def __iter__(self) -> Iterator[T]:
        return iter(self._items.values())

    def __contains__(self, key: int) -> bool:
        return key in self._items

    def __getitem__(self, key: int) -> T:
        return self._items[key]

    def __setitem__(self, key: int, value: T) -> None:
        self._items[key] = value

    def __delitem__(self, key: int) -> None:
        del self._items[key]


# --- Decorators ---
def retry(max_attempts: int = 3, delay: float = 1.0):
    def decorator(func):
        @wraps(func)
        async def wrapper(*args: Any, **kwargs: Any) -> Any:
            last_error: Exception | None = None
            for attempt in range(max_attempts):
                try:
                    return await func(*args, **kwargs)
                except Exception as e:
                    last_error = e
                    if attempt < max_attempts - 1:
                        await asyncio.sleep(delay * (2**attempt))
            raise last_error  # type: ignore[misc]

        return wrapper

    return decorator


# --- Overloads ---
@overload
def process(value: str) -> str: ...
@overload
def process(value: int) -> int: ...
@overload
def process(value: list[str]) -> list[str]: ...


def process(value: str | int | list[str]) -> str | int | list[str]:
    if isinstance(value, str):
        return value.upper()
    elif isinstance(value, int):
        return value * 2
    else:
        return [v.upper() for v in value]


# --- Type guard ---
def is_string_list(value: list[Any]) -> TypeGuard[list[str]]:
    return all(isinstance(item, str) for item in value)


# --- Generator ---
def fibonacci() -> Generator[int, None, None]:
    a, b = 0, 1
    while True:
        yield a
        a, b = b, a + b


# --- Async generator ---
async def async_range(start: int, end: int) -> AsyncIterator[int]:
    for i in range(start, end):
        await asyncio.sleep(0.01)
        yield i


# --- Context manager ---
class Timer:
    def __enter__(self) -> Self:
        import time
        self._start = time.perf_counter()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb) -> bool:
        import time
        self.elapsed = time.perf_counter() - self._start
        return False


# --- Pattern matching (3.10+) ---
def handle_command(command: str, *args: str) -> str:
    match command.split():
        case ["quit" | "exit"]:
            return "Goodbye"
        case ["greet", name]:
            return f"Hello, {name}!"
        case ["add", *numbers] if all(n.isdigit() for n in numbers):
            total = sum(int(n) for n in numbers)
            return f"Sum: {total}"
        case ["set", key, value] as full_command:
            return f"Setting {key}={value} (from {full_command})"
        case _:
            return f"Unknown command: {command}"


# --- Walrus operator ---
def find_long_lines(text: str, min_length: int = 80) -> list[str]:
    return [line for line in text.splitlines() if (n := len(line)) >= min_length]


# --- String varieties ---
raw_string = r"no \n escapes \t here"
byte_string = b"byte content \x00\xff"
multiline = """
This is a
multiline string
with "quotes" inside
"""
f_string = f"Result: {1 + 2 = }, pi={PI:.4f}, {'yes' if True else 'no'}"
format_string = "Hello, {}! You are {} years old.".format("Alice", 30)

# --- Comprehensions ---
squares = [x**2 for x in range(10)]
even_squares = [x**2 for x in range(10) if x % 2 == 0]
matrix = [[i * j for j in range(5)] for i in range(5)]
unique_chars = {c for c in "hello world" if c.isalpha()}
char_counts = {c: s.count(c) for s in ["hello"] for c in set(s)}
gen_expr = sum(x**2 for x in range(100))

# --- Exception chaining ---
class AppError(Exception):
    pass


class DatabaseError(AppError):
    pass


def risky_operation() -> None:
    try:
        result = 1 / 0
    except ZeroDivisionError as e:
        raise DatabaseError("Calculation failed") from e


# --- Slots, metaclass ---
class Meta(type):
    def __new__(mcs, name: str, bases: tuple, namespace: dict) -> Meta:
        cls = super().__new__(mcs, name, bases, namespace)
        return cls


class Optimized(metaclass=Meta):
    __slots__ = ("_value",)

    def __init__(self, value: int) -> None:
        self._value = value


# --- Async main ---
async def main() -> None:
    # Basic operations
    circle = Circle(5.0)
    print(circle.describe())
    print(f"Area: {circle.area():.2f}")

    # Repository
    repo: Repository[UserRecord] = Repository("users")
    repo.add(1, UserRecord(1, "Alice", "alice@example.com", "admin"))
    repo.add(2, UserRecord(2, "Bob", "bob@example.com"))

    # Generator
    fib = fibonacci()
    first_ten = [next(fib) for _ in range(10)]
    print(f"Fibonacci: {first_ten}")

    # Async iteration
    async for n in async_range(0, 5):
        print(f"Async: {n}")

    # Pattern matching
    print(handle_command("greet World"))
    print(handle_command("add 1 2 3 4 5"))

    # Context manager
    with Timer() as t:
        await asyncio.sleep(0.1)
    print(f"Elapsed: {t.elapsed:.3f}s")

    # Walrus
    if (user := repo.get(1)) is not None:
        print(f"Found: {user.name}")


if __name__ == "__main__":
    asyncio.run(main())
