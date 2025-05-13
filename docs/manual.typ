// NAME: min-book manual
// TODO: review manual structure

#import "@preview/min-manual:0.1.0": manual, arg, univ

#show: manual.with(
  title: "Minimal Books",
  description: "Simple and complete books without introducing new syntax.",
  authors: "Maycon F. Melo <https://github.com/mayconfmelo>",
  package: "min-book:0.1.1",
  license: "MIT",
  logo: image("assets/manual-logo.png")
)


= Quick Start

```typ
#import "@preview/min-book:0.1.1": book
#show: book.with(
  title: "Book Title",
  subtitle: "Complementary subtitle, not more than two lines long",
  authors: "Author",
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
#import "@preview/min-book:0.1.1": book
#show: book.with(
  title: none,
  subtitle: none,
  authors: none,
  date: datetime.today(),
  cover: auto,
  titlepage: false,
  part: auto,
  chapter: auto,
  numbering-style: auto,
  toc: true,
  page-cfg: "a5",
  lang: "en",
  lang-data: toml("assets/lang.toml"),
  justify: true,
  line-space: 0.5em,
  par-margin: 0.75em,
  first-line-indent: 1em,
  margin: (x: 15%, y: 14%),
  font: ("Book Antiqua", "Times New Roman"),
  font-math: "Asana Math",
  font-size: 11pt,
)
```

Seems like an awful lot to start with, but let's just break down all this to
understand it better, shall we?

#arg("title: <- string | content <required>")[
  The main title of the book.
]

#arg("subtitle: <- string | content | none")[
  The book subtitle; generally two lines long or less.
]

#arg("authors: <- string | array <required>")[
  A string or array containing the name of each author of the book, in format
  `( NAME, NAME )`.
]

#arg("date: <- array | auto")[
  The book publication date, in format `(yyyy, mm, dd)`. Fallback to current
  date if not set, or set to `auto`.
]

#arg("cover: <- auto | content | none")[
  The book cover; `auto`matically generates a default cover, or set a custom
  `content` as cover.
]

#arg("titlepage: <- boolean | content")[
  The page after the cover; by default, contains the title, subtitle, author,
  and year of publication. It is possible to create the titlepage using a
  `content` block.
]

#arg("part: <- auto | string | none")[
  The name given to the book's main divisions --- something like LaTeX's
  ```tex \part``` command; when `auto` an automatic name will be retrieved
  from `#book(lang-data)` file.
]

#arg("chapter: <- string | none")[
  The name given to the book's main sections --- something like LaTeX's
  ```tex \chapter``` command; when `auto` an automatic name will be retrieved
  from `#book(lang-data)` file.
]

#arg("numbering-style: <- auto | array | string | none")[
  Defines a custom heading numbering. Can be a standard numbering string, or a
  #univ("numbly") numbering array in more complex cases.
]

#arg("toc: <- boolean")[
  Defines whether the book will have a table of contents or not.
]

#arg("page-cfg: <- string | dictionary")[
  If _dictionary_, used as `#set page(..page-cfg)`; if _string_, used as
  `#set page(paper: page-cfg)`.
]

#arg("lang: <- string")[
  Defines the language of the written text.
]

#arg("lang-data: <- toml")[
  A TOML translation file; the current structure can be found in the default
  `src/assets/lang.toml` file.
]

#arg("justify: <- boolean")[
  Defines if the text will have justified alignment.
]

#arg("line-space: <- length")[
  Defines the space between lines in the document.
]

#arg("par-margin: <- length")[
  Defines the margin space after each paragraph. Set it the same as `line-space`
  to remove get paragraphs without additional space in between.
]

#arg("first-line-indent: <- length")[
  Defines the first line indentation of all paragraphs, but the first one, in a sequence of paragraphs.
]

#arg("margin: <- length")[
  Defines the document margins.
]

#arg("font: <- string | array")[
  Defines the font families used for the text: a principal font and its fallback.
]

#arg("font-math: <- string | array")[
  Defines the font families used for the math and equations: a principal font
  and its fallback.
]

#arg("font-size: <- length")[
  Defines the size of the text in the document.
]


= Book Parts

Some larger books are internally divided into multiple _parts_. This structure
allows to better organize and understand a text with multiple sequential plots,
or tales, or time jumps, or anything that internally differentiate parts of the
story. While the name used here is _part_, different books uses different names
for it: parts, subjects, books, acts, units, modules, etc.

By default, every _level 1 heading_ is a part named as _"Part"_ in `text.lang`
document language; setting `#book(part)` change this name, or disable parts if
set to `none`.

```typ
#show: book.with(
  part: "Act",
)
= This heading is the Act 1 part
```


= Book Chapters

In most cases, books are divided into smaller sections called chapters.
Generally, each chapter contains a single minor story, or event, or scene,
or any type of subtle plot change.

Chapters are smart: by default, every _level 2 heading_ is a chapter named
_"Chapter"_ in `text.lang` document language, when parts are enabled; but when
parts are disabled, every _level 1 heading_ will be a chapter. Setting
`#book(chapter)` change the default chapter name, or disable chapters if set to
`none`.

```typ
#show: book.with(
  chapter: "Scene",
)
== This is Scene 1 chapter

#show: book.with(
  part: none,
  chapter: "Scene",
)
= This is Scene 1 chapter
```


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

Additionally, `#book(numbering-style)` can be set to override the default
numbering above.


= Additional Features

As said before, this package does not introduce any new syntax nor commands to
write a complete book. But, well... it does offers some additional commands.
These are completely optional and are available only by explicit import,
separate from the `#book` main function:


== Note Command

Adds end notes to the book. End notes are more common in books than footnotes,
and while footnotes appear at the footer of the same page, end notes appears at
its own page at the end of the current section, right before the next heading:

#pagebreak()

```typ
#import "@preview/min-book:0.1.1": note
 
= Current heading

This text have an end note#note[This is an end note]

// The end note will automatically appear here.

= Next heading
```


== Horizontal Rule Command

Adds horizontal rules, used to separate subtle changes of subject in book texts.
Can be called by its name or its alias:

```typ
#import "@preview/min-book:0.1.1": horizontalrule, hr

This text have a subject.

#horizontalrule()

This text have another subject.

#hr()

And this text have some other subject.
```

This command have the following optional arguments:

#arg("```typc symbol: [#sym.ast.op #sym.ast.op #sym.ast.op]``` <- content")[
  Defines the content at the center of the horizontal rule. By default, its line
  is struck by three #sym.ast.op in its center.
]

#arg("```typc spacing: 1em``` <- length")[
  Defines the vertical space before and after the horizontal rule.
]

#arg("```typc line-size: 15%``` <- length")[
  Defines the size of the horizontal rule line.
]


== Block Quote Command

Adds a block version of the `quote` command. In fact, it is just a simple
wrapper of ```typc quote(block: true)``` with some modifications:

```typ
#import "@local/min-book:0.1.1": blockquote

#blockquote(by: "Einstein")[
  Don't believe everything you read on the internet.
]
```


== Appendices Command

Creates an special ambient to write or include multiple appendices. An appendix
is any important additional data left out of the main document for some reason,
but directly referenced or needed by it.

```typ
#import "@local/min-book:0.1.1": appendices

#appendices(
  title: auto,
  numbering-style: auto,
  body
)
```

#arg("title <- auto | array")[
  Set custom singular and plural titles for appendices. An array in
  `(SINGULAR, PLURAL)` format for "Appendices" and "Appendix" custom titles
  respectivelly; when `auto`, set as `#book(lang-data.appendix)` value.
]

#arg("numbering-style <- auto | array | string")[
  Set custom numbering style for appendices. Can be a numbly numbering array or
  a standard numbering string;  when `auto`, set as:
  
  ```
  (
    "",
    "{2:A}.\n",
    "{2:A}.{3:1}. ",
    "{2:A}.{3:1}.{4:1}. ",
    "{2:A}.{3:1}.{4:1}.{5:1}. ",
    "{2:A}.{3:1}.{4:1}.{5:1}.{6:a}. ",
  )
  ```
]

#arg("body <- content")[
  The appendices content; every _level 1 heading_ will be treated as a new
  appendix.
]


== Annexes Command

Creates an special ambient to write or include multiple annexes, with special
heading styling. An annex is any important third-party data directly cited or
referenced in the main document.

```typ
#import "@local/min-book:0.1.1": annexes

#annexes(
  title: auto,
  numbering-style: auto,
  body
)
```

#arg("title <- auto | array")[
  Set custom singular and plural titles for annexes. An array in
  `(SINGULAR, PLURAL)` format for "Annexes" and "Annex" custom titles
  respectivelly; when `auto`, set as `#book(lang-data.annex)` value.
]

#arg("numbering-style <- auto | array | string")[
  Set custom numbering style for appendices. Can be a numbly numbering array or
  a standard numbering string;  when `auto`, set as:
  
  ```
  (
    "",
    "{2:A}.\n",
    "{2:A}.{3:1}. ",
    "{2:A}.{3:1}.{4:1}. ",
    "{2:A}.{3:1}.{4:1}.{5:1}. ",
    "{2:A}.{3:1}.{4:1}.{5:1}.{6:a}. ",
  )
  ```
]

#arg("body <- content")[
  The annexes content; every _level 1 heading_ will be treated as a new
  annex.
]


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT terms and rights. \
The manual source code is free software:
you are free to change and redistribute it.  There is NO WARRANTY, to the extent
permitted by law.

The logo was obtained from #link("https://flaticon.com")[Flaticon] website.