#import "/src/lib.typ": note, book
#set page(height: auto)

#show: book.with(
  title: "",
  authors: "",
  cover: none,
  titlepage: none,
  toc: none,
  cfg: (
    two-sided: false,
    cover-back: false,
  )
)

#lorem(25)#note[Foo]
#lorem(25)#note[bar]

#lorem(50)#note[Baz]

#lorem(50)#note[Qux]
