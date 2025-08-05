#import "/src/lib.typ": note, book
#import "/src/utils.typ": storage-repr
#set page(height: auto)

// Show storage representation on the last page
#show: storage-repr.with(path: "note")

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
    font-usedefaults: true,
  )
)


#lorem(25)#note[Foo]
#lorem(25)#note[Bar]

#lorem(50)#note[Baz]

#lorem(50)#note[Qux]

#lorem(50)#note[Quz]

#lorem(50)#note[Quuz]