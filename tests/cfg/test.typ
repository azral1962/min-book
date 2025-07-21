#import "/src/lib.typ": book
#set page(height: auto)

#show: book.with(
  // cfg data
  cfg: (
    numbering-style: auto,
    page: "a5",
    lang: "en",
    lang-data: toml("/src/assets/lang.toml"),
    justify: true,
    line-space: 0.5em,
    par-margin: 0.65em,
    first-line-indent: 1em,
    margin: (x: 15%, y: 14%),
    font: ("Book Antiqua", "Times New Roman"),
    font-math: "Asana Math",
    font-mono: "Inconsolata",
    font-size: 11pt,
    heading-weight: auto,
    cover-bgcolor: rgb("#3E210B"),
    cover-txtcolor: luma(200),
    cover-fonts: ("Cinzel", "Alice"),
    cover-back: true,
    toc-indent: none,
    toc-bold: true,
    chapter-numrestart: false,
    two-sided: true,
    link-readable: true,
  ),
  // Additional book data
  title: "Book Author",
  authors: "Book Author",
  cover: none,
  titlepage: none,
  toc: none,
)
