#import "/src/lib.typ": note, book
#set page(height: auto)

// Additional book data
#show: book.with(
  title: "",
  authors: "",
  cover: none,
  titlepage: none,
  toc: none,
  cfg: (
    two-sided: false,
    cover-back: false,
    font: "Libertinus Serif",
  )
)


#lorem(25)#note[Foo]
#lorem(25)#note[Bar]

#lorem(50)#note[Baz]

#lorem(50)#note[Qux]
