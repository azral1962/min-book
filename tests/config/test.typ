#import "/src/lib.typ": book, note
#import "/src/utils.typ": show-cfg

#context show-cfg("final")

#let pagebreak() = []

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

#note[A]
#note[B]
#note[C]
