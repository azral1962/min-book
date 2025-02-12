#import "@preview/min-book:0.1.0": (
  book, note, horizontalrule, hr, blockquote
)

#show: book.with(
  title: "Book Title",
  subtitle: "Complementary subtitle, not more than two lines long",
  authors: "Author",
  date: (2025, 01, 12),
  titlepage: true,
  cover: image("assets/cover.jpeg"),
  paper: "a5",
  part: "Subject",
  chapter: "Detail",
)


= Heading Levels

== Level 2

=== Level 3

==== Level 4

===== Level 5

====== Level 6


= Default Elements


== Page Space

#lorem(230)


== Paragraphs Style

#lorem(45)

#lorem(45)

#lorem(45)

#lorem(45)

#lorem(25)


== Quotes

Inline quotation: #quote[#lorem(25)].

#blockquote(by: "Einstein")[
  Don't believe everything you read on the internet.
]

#lorem(45)

#pagebreak()


== Lists


=== Simple lists

#lorem(25)

- Item A
- Item B
- Item C

#lorem(25)


=== Numbered lists

#lorem(25)

+ Item A
+ Item B
+ Item C

#lorem(25)

#pagebreak()


== Terms

#lorem(25)

/ Foo: #lorem(8)
/ Bar: #lorem(8)
/ Baz: #lorem(8)

#lorem(25)


== Raw Code

This is an inline Rust raw code: ```rust prinln!()``` and ```rust main()```


```rust
// This is a block Rust raw code:
fn main() {
    println!("Hello World!");
}
```

#lorem(25)


= Optional Commands


== Endnotes

This text have the first note.#note[This note will appear at the end of this heading.]
And here it comes the second one!#note[A ```typm #pagebreak()``` will be inserted before and after it.]


== Horizontal Rule

#lorem(45)

#horizontalrule()

#lorem(45)

#hr()

#lorem(45)

