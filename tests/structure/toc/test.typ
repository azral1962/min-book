#import "/src/lib.typ": book, blockquote
#set page(height: auto)

#show: book.with(
  // TOC data
  toc: true,
  // Additional book data
  title: "Book Title",
  subtitle: "Book subtitle, not more than two lines long",
  authors: "Book Author",
  titlepage: none,
  cover: none,
  volume: 1,
  part: none,
  cfg: (
    font-usedefaults: true,
    two-sided: false,
    cover-back: false,
  ),
)

= Chapter
== Section
== Section
=== Subsection
= Chapter
== Section
== Section
