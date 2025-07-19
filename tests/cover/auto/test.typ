#import "/src/lib.typ": book
#set page(height: auto)

#book(
  cover: auto,
  title: "Book Title",
  authors: "Book Author",
  subtitle: "Book subtitle, not more than two lines long",
  volume: 1,
  edition: 2,
  titlepage: none,
  toc: none,
  cfg: (
    two-sided: false,
    cover-back: false,
  ),
  []
)