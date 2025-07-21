#import "/src/lib.typ": book
#set page(height: auto)

#book(
  // Errata data
  errata: [The information in page 99 is wrong; you can't actually eat mango while wristle.],
  // Additional book data
  title: "Book Title",
  subtitle: "Book subtitle, not more than two lines long",
  authors: "Book Author",
  titlepage: none,
  cover: none,
  toc: none,
  volume: 1,
  cfg: (
    font: "Libertinus Serif",
    two-sided: false,
    cover-back: false,
  ),
  []
)