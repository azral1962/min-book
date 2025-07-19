#let title = "Book Title"
#let subtitle = "Book subtitle, not more than two lines long"
#let authors = "Book Author"
#let volume = "Volume 1"
#let edition = "Edition 2"
#let date = datetime.today()


#set text(
  fill: luma(50),
  hyphenate: false
)
#set par(justify: false)

#let authors = if type(authors) == array {authors.join(", ")} else {authors}

#align(center + horizon)[
  #set par(leading: 2em)
  #context text(
    size: page.width * 0.09,
    title
  )
  #linebreak()
  #set par(leading: 0.5em)
  #if subtitle != none {
  v(1cm)
    context text(
      size: page.width * 0.04,
      subtitle
    )
    //v(4cm)
  }
]
#align(center + bottom)[
  #block(width: 52%)[
    #context text(
      size: page.width * 0.035,
      volume + "\n" +
      edition + "\n" +
      authors + "\n" + 
      date.display("[year]")
    )
  ]
]