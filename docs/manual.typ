// NAME: Manual for min-book

#import "@preview/min-manual:0.1.1": manual, arg, univ, url

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
  edition: 0,
  volume: 0,
  authors: none,
  date: datetime.today(),
  cover: auto,
  titlepage: auto,
  catalog: none,
  errata: none,
  dedication: none,
  acknowledgements: none,
  epigraph: none,
  toc: true,
  part: auto,
  chapter: auto,
  cfg: auto,
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

#arg("volume: <- int")[
  The book series volume number; used when the same story is told through multiple
  books, in order.
]

#arg("edition: <- int")[
  The book publication number; used when the content is cjanged or updated after
  tue book release.
]

#arg("authors: <- string | array <required>")[
  A string or array of strings containing the names of each author of the book.
]

#arg("date: <- array | dictionary")[
  The book publication date; can be a `(yyyy, mm, dd)` array or a
  `(year: yyyy, month: mm, day: dd)` dictionary, and defaults to current date
  if not set.
]

#arg("cover: <- auto | content | none")[
  The book cover content; when `auto`, generates an automatic cover.
]

#arg("titlepage: <- auto | content")[
  The presentation page content, shown after the cover; when `auto`, generates
  an automatic title page.
]

#arg("catalog: <- none | dictionary")[
  Set the data for the "cataloging in publication" board; a dictionary that can
  have the following keys:
]

#arg("catalog.id: <- string | content")[
  A #url("http://www.cutternumber.com/")[Cutter-Sanborn identification code],
  used to identify the book author.
]

#arg("catalog.place: <- string | content")[
  The city or region where the book was published.
]

#arg("catalog.publisher: <- string | content")[
  The organization or person responsible for releasing the book.
]

#arg("catalog.isbn: <- string | content")[
  The _International Standard Book Number_, used to indentify the book.
]

#arg("catalog.subjects: <- array")[
  A list of subjects related to the book; must be an array os strings.
]

#arg("catalog.access: <- array")[
  A list of access points used to find the book in catalogues, like by `"Title"`
  or `"Series"`; must be an array of strings.
]

#arg("catalog.ddc: <- string | content")[
  A #url("https://www.oclc.org/content/dam/oclc/dewey/ddc23-summaries.pdf")[Dewey Decimal Classification]
  number, which corresponds to the specific category of the book.
]

#arg("catalog.udc: <- string | content")[
  An #url("https://udcsummary.info/php/index.php")[Universal Decimal Classification]
  number, which corresponds to the specific category if the book.
]

#arg("catalog.before: <- content")[
  Content showed before (above) the cataloging in publication board; generally
  editorial data like publisher, editors, reviewers, copyrights, etc.
]

#arg("catalog.after: <- content")[
  Content showed after (below) the cataloging in publication board; generally
  additional information that complements the board data.
]

#arg("errata: <- content")[
  A text that corrects important errors from previous book editions.
]

#arg("dedication: <- content")[
  A brief text that dedicates the book in honor or in memorian of someone
  important; can accompany a small message directed to the person.
]

#arg("acknowledgements: <- content")[
  A brief text to recognize everyone who helped directly or indirectly in the
  process of book creation and their importance in the project.
]

#arg("epigraph: <- quote | content")[
  A short citation or excerpt of other works used to introduce the main theme of
  the book; can suggest a reflection, a mood, or idea related to the text.
]

#arg("toc: <- boolean")[
  Defines if the book will have a table of contents.
]

#arg("part: <- auto | string | none")[
  The name of the main divisions of the book; when `auto`, try to retrieve the
  translation for "Part" in `#text.lang` from `#book(lang-data)`, or fallback to
  English.
]

#arg("chapter: <- string | none")[
  The name of the sections of the book; when `auto`, try to retrieve the
  translation for "Chapter" in `#text.lang` from `#book(lang-data)`, or fallback
  to English.
]

#arg("cfg: <- dictionary")[
  Set custom advanced configurations; used to fine-tune some aspects of the
  book, mostly aesthetic formatting. If your focus is to just write a book in
  English without worry about code, just ignore it; otherwise, refer to @adv-config
  to check the supported configurations.
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


= Additional Commands

As said before, this package does not requires any new syntax nor commands to
write a complete book. But, well... it does offers some additional commands.
These are completely optional and exists only to facilitate the book writing
process; it is perfectly possible to write an entire book without them.


== Note Command

```typ
#import "@preview/min-book:0.1.1": note

#note(
  numbering-style: auto,
  content,
)
```

Adds end notes to the book. End notes are more common than footnotes in books,
and while footnotes appear at the footer of the current page, end notes appears
at its own page at the end of the current section, right before the next heading.

#arg("numbering-style: <- auto | array | string")[
  Defines a custom note numbering from this note onwards; can be a standard
  numbering string, or a #univ("numbly") numbering array.
]

#arg("content <- content <required>")[
  The content of the end note.
]


== Horizontal Rule Command

```typ
#import "@preview/min-book:0.1.1": horizontalrule

#horizontalrule(
  symbol: [#sym.ast.op #sym.ast.op #sym.ast.op],
  spacing: 1em,
  line-size: 15%,
)
```

Adds a horizontal rule, visual separators used to distinguish subtle changes of
subject in extensive texts. Also available as the smaller `#hr` alias.

