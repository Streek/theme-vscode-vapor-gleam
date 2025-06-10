import gleam/io

pub fn main() {
  // Call a function with another function
  echo twice(1, add_one)
  io.println("This is a test of functions in Gleam." ++ io.newline())

  // Functions can be assigned to variables
  let my_function = add_one
  echo my_function(100)
}

fn twice(argument: Int, passed_function: fn(Int) -> Int) -> Int {
  passed_function(passed_function(argument))
}

fn add_one(argument: Int) -> Int {
  argument + 1
}
