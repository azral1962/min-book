#import "/src/lib.typ": book
#set page(height: auto)

#show: book.with(
  title: "Book Title",
  authors: "Book Author",
  cover: image("cover.png"),
  titlepage: none,
  toc: none,
  cfg: (
    two-sided: false,
    cover-back: false,
  )
)