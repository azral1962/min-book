#import "/src/lib.typ": book, note
#import "/src/utils.typ": storage-repr

#show: storage-repr

// Book init
#show: book.with(
  title: "Book Title",
  subtitle: "Book subtitle, not more than two lines long",
  authors: "Book Author",
  titlepage: none,
  cover: none,
  toc: false,
  part: none,
  cfg: (
    font: "Libertinus Serif",
    two-sided: false,
    cover-back: false,
  ),
)