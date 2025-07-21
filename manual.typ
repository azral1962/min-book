// NAME: Manual for min-book

#import "@preview/min-manual:0.1.1": manual, arg, univ, url

#show: manual.with(
  title: "Minimal Books",
  description: "Simple and complete books without introducing new syntax.",
  authors: "Maycon F. Melo <https://github.com/mayconfmelo>",
  package: "min-book:1.1.0",
  license: "MIT",
  logo: image("docs/assets/manual-logo.png"),
  from-comments:
    read("src/lib.typ") +
    read("src/additional/notes.typ") +
    read("src/additional/ambient.typ") +
    read("src/additional/horizontalrule.typ") +
    read("src/additional/blockquote.typ")
)

= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT. \
The manual source code is free software: you are free to change and redistribute
it.  There is NO WARRANTY, to the extent permitted by law.

The logo was obtained from #link("https://flaticon.com")[Flaticon] website.