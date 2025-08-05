#import "/src/lib.typ": book, blockquote
#set page(height: auto)

#book(
  // Epigraph data
  epigraph: blockquote(by: "Einstein")[Don't believe everything you read.],
  // Additional book data
  title: "Book Title",
  subtitle: "Book subtitle, not more than two lines long",
  authors: "Book Author",
  titlepage: none,
  cover: none,
  toc: none,
  volume: 1,
  cfg: (
    font-usedefaults: true,
    two-sided: false,
    cover-back: false,
  ),
  []
)