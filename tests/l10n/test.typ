#import "@preview/transl:0.1.0": transl, fluent

#set page(width: auto, height: auto)
#set par(spacing: 0pt)
#show table: it => box(it)
#set text(font: ("Noto Serif", "Noto Serif Bengali"))
//Noto Serif Bengali: https://fonts.google.com/noto/specimen/Noto+Serif+Bengali
// Noto Serif: https://fonts.google.com/noto/specimen/Noto+Serif 

#let data = ()
#let langs = (
  "en", "pt", "la", "zh", "hi", "es", "ar", "fr", 
  "bn", "ru", "ur", "id", "de", "ja", "it"
)

#transl(data: eval( fluent("/src/l10n/", lang: langs) ))

#for lang in langs {
  data.push((
    align(center, strong(lang)),
    transl("volume", args: (n: 2), to: lang),
    transl("edition", args: (n: 1), to: lang),
    transl("edition", args: (n: 2), to: lang),
    transl("edition", args: (n: 3), to: lang),
    transl("edition", args: (n: 4), to: lang),
    transl("errata", to: lang),
    transl("thanks", to: lang),
    transl("part", to: lang),
    transl("chapter", to: lang),
    transl("appendix", args: (number: "sing"), to: lang),
    transl("appendix", args: (number: "plur"), to: lang),
    transl("annex", args: (number: "sing"), to: lang),
    transl("annex", args: (number: "plur"), to: lang),
  ))
}

#let data = array.zip(..data).flatten()
#table(
  columns: langs.len(),
  ..data,
)
