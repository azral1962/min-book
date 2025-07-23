#import "@preview/transl:0.1.0": transl, fluent

#set page(width: auto, height: auto)
#set par(spacing: 0pt)
#show table: it => box(it)

#let langs = ("en", "pt")

#transl(data: eval( fluent("/src/l10n/", lang: langs) ))

#for lang in langs {
  set text(lang: lang)
  
  table(
    columns: 1,
    align(center, [*#lang*]),
    transl("volume", args: (n: 2)),
    transl("edition", args: (n: 1)),
    transl("edition", args: (n: 2)),
    transl("edition", args: (n: 3)),
    transl("edition", args: (n: 4)),
    transl("errata"),
    transl("thanks"),
    transl("part"),
    transl("chapter"),
    transl("appendix", args: (number: "sing")),
    transl("appendix", args: (number: "plur")),
    transl("annex", args: (number: "sing")),
    transl("annex", args: (number: "plur")),
  )
}