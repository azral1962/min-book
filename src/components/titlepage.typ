#let init(
  titlepage, title, subtitle, authors, date, volume, edition, translation
) = {
  if titlepage == auto {
    set text(
      fill: luma(50),
      hyphenate: false
    )
    set par(justify: false)
    
    let authors = if type(authors) == array {authors.join(", ")} else {authors}
  
    if volume != "" {volume = [#translation.volume.at(0) #volume\ ]}
    if edition != "" {edition = [#translation.edition.at(0) #edition\ ]}

  
    align(center + horizon)[
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
    align(center + bottom)[
      #block(width: 52%)[
        #context text(
          size: page.width * 0.035,
          volume +
          edition +
          authors + "\n" + 
          date.display("[year]")
        )
      ]
    ]
  }
  else if type(titlepage) == content {
    titlepage
  }
  else {
    panic("Invalid titlepage argument value: \"" + repr(titlepage) + "\"")
  }
}