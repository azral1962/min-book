#import "/src/lib.typ": book
#set page(height: auto)

#book(
  // Dedication data
  dedication: [
    To someone special;\
    May your days be plenty and your happiness long-lasting.
  ],
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