#import "/src/lib.typ": book

#let def = (two-sided: false, cover-back: false, font-usedefaults: true)
#let body = []

// 1.png
#set outline(depth: 4, indent: 1.5em)
#book(
  cfg: (..def,
    toc-stdindent: false,
    toc-bold: false,
  ),
  title: "", authors: "", cover: none, toc: true, titlepage: none,
  part: "", chapter: none, body
)


#let body = [
  = Headings
  == Foo
  === Bar
  ==== Baz
  ===== Qux
  ====== Quz
]

// 2.png
#counter(heading).update(0)
#book(
  cfg: (..def,
    numbering: "1.a.",
    heading-weight: "bold",
  ),
  title: "", authors: "", cover: none, toc: false, titlepage: none,
  part: none, chapter: none, body
)

// 3.png
#counter(heading).update(0)
#book(
  cfg: (..def,
    numbering: ("{1:1}.", "{1:1}.{2:1}."),
    heading-weight: "regular",
  ),
  title: "", authors: "", cover: none, toc: false, titlepage: none,
  part: none, chapter: none, body
)

// 4.png
#counter(heading).update(0)
#book(
  cfg: (..def,
    numbering: none
  ),
  title: "", authors: "", cover: none, toc: false, titlepage: none,
  part: none, chapter: none, body
)

// 5.png
#counter(heading).update(0)
#book(
  cfg: (..def,
    numbering: ("{1:A}.", "{1:A}.{2:1}.", none)
  ),
  title: "", authors: "", cover: none, toc: false, titlepage: none,
  part: none, chapter: none, body
)


#let body = []

// 7.png
#book(
  cfg: (..def, 
    cover-bgcolor: rgb("#000000"),
    cover-txtcolor: rgb("#9B681B"),
    two-sided: false,
  ),
  title: "Title", subtitle: "Subtitle", authors: "Author", cover: auto,
  toc: false, titlepage: none, body
)


#let body = [
  = Page structure
  #lorem(250)
  
  #lorem(200)
  #link("https://typst.app")[Typst website.]
]

// 6.png
#book(
  cfg: (..def,
    page: (flipped: true, paper: "a4"),
    paper-links: false,
    justify: false,
    par-margin: 1.5em,
    line-indentfirst: 0em,
    line-space: 0.3em,
    margin: 3cm
  ),
  title: "", authors: "", cover: none, toc: false, titlepage: none, 
  part: none, chapter: none, body
)