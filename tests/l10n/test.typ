#import "@preview/transl:0.1.0": transl, fluent
#import "/src/lib.typ": book
#import "/src/utils.typ": std-langs

#set text(font: ("Noto Serif", "Noto Serif Bengali"))
// Noto Serif: https://fonts.google.com/noto/specimen/Noto+Serif 
// Noto Serif Bengali: https://fonts.google.com/noto/specimen/Noto+Serif+Bengali

// Test if each translation file in /src/l10n/ works with #book.
#for lang in std-langs {
  let doc = book(
    title: upper(lang),
    authors: "Author",
    cfg: (
      lang: lang,
      transl: read("/src/l10n/" + lang + ".ftl"),
      cover-back: false,
      two-sided: false,
      page: (width: auto, height: auto, margin: 1cm)
    ),
    part: none,
    cover: none,
    toc: false,
    titlepage: none,
    [
      = #upper(lang)
      #hide[]
    ],
  )
  //doc    // Uncomment doc to generate the samples
}


// Uncomment to test support for custom translation files
/*
#book(title: "", authors: "", cfg: (
    lang: "bra",
    transl: read("test.ftl")
), [])
*/

#set page(width: auto, height: auto)

#let data = ()

#transl(data: eval( fluent("/src/l10n/", lang: std-langs) ))

#for lang in std-langs {
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
  columns: std-langs.len(),
  ..data,
)