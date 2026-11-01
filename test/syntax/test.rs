// =============================================================================
// Vapor Gleam Theme - Rust Syntax Test
// =============================================================================
// Exercises: lifetimes, traits, generics, macros, pattern matching, closures,
// async/await, unsafe, const generics, associated types, derive macros,
// error handling, iterators, smart pointers.
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
//   Macros ............... (varies)
//   Lifetimes ............ (varies)
// =============================================================================

use std::collections::HashMap;
use std::fmt;
use std::io::{self, Read, Write};
use std::sync::{Arc, Mutex};

// --- Constants ---
const MAX_RETRIES: u32 = 5;
const PI: f64 = 3.14159;
static GREETING: &str = "Hello, Vapor Gleam!";

// --- Enums with data ---
#[derive(Debug, Clone, PartialEq)]
enum Color {
    Red,
    Green,
    Blue,
    Custom { r: u8, g: u8, b: u8 },
    Hex(u32),
}

#[derive(Debug)]
enum AppError {
    NotFound(String),
    Unauthorized,
    Internal(Box<dyn std::error::Error>),
}

impl fmt::Display for AppError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            AppError::NotFound(msg) => write!(f, "Not found: {}", msg),
            AppError::Unauthorized => write!(f, "Unauthorized"),
            AppError::Internal(e) => write!(f, "Internal error: {}", e),
        }
    }
}

impl std::error::Error for AppError {}

// --- Structs ---
#[derive(Debug, Clone)]
struct Point {
    x: f64,
    y: f64,
}

#[derive(Debug)]
struct User {
    id: u64,
    name: String,
    email: Option<String>,
    role: Role,
}

#[derive(Debug, Clone, Copy)]
enum Role {
    Admin,
    User,
    Guest,
}

// --- Traits ---
trait Describable {
    fn describe(&self) -> String;

    fn short_description(&self) -> String {
        format!("A {}", std::any::type_name::<Self>())
    }
}

trait Shape: Describable {
    fn area(&self) -> f64;
    fn perimeter(&self) -> f64;
}

// --- Trait implementations ---
impl Describable for Point {
    fn describe(&self) -> String {
        format!("Point({}, {})", self.x, self.y)
    }
}

struct Circle {
    center: Point,
    radius: f64,
}

impl Shape for Circle {
    fn area(&self) -> f64 {
        PI * self.radius * self.radius
    }

    fn perimeter(&self) -> f64 {
        2.0 * PI * self.radius
    }
}

impl Describable for Circle {
    fn describe(&self) -> String {
        format!("Circle at {:?} with radius {}", self.center, self.radius)
    }
}

// --- Generics with trait bounds ---
fn largest<T: PartialOrd>(list: &[T]) -> Option<&T> {
    let mut max = list.first()?;
    for item in &list[1..] {
        if item > max {
            max = item;
        }
    }
    Some(max)
}

// --- Lifetimes ---
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() { x } else { y }
}

struct TextParser<'a> {
    content: &'a str,
    position: usize,
}

impl<'a> TextParser<'a> {
    fn new(content: &'a str) -> Self {
        TextParser { content, position: 0 }
    }

    fn next_word(&mut self) -> Option<&'a str> {
        let remaining = &self.content[self.position..];
        let trimmed = remaining.trim_start();
        if trimmed.is_empty() {
            return None;
        }
        let start = self.content.len() - trimmed.len();
        let end = trimmed.find(' ').map_or(self.content.len(), |i| start + i);
        self.position = end;
        Some(&self.content[start..end])
    }
}

// --- Generic struct with where clause ---
struct Repository<T>
where
    T: Clone + fmt::Debug,
{
    items: HashMap<u64, T>,
    name: String,
}

impl<T: Clone + fmt::Debug> Repository<T> {
    fn new(name: &str) -> Self {
        Repository {
            items: HashMap::new(),
            name: name.to_string(),
        }
    }

    fn add(&mut self, id: u64, item: T) {
        self.items.insert(id, item);
    }

    fn get(&self, id: u64) -> Option<&T> {
        self.items.get(&id)
    }

    fn find<F>(&self, predicate: F) -> Option<&T>
    where
        F: Fn(&T) -> bool,
    {
        self.items.values().find(|item| predicate(item))
    }
}

