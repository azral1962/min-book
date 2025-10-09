#let generate(meta, cfg) = {
  set align(center + horizon)
  set page(fill: black.lighten(7%))
  set text(
    fill: white,
    weight: "bold",
  )
  set rect(
    stroke: 2pt + white,
    width: 100%,
    height: 100%,
    inset: 2em,
  )
  
  meta.title = text(meta.title, size: 1.6em)
  
  let frame(data) = rect(
    inset: 3pt,
    stroke: 2pt,
    rect(
      stroke: 1pt,
      data
    )
  )
  
  frame[
    #align(top)[_This is an example._]
    
    #meta.title\
    #meta.subtitle
    
    #align(bottom)[
      #meta.authors\
      #meta.date.year()
    ]
  ]
}