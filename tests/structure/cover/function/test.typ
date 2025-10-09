#import "/src/lib.typ": book
#import "cover.typ"
#set page(height: auto)

#book(
  cover: cover.generate,
  title: "Book Title",
  authors: "Book Author",
  titlepage: none,
  toc: none,
  cfg: (
    font-usedefaults: true,
    two-sided: false,
    cover-back: false,
  ),
  []
)