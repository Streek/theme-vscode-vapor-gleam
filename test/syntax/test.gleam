// =============================================================================
// Vapor Gleam Theme - Gleam Syntax Test
// =============================================================================
// This file exercises all Gleam token scopes targeted by the theme.
// Open this file with the Vapor Gleam theme active to verify colors.
//
// Expected token colors:
//   Comments ............. #6c7086 italic
//   Keywords ............. #c4a7e7 bold
//   Functions ............ #8bbec7
//   Types ................ #ffc1eb
//   Variables ............ #ffc1eb
//   Parameters ........... #e4c87b italic
//   Strings .............. #7dd3fc
//   Numbers/Constants .... #e4c87b
//   Modules .............. #c4a7e7
//   Punctuation .......... #ffc1eb
// =============================================================================

// --- Imports (meta.import, entity.name) ---
import gleam/io
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string

// --- Module-level constants (constant.language, constant.numeric) ---
const max_retries = 5
const pi = 3.14159
const greeting = "Hello, Vapor Gleam!"
const enabled = True
const disabled = False

// --- Custom types (entity.name.type, entity.name.class) ---
pub type Color {
  Red
  Green
  Blue
  Custom(r: Int, g: Int, b: Int)
}

pub type User {
  User(name: String, age: Int, email: Option(String))
}

pub type Result(value, error) {
  Ok(value)
  Error(error)
}

// --- Type aliases ---
pub type Name = String
pub type Age = Int
pub type UserList = List(User)

// --- Simple function (entity.name.function, variable.parameter) ---
pub fn greet(name: String) -> String {
  "Hello, " <> name <> "!"
}

// --- Function with multiple parameters and pattern matching ---
pub fn describe_color(color: Color) -> String {
  case color {
    Red -> "red"
    Green -> "green"
    Blue -> "blue"
    Custom(r, g, b) -> {
      "rgb("
      <> string.inspect(r)
      <> ", "
      <> string.inspect(g)
      <> ", "
      <> string.inspect(b)
      <> ")"
    }
  }
}

// --- Higher-order functions (fn type, passed_function pattern) ---
fn apply_twice(value: Int, transform: fn(Int) -> Int) -> Int {
  transform(transform(value))
}

fn add_one(x: Int) -> Int {
  x + 1
}

// --- Pipeline operator and list operations ---
pub fn process_numbers(numbers: List(Int)) -> List(Int) {
  numbers
  |> list.filter(fn(n) { n > 0 })
  |> list.map(fn(n) { n * 2 })
  |> list.sort(by: int_compare)
}

fn int_compare(a: Int, b: Int) -> order.Order {
  case a < b {
    True -> order.Lt
    False ->
      case a > b {
        True -> order.Gt
        False -> order.Eq
      }
  }
}

// --- Use expressions and Result handling ---
pub fn parse_and_double(input: String) -> Result(Int, String) {
  use value <- result.try(
    int.parse(input)
    |> result.map_error(fn(_) { "Not a valid integer" }),
  )
  Ok(value * 2)
}

// --- Let bindings, string interpolation, guards ---
pub fn format_user(user: User) -> String {
  let User(name: name, age: age, email: email) = user
  let email_str = case email {
    Some(e) -> e
    None -> "no email"
  }
  let status = case age {
    a if a < 18 -> "minor"
    a if a < 65 -> "adult"
    _ -> "senior"
  }
  name <> " (" <> status <> ") - " <> email_str
}

// --- Anonymous functions and closures ---
pub fn make_adder(amount: Int) -> fn(Int) -> Int {
  fn(x) { x + amount }
}

// --- Tuple and list patterns ---
pub fn first_two(items: List(a)) -> Result(#(a, a), String) {
  case items {
    [first, second, ..] -> Ok(#(first, second))
    _ -> Error("Need at least two items")
  }
}

// --- Bit strings and binary patterns ---
pub fn parse_header(data: BitArray) -> Result(#(Int, Int), String) {
  case data {
    <<version:8, length:16, _rest:bits>> -> Ok(#(version, length))
    _ -> Error("Invalid header")
  }
}

// --- Labeled arguments ---
pub fn create_user(
  name name: String,
  age age: Int,
  email email: Option(String),
) -> User {
  User(name: name, age: age, email: email)
}

// --- Assert and todo/panic ---
pub fn unwrap_or_crash(value: Option(a)) -> a {
  let assert Some(inner) = value
  inner
}

pub fn not_yet_implemented() -> Nil {
  todo as "This feature is coming soon"
}

// --- Main entry point ---
pub fn main() {
  // String operations
  let message = greet("World")
  io.println(message)

  // Pattern matching
  let color = Custom(255, 128, 0)
  io.println(describe_color(color))

  // Higher-order functions
  let result = apply_twice(5, add_one)
  io.debug(result)

  // Pipeline
  let numbers = [3, -1, 4, -1, 5, 9, -2, 6]
  let processed = process_numbers(numbers)
  io.debug(processed)

  // User formatting
  let user = create_user(
    name: "Alice",
    age: 30,
    email: Some("alice@example.com"),
  )
  io.println(format_user(user))

  // Closures
  let add_ten = make_adder(10)
  io.debug(add_ten(5))

  // Tuple destructuring
  let assert Ok(#(a, b)) = first_two([1, 2, 3])
  io.debug(#(a, b))
}
