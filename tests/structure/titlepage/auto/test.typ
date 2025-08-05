#import "/src/lib.typ": book
#set page(height: auto)

#book(
  titlepage: auto,
  volume: 1,
  edition: 2,
  title: "Book Title",
  subtitle: "Book subtitle, not more than two lines long",
  authors: "Book Author",
  cover: none,
  toc: none,
  cfg: (
    font-usedefaults: true,
    two-sided: false,
    cover-back: false,
  ),
  []
)