// --- Closures and iterators ---
fn process_numbers(numbers: &[i32]) -> Vec<i32> {
    numbers
        .iter()
        .filter(|&&n| n > 0)
        .map(|&n| n * 2)
        .collect()
}

fn fibonacci() -> impl Iterator<Item = u64> {
    let mut state = (0u64, 1u64);
    std::iter::from_fn(move || {
        let current = state.0;
        state = (state.1, state.0.saturating_add(state.1));
        Some(current)
    })
}

// --- Pattern matching ---
fn describe_color(color: &Color) -> String {
    match color {
        Color::Red => "red".to_string(),
        Color::Green => "green".to_string(),
        Color::Blue => "blue".to_string(),
        Color::Custom { r, g, b } => format!("rgb({}, {}, {})", r, g, b),
        Color::Hex(value) => format!("#{:06x}", value),
    }
}

fn classify_number(n: i32) -> &'static str {
    match n {
        i32::MIN..=-1 => "negative",
        0 => "zero",
        1..=100 => "small positive",
        _ => "large positive",
    }
}

// --- Result chaining ---
fn parse_and_double(input: &str) -> Result<i32, AppError> {
    input
        .parse::<i32>()
        .map(|n| n * 2)
        .map_err(|e| AppError::Internal(Box::new(e)))
}

// --- Async ---
async fn fetch_data(url: &str) -> Result<String, AppError> {
    // Simulated async operation
    tokio::time::sleep(std::time::Duration::from_millis(100)).await;
    Ok(format!("Data from {}", url))
}

// --- Unsafe ---
unsafe fn dangerous_pointer_math(ptr: *const i32, offset: usize) -> i32 {
    *ptr.add(offset)
}

// --- Macros ---
macro_rules! create_map {
    ($($key:expr => $value:expr),* $(,)?) => {
        {
            let mut map = HashMap::new();
            $(map.insert($key, $value);)*
            map
        }
    };
}

// --- Const generics ---
struct Matrix<const ROWS: usize, const COLS: usize> {
    data: [[f64; COLS]; ROWS],
}

impl<const ROWS: usize, const COLS: usize> Matrix<ROWS, COLS> {
    fn zeros() -> Self {
        Matrix {
            data: [[0.0; COLS]; ROWS],
        }
    }
}

// --- Smart pointers ---
fn shared_counter() -> Arc<Mutex<i32>> {
    Arc::new(Mutex::new(0))
}

// --- Main ---
fn main() {
    // Strings
    let raw = r"no \n escapes";
    let raw_hash = r#"can contain "quotes" here"#;
    let byte_str = b"byte string";
    let escaped = "tab:\tnewline:\nnull:\0";

    // Numbers
    let hex = 0xff_00_ff;
    let binary = 0b1010_0101;
    let octal = 0o777;
    let float = 1_000.000_1;
    let scientific = 1.5e10;

    // Pattern matching
    let color = Color::Custom { r: 255, g: 128, b: 0 };
    println!("{}", describe_color(&color));

    // Iterators
    let numbers = vec![3, -1, 4, -1, 5, 9, -2, 6];
    let processed = process_numbers(&numbers);
    println!("{:?}", processed);

    // Fibonacci
    let first_ten: Vec<u64> = fibonacci().take(10).collect();
    println!("Fibonacci: {:?}", first_ten);

    // Macro
    let config = create_map! {
        "host" => "localhost",
        "port" => "8080",
        "debug" => "true",
    };
    println!("Config: {:?}", config);

    // Lifetimes
    let string1 = String::from("long string");
    let result;
    {
        let string2 = String::from("xyz");
        result = longest(string1.as_str(), string2.as_str());
        println!("Longest: {}", result);
    }

    // Repository
    let mut repo = Repository::new("users");
    repo.add(1, User {
        id: 1,
        name: "Alice".to_string(),
        email: Some("alice@example.com".to_string()),
        role: Role::Admin,
    });

    if let Some(user) = repo.get(1) {
        println!("Found: {:?}", user);
    }

    // Shared state
    let counter = shared_counter();
    {
        let mut count = counter.lock().unwrap();
        *count += 1;
    }
    println!("Counter: {}", counter.lock().unwrap());
}
