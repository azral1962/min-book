#import "/src/lib.typ": book
#set page(height: auto)

#book(
  titlepage: include("titlepage.typ"),
  volume: 1,
  edition: 2,
  title: "Book Title",
  authors: "Book Author",
  cover: none,
  toc: none,
  cfg: (
    two-sided: false,
    cover-back: false,
    font: "Libertinus Serif",
  ),
  []
)