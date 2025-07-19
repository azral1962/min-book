#import "/src/lib.typ": book
#set page(height: auto)

#book(
  part: "Part",
  chapter: "Chapter",
  [
    = Section A
    == Section A.1
  ],
  title: "",
  authors: "",
  cover: none,
  titlepage: none,
  toc: none,
  cfg: (two-sided: false),
)


#book(
  part: none,
  chapter: "Chapter",
  [
    = Section B
    == Section B.1
  ],
  title: "",
  authors: "",
  cover: none,
  titlepage: none,
  toc: none,
  cfg: (two-sided: false),
)


#book(
  part: none,
  chapter: none,
  [
    = Section C
    == Section C.1
  ],
  title: "",
  authors: "",
  cover: none,
  titlepage: none,
  toc: none,
  cfg: (two-sided: false),
)