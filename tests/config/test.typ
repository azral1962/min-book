#import "/src/lib.typ": book, note
#import "/src/utils.typ": show-cfg

#context show-cfg("final")

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


#lorem(25)#note[Foo]
#lorem(25)#note[Bar]

#lorem(50)#note[Baz]

#lorem(50)#note[Qux]