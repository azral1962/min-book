// Cover text
#let title = "Book Title"
#let subtitle = "Book subtitle, not more than two lines long"
#let authors = "Book Author"
#let volume = "Volume 1"
#let date = 2025
#let volume = "Volume 1"
#let title-font = "Libertinus Serif" // "Cinzel"
#let text-font = "Libertinus Serif"  // "Alice"


#let cover-bg = context {
    let m = page.margin
    let frame = image("/src/assets/frame.svg", width: 93%)
      
    if type(m) != dictionary {
      m = (
        top: m,
        bottom: m,
        left: m,
        right: m
      )
    }
    
    v(m.top * 0.25)
    align(center + top, frame)
    
    align(center + bottom, rotate(180deg, frame))
    v(m.bottom * 0.25)
  }


#set text(
  fill: luma(200),
  hyphenate: false
)
#set par(justify: false)


#page(
  margin: (x: 12%, y: 12%),
  fill: rgb("#3E210B"),
  background: cover-bg,
)[
  #align(center + horizon)[
    #set par(leading: 2em)
    #context text(
      size: page.width * 0.09,
      font: title-font,
      title
    )
    #linebreak()
    #set par(leading: 0.5em)
    #if subtitle != none {
    v(1cm)
      context text(
        size: page.width * 0.04,
        font: text-font,
        subtitle
      )
      //v(4cm)
    }
  ]
  #align(center + bottom)[
    #block(width: 52%)[
      #context text(
        size: page.width * 0.035,
        font: text-font,
        volume + "\n" +
        authors + "\n" +
        str(date)
      )
    ]
  ]
]