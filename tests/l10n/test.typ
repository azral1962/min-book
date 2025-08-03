#import "@preview/transl:0.1.0": transl, fluent
#import "/src/lib.typ": book

#set text(font: ("Noto Serif", "Noto Serif Bengali"))
//Noto Serif Bengali: https://fonts.google.com/noto/specimen/Noto+Serif+Bengali
// Noto Serif: https://fonts.google.com/noto/specimen/Noto+Serif 

#let data = ()
#let langs = (
  "en", "pt", "la", "zh", "hi", "es", "ar", "fr", 
  "bn", "ru", "ur", "id", "de", "ja", "it"
)

// Test if each translation file in /src/l10n/ works with #book.
#for lang in langs {
  let doc = book(
    title: upper(lang),
    authors: "Author",
    cfg: (
      lang: lang,
      transl: read("/src/l10n/" + lang + ".ftl"),
      cover-back: false,
      two-sided: false,
    ),
    cover: none,
    toc: false,
    titlepage: none,
    [
      = #upper(lang)
      Foo
    ],
  )
  
  assert.eq(
    type(doc), content,
    message: "#book must return content: returned " + repr(doc)
  )
  // Uncomment to generate the samples
  //doc
}


#transl(data: eval( fluent("/src/l10n/", lang: langs) ))

#set page(width: auto, height: auto)

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