#import "@preview/min-manual:0.1.0": manual, arg, univ

#show: manual.with(
  title: "Minimal Books",
  description: "Simple and complete books without introducing new syntax.",
  authors: "Maycon F. Melo <https://github.com/mayconfmelo>",
  cmd: "min-book",
  version: "0.1.0",
  license: "MIT",
  logo: image("assets/manual-logo.png")
)


= Quick Start

```typ
#import "@preview/min-book:0.1.0": book
#show: book.with(
  title: "Book Title",
  subtitle: "Complementary subtitle, not more than two lines long",
  authors: "Author",
  cover: image("assets/cover.jpeg"),
)
```


= Description

Generate complete and complex books, without any annoying new commands or syntax,
just good old pure Typst. This package works by manipulating the standard Typst
elements, adapting them to the needs of a book structure. All of this is managed
behind the scenes, so that nothing changes in the Typst code itself.

While it is possible to play with complex structures, such as parts and chapters
and creative numbering, this package comes with several ready to use default
values; so its really up to you to customize it your way or ride along the
defaults and just start writing: both ways are possible and encouraged.

This manual will be updated only when new versions break or modify something;
otherwise, it will be valid to all newer versions starting by the one documented
here.

#pagebreak()


= Options

Those are the full list of options available and its default values:

```typm
#import "@preview/min-book:0.1.0": book
#show: book.with(
  title: none,
  subtitle: none,
  authors: none,
  date: auto,
  cover: none,
  titlepage: true,
  part: "Part",
  chapter: "Chapter",
  numbering-style: none,
  toc: true,
  paper: "a5",
  lang: "en",
  justify: true,
  line-space: 0.5em,
  par-margin: 0.75em,
  first-line-indent: 1em,
  margin: 15%,
  font: ("Book Antiqua", "Times New Roman"),
  font-size: 11pt,
)
```

Seems like an awful lot to start with, but let's just break down all this to
understand it better, shall we?

#arg(
  "title:", ("string", "content"),
  required: true
)[
  The main title of the book.
]

#arg(
  "subtitle:", ("string", "content", "none")
)[
  The book subtitle; generally two lines long or less.
]

#arg(
  "authors:", ("string", "array"),
  required: true
)[
  A string or array containing the name of each author of the book, in format
  `( NAME, NAME )`.
]

#arg(
  "date:", ("array", "auto")
)[
  The book publication date, in format `(yyyy, mm, dd)`. Fallback to current
  date if not set, or set to `auto`.
]

#arg(
  "cover:", ("image", "content", "none")
)[
  The book cover. Instead of using a image, it is possible to create the cover
  using a `content` block.
]

#arg(
  "titlepage:", ("boolean", "content")
)[
  The page after the cover; by default, contains the title, subtitle, author,
  and year of publication. It is possible to create the titlepage using a
  `content` block.
]

#arg(
  "part:", ("string", "none")
)[
  The name given to the book's main divisions --- something like LaTeX's
  ```tex \part``` command.
]

#arg(
  "chapter:", ("string", "none")
)[
  The name given to the book's main sections --- something like LaTeX's
  ```tex \chapter``` command.
]

#arg(
  "numbering-style:", ("array", "string", "none")
)[
  Defines a custom heading numbering. Can be a standard numbering string, or a
  #univ("numbly") numbering array in more complex cases.
]

#arg(
  "toc:", "boolean"
)[
  Defines whether the book will have a table of contents or not.
]

#arg(
  "paper:", "string"
)[
  Defines the page paper type --- and its size therefore.
]

#arg(
  "lang:", "string"
)[
  Defines the language of the written text.
]

#arg(
  "justify:", "boolean"
)[
  Defines if the text will have justified alignment.
]

#arg(
  "line-space:", "length"
)[
  Defines the space between lines in the document.
]

#arg(
  "par-margin:", "length"
)[
  Defines the margin space after each paragraph. Set it the same as `line-space`
  to remove get paragraphs without additional space in between.
]

#arg(
  "first-line-indent:", "length"
)[
  Defines the first line indentation of all paragraphs, but the first one, in a sequence of paragraphs.
]

#arg(
  "margin:", "length"
)[
  Defines the document margins.
]

#arg(
  "font:", ("string", "array")
)[
  Defines the font families used for the text: a principal font and its fallback.
]

#arg(
  "font-size:", "length"
)[
  Defines the size of the text in the document.
]


= Book Parts

Some larger books are internally divided into multiple _parts_. This feature
allows to better organize and understand a text with multiple sequential plots,
or tales, or time jumps, or anything that internally differentiate parts of the
story. While the name used here is _part_, different books uses different names
for it: parts, subjects, books, acts, etc.

Parts are used in a smart way: when enabled, every level 1 headings are turned
into _book parts_ automatically. To enable, just give a string value to the
`part` argument; and to disable it, set to `none`:

```typ
// Enable part with name "Act":
#show: book.with(
  part: "Act",
)

= This is Act 1

// Disable part to turn it back to normal.
#show: book.with(
  part: none,
)

= This is a normal level 1 heading
```


= Book Chapters

In most cases, books are divided into smaller sections called chapters.
Generally, each chapter contains a single minor story, or event, or scene,
or any type of subtle plot change.

Chapters are used in a smart way, too, depending of the use of
_book parts_: if _parts_ are enabled, every level 2 headings are turned into
_book chapters_; but if _parts_ are disabled, all level 1 headings are turned
into _book chapters_. Seems complex, but it turns to be very intuitive:

```typ
// Book with parts and chapters:
#show: book.with(
  part: "Act",
  chapter: "Scene",
)

= This is Act 1

== This is Scene 1

// Book with just chapters:
#show: book.with(
  part: none,
  chapter: "Scene"
)

= This is Scene 1

// Boom with no part, nor chapter:
#show: book.with(
  part: none,
  chapter: none,
)

= This is a level 1 heading

== This is a level 2 heading
```

#pagebreak()


= Advanced Numbering

The book headings can be numbered two ways: using a standard numbering string,
or a #univ("numbly") numbering array. While numbering strings are indicated for
simpler cases, the numbly arrays are used in more complex book numbering.

By default, when the book have _parts_ enabled, the following numbering is used:

```typ
(
  "{1:I}:\n",
  "{2:I}.\n",
  "{2:I}.{3:1}.\n",
  "{2:I}.{3:1}.{4:1}.\n",
  "{2:I}.{3:1}.{4:1}.{5:1}.\n",
  "{2:I}.{3:1}.{4:1}.{5:1}.{6:a}.\n"
)
```

But when the _parts_ are disabled, the following numbering is used:

```typ
(
  "{1:I}.\n",
  "{1:I}.{2:1}.\n",
  "{1:I}.{2:1}.{3:1}.\n",
  "{1:I}.{2:1}.{3:1}.{4:1}.\n",
  "{1:I}.{2:1}.{3:1}.{4:1}.{5:1}.\n",
  "{1:I}.{2:1}.{3:1}.{4:1}.{5:1}.{6:a}.\n"
)
```

Additionally, a `numbering-style` argument can be set to override these default
numbering above.


= Additional Features

As said before, this package does not introduce any new syntax nor commands to
write a complete book. But, well... it does offers some additional commands.
These are completely optional and are available only by explicit import,
separate from the `book` main function:


== Note Command

Adds end notes to the book. End notes are more common in books than footnotes,
and while footnotes appear at the footer of the same page, end notes appears at
its own page at the end of the current section, right before the next heading:

#pagebreak()

```typ
#import "@preview/min-book:0.1.0": note
 
= Current heading

This text have an end note#note[This is an end note]

// The end note will automatically appear here.

= Next heading
```


== Horizontal Rule Command

Adds horizontal rules, used to separate subtle changes of subject in book texts.
Can be called by its name or its alias:

```typ
#import "@preview/min-book:0.1.0": horizontalrule, hr

This text have a subject.

#horizontalrule()

This text have another subject.

#hr()

And this text have some other subject.
```

This command have the following optional arguments:

#arg(
  ```typc symbol: [#sym.ast.op #sym.ast.op #sym.ast.op]```, "content"
)[
  Defines the content at the center of the horizontal rule. By default, its line
  is struck by three #sym.ast.op in its center.
]

#arg(
  ```typc spacing: 1em```, "length"
)[
  Defines the vertical space before and after the horizontal rule.
]

#arg(
  ```typc line-size: 15%```, "length"
)[
  Defines the size of the horizontal rule line.
]

#pagebreak()


== Block Quote Command

Adds a block version of the `quote` command. In fact, it is just a simple
wrapper of ```typc quote(block: true)``` with some modifications:

```typ
#import "@local/min-book:0.1.0": blockquote

#blockquote(by: "Einstein")[
  Don't believe everything you read on the internet.
]
```


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT terms and rights. \
The manual source code is free software:
you are free to change and redistribute it.  There is NO WARRANTY, to the extent
permitted by law.

The logo was obtained from #link("https://flaticon.com")[Flaticon] website.