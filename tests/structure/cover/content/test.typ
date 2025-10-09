#import "/src/lib.typ": book
#set page(height: auto)

#book(
  cover: include("cover.typ"),
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