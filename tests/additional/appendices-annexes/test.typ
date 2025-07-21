#import "/src/lib.typ": annexes, appendices, book
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


#appendices[
  = One Appendix
  #lorem(50)
  == An Appendix Section
  #lorem(50)
  
  = Another Appendix
  #lorem(50)
  == An Appendix Section
  #lorem(50)
]


#annexes[
  = One Annex
  #lorem(50)
  == An Annex Section
  #lorem(50)
  
  = Another Annex
  #lorem(50)
  == An Annex Section
  #lorem(50)
]