#arg("symbol: <- content")[
  Defines the content of a decoration in the middle of tue horizontal rule;
  defaults to three asterisks.
]

#arg("spacing: 1em <- length")[
  The vertical space before and after the horizontal rule.
]

#arg("line-size: 15% <- length")[
  The sizes of the lines at each side in the horizontal rule.
]


== Block Quote Command

```typ
#import "@local/min-book:0.1.1": blockquote

#blockquote(
  by: none,
  ..args
)
```

Simple alias to add a `#quote(block:true)` command.


#arg("by: <- string | content")[
  A shorter alias of `#cite(attribution)`.
]

#arg("..args <- arguments")[
  Any argument supported by `#cite`.
]


== Appendices Command

```typ
#import "@local/min-book:0.1.1": appendices

#appendices(
  title: auto,
  numbering-style: auto,
  body
)
```

Creates an special ambient to write or include multiple appendices. An appendix
is any important additional data left out of the main document for some reason,
but directly referenced or needed by it.

#arg("title <- auto | array")[
  An array of strings with singular and plural titles for appendices, respectively;
  when `auto`, try to retrieve the translations for "Appendix" and "Appendices"
  in `#text.lang` from `#book(lang-data)`, or fallback to English.
]

#arg("numbering-style <- auto | array | string")[
  Defines a custom heading numbering for appendices; can be a standard numbering
  string, or a #univ("numbly") numbering array. When `auto`, uses:
  
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

```typ
#import "@local/min-book:0.1.1": annexes

#annexes(
  title: auto,
  numbering-style: auto,
  body
)
```

Creates an special ambient to write or include multiple annexes. An annex is any
important third-party data directly cited or referenced in the main document.

#arg("title <- auto | array")[
  An array of strings with singular and plural titles for annexes, respectively;
  when `auto`, try to retrieve the translations for "Annex" and "Annexes"
  in `#text.lang` from `#book(lang-data)`, or fallback to English.
]

#arg("numbering-style <- auto | array | string")[
  Defines a custom heading numbering for annexes; can be a standard numbering
  string, or a #univ("numbly") numbering array. When `auto`, uses:
  
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


= Advanced Configurations <adv-config>

```typ
#import "@local/min-book:0.1.1": book

#book.with(
  cfg: (
    numbering-style: auto,
    page-cfg: "a5",
    lang: "en",
    lang-data: toml("assets/lang.toml"),
    justify: true,
    line-space: 0.5em,
    par-margin: 0.65em,
    first-line-indent: 1em,
    margin: (x: 15%, y: 14%),
    font: ("Book Antiqua", "Times New Roman"),
    font-math: "Asana Math",
    font-size: 11pt,
    heading-weight: auto,
  ),
)
```

These configurations allows to modify certain aspects of the book and better
control its appearence. They are built with rebust defaults in mind, so that
a casual writer can safely ignore it and _just write_ , and in most cases it
will be used for simple tasks such as change the language or fonts.

#arg("cfg.numbering-style: <- auto | array | string | none")[
  Defines a custom heading numbering; can be a standard numbering string, or a
  #univ("numbly") numbering array.
]

#arg("cfg.page-cfg: <- dictionary | string")[
  Set page configuration, acting as `#set page(..page-cfg)`; when string, act as
  `#set page(paper: page-cfg)`.
]

#arg("cfg.lang: <- string")[
  Defines the language of the written text (`text.lang`).
]

#arg("cfg.lang-data: <- toml")[
  A TOML translation file; the file structure can be found in the default
  `src/assets/lang.toml` file.
]

#arg("cfg.justify: <- boolean")[
  Defines if the text will have justified alignment.
]

#arg("cfg.line-space: <- length")[
  Defines the space between lines in the document.
]

#arg("cfg.par-margin: <- length")[
  Defines the margin space after each paragraph. Set it the same as
  `#book(line-space)` to get paragraphs without additional space between them.
]

#arg("cfg.first-line-indent: <- length")[
  Defines the first line indentation of all paragraphs but the first one, in a
  sequence of paragraphs.
]

#arg("cfg.margin: <- length")[
  Defines the document margins.
]

#arg("cfg.font: <- string | array")[
  Defines the font families used for the text; the default font is specified in
  `README.md` file.
]

#arg("cfg.font-math: <- string | array")[
  Defines the font families used for the math and equations; the default font is
  specified in `README.md` file.
]

#arg("cfg.font-size: <- length")[
  Defines the size of the text in the document.
]

#arg("cfg.heading-weight: <- string | auto")[
  Defines the font weight of headings; by default, headings level 1--5 are
  `"regular"` and levels above it are `"bold"`, but `#book(cfg.heading-weight)`
  apply the same weight for all headings.
]


= Advanced Numbering

The book headings can be numbered two ways: using a standard numbering string,
or a #univ("numbly") numbering array. While numbering strings are indicated for
simpler cases, the numbly arrays are used in more complex book numbering.

By default, when `#book(part)` is enabled, the following numbering is used:

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

But when `#book(part: none)`, the following numbering is used:

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

Additionally, a custom `#book(numbering-style)` can be set to override the default
numbering behavior above.


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT. \
The manual source code is free software: you are free to change and redistribute
it.  There is NO WARRANTY, to the extent permitted by law.

The logo was obtained from #link("https://flaticon.com")[Flaticon] website.