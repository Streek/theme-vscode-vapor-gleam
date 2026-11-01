#!/usr/bin/env bash
# =============================================================================
# Vapor Gleam Theme - Shell Script Syntax Test
# =============================================================================
# Exercises: variables, string quoting, command substitution, arrays,
# functions, conditionals, loops, heredocs, process substitution, traps,
# arithmetic, parameter expansion, regex matching.
# =============================================================================

set -euo pipefail
IFS=$'\n\t'

# --- Constants ---
readonly MAX_RETRIES=5
readonly PI="3.14159"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly LOG_FILE="${SCRIPT_DIR}/output.log"

# --- Variables ---
name="Vapor Gleam"
version="1.0.1"
debug=${DEBUG:-false}
counter=0

# --- Arrays ---
colors=("red" "green" "blue" "magenta" "cyan")
declare -A color_codes=(
  [red]="#ff6b6b"
  [green]="#e4c87b"
  [blue]="#8bbec7"
  [magenta]="#ffc1eb"
  [cyan]="#8bbec7"
)

# --- Functions ---
log() {
  local level="${1:-INFO}"
  local message="${2:-}"
  local timestamp
  timestamp="$(date '+%Y-%m-%d %H:%M:%S')"
  printf '[%s] [%s] %s\n' "$timestamp" "$level" "$message" | tee -a "$LOG_FILE"
}

die() {
  log "ERROR" "$1"
  exit "${2:-1}"
}

usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Options:
  -h, --help      Show this help message
  -v, --verbose   Enable verbose output
  -n, --name NAME Set the name (default: $name)
  -d, --debug     Enable debug mode

Examples:
  $(basename "$0") --name "My Theme" --verbose
  $(basename "$0") -d -n Test
EOF
}

# --- Argument parsing ---
verbose=false
while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    -v|--verbose)
      verbose=true
      shift
      ;;
    -n|--name)
      name="${2:?Name argument required}"
      shift 2
      ;;
    -d|--debug)
      debug=true
      shift
      ;;
    --)
      shift
      break
      ;;
    -*)
      die "Unknown option: $1" 2
      ;;
    *)
      break
      ;;
  esac
done

# --- Conditionals ---
if [[ "$debug" == "true" ]]; then
  set -x
  log "DEBUG" "Debug mode enabled"
fi

if [[ -f "$LOG_FILE" ]]; then
  log "INFO" "Log file exists: $LOG_FILE"
elif [[ -d "$SCRIPT_DIR" ]]; then
  touch "$LOG_FILE" || die "Cannot create log file"
fi

# Test operators
if [[ -n "$name" && -z "${undefined_var:-}" ]]; then
  log "INFO" "Name is set: $name"
fi

# Numeric comparison
if (( counter < MAX_RETRIES )); then
  log "INFO" "Counter ($counter) is less than max ($MAX_RETRIES)"
fi

# Regex matching
email="test@example.com"
if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
  log "INFO" "Valid email: $email (match: ${BASH_REMATCH[0]})"
fi

# --- Loops ---
for color in "${colors[@]}"; do
  code="${color_codes[$color]:-unknown}"
  printf '  %s: %s\n' "$color" "$code"
done

for i in {1..5}; do
  echo "Iteration $i"
done

for file in "$SCRIPT_DIR"/*.sh; do
  [[ -f "$file" ]] || continue
  echo "Found: $(basename "$file")"
done

while IFS= read -r line; do
  echo "Line: $line"
done < <(printf '%s\n' "first" "second" "third")

# --- Parameter expansion ---
filename="/path/to/theme.color-theme.json"
echo "Extension: ${filename##*.}"
echo "Basename: ${filename##*/}"
echo "Directory: ${filename%/*}"
echo "No ext: ${filename%.*}"
echo "Uppercase: ${name^^}"
echo "Lowercase: ${name,,}"
echo "Replace: ${name// /-}"
echo "Substring: ${name:0:5}"
echo "Length: ${#name}"
echo "Default: ${undefined:-default_value}"

# --- Arithmetic ---
result=$(( (5 + 3) * 2 - 1 ))
echo "Result: $result"

(( counter++ ))
(( counter += 10 ))

# --- Command substitution ---
current_date="$(date '+%Y-%m-%d')"
file_count=$(find "$SCRIPT_DIR" -name '*.sh' -type f | wc -l)
kernel="$(uname -s)"

# --- Process substitution ---
diff <(echo "hello") <(echo "world") || true

# --- Heredoc ---
cat <<-HEREDOC
	Theme: $name
	Version: $version
	Date: $current_date
	Files: $file_count
HEREDOC

# Heredoc with no expansion
cat <<'NO_EXPAND'
$name is not expanded here
$(commands) are not run
NO_EXPAND

# --- Trap ---
cleanup() {
  log "INFO" "Cleaning up..."
  rm -f "${TMPDIR:-/tmp}/vapor-gleam-$$"
}
trap cleanup EXIT INT TERM

# --- Subshell and pipes ---
(
  cd "$SCRIPT_DIR" || exit 1
  ls -la
) | head -5

echo "${colors[@]}" | tr ' ' '\n' | sort | uniq -c | sort -rn

# --- Exit ---
log "INFO" "Done. Theme: $name v$version"
exit 0
