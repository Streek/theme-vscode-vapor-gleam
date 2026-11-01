# Vapor Gleam Theme - Markdown Syntax Test

This file exercises all **markup** token scopes targeted by the theme.

Expected token colors:
- Headings: `#ffffff` **bold**
- Bold: `#e0def4` **bold**
- Italic: `#e0def4` *italic*
- Underline: underline style
- Blockquotes: `#6c7086` *italic*
- Inline code / fenced code: `#f2cb7c`
- Invalid: `#ffc1eb` **bold underline**

---

## Heading Level 2

### Heading Level 3

#### Heading Level 4

##### Heading Level 5

###### Heading Level 6

---

## Inline Formatting

This is **bold text** and this is *italic text* and this is ***bold italic***.

This is ~~strikethrough~~ text.

This is `inline code` in a sentence.

This is a [link](https://example.com) and this is a [reference link][ref].

[ref]: https://example.com "Reference Link Title"

---

## Blockquotes

> This is a blockquote.
> It can span multiple lines.

> Nested blockquotes:
>
> > This is a nested blockquote.
> > > And a deeply nested one.

---

## Lists

### Unordered
- Item one
- Item two
  - Nested item
  - Another nested item
    - Deeply nested
- Item three

### Ordered
1. First item
2. Second item
   1. Sub-item A
   2. Sub-item B
3. Third item

### Task List
- [x] Completed task
- [ ] Incomplete task
- [x] Another completed task

---

## Code Blocks

### Fenced (backticks)

```typescript
const greeting: string = "Hello, Vapor Gleam!";
console.log(greeting);
```

```python
def greet(name: str) -> str:
    return f"Hello, {name}!"
```

```gleam
pub fn main() {
  io.println("Hello from Gleam!")
}
```

```rust
fn main() {
    println!("Hello from Rust!");
}
```

```json
{
  "name": "vapor-gleam",
  "version": "1.0.1"
}
```

```css
:root {
  --accent: #ffc1eb;
}
```

```bash
echo "Hello from shell"
npm run package
```

### Indented code block

    This is an indented code block.
    It preserves whitespace.
    Four spaces of indentation.

---

## Tables

| Token Type | Color   | Style  |
|------------|---------|--------|
| Comment    | #6c7086 | italic |
| Keyword    | #c4a7e7 | bold   |
| Function   | #8bbec7 | -      |
| Type       | #ffc1eb | -      |
| String     | #7dd3fc | -      |
| Number     | #e4c87b | -      |

---

## Images

![Vapor Gleam Screenshot](https://example.com/screenshot.png "Theme preview")

---

## Horizontal Rules

***

---

___

---

## HTML in Markdown

<details>
<summary>Click to expand</summary>

This is hidden content inside a details/summary block.

- It supports **markdown** inside.
- And `inline code` too.

</details>

<div align="center">
  <strong>Centered bold text in HTML</strong>
</div>

---

## Footnotes

Here is a sentence with a footnote[^1].

[^1]: This is the footnote content.

---

## Abbreviations

The HTML specification is maintained by the W3C.

*[HTML]: HyperText Markup Language
*[W3C]: World Wide Web Consortium

---

## Math (if supported)

Inline math: $E = mc^2$

Block math:

$$
\sum_{i=1}^{n} i = \frac{n(n+1)}{2}
$$

---

## Escapes

\*not italic\* \`not code\` \[not a link\]

---

## Raw URLs

https://example.com is auto-linked in some renderers.
