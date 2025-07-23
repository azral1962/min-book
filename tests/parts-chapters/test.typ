#import "/src/lib.typ": book
#set page(height: auto)

#book(
  // Part and chapter data
  // part: "Part",
  // chapter: "Chapter",
  [
    = Section A
    == Section A.1
  ],
  // Additional book data
  title: "",
  authors: "",
  cover: none,
  titlepage: none,
  toc: none,
  cfg: (
    two-sided: false,
    font: "Libertinus Serif",
  ),
)


#book(
  // Part and chapter data
  part: none,
  [
    = Section B
    == Section B.1
  ],
  // Additional book data
  title: "",
  authors: "",
  cover: none,
  titlepage: none,
  toc: none,
  cfg: (
    font: "Libertinus Serif",
    two-sided: false
  ),
)


#book(
  // Part and chapter data
  part: none,
  chapter: none,
  [
    = Section C
    == Section C.1
  ],
  // Additional book data
  title: "",
  authors: "",
  cover: none,
  titlepage: none,
  toc: none,
  cfg: (
    font: "Libertinus Serif",
    two-sided: false
  ),
)