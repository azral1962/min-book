# Minimal Books

<center>
  Simple and complete books without introducing new sintax
</center>


# Quick Start

```typst
#import "@preview/min-book:0.1.0": book
#show: book.with(
  title: "Book Title",
  subtitle: "Complementary subtitle, not more than two lines long",
  authors: "Author",
  cover: image("assets/cover.jpeg"),
)
```


# Description

Generate complete and complex books, without any annoying new commands or sintax,
just good old pure Typst. All the magic occurs in initialization: you set it
with the right options, and the package will manage all formatting and
structuring all by itself --- as it should be.


# More Information

- [Official manual](docs/pdf/manual.pdf)
- [Example PDF result](docs/pdf/example.pdf)
- [Example Typst code](template/main.typ)


# Setup

This project uses `just` to automate all development processes. Run `just` or
refer to the _justfile_ for more information.


### Release

Install the package in default _preview_ namespace:

```
just install preview
```

To uninstall it:

```
just remove preview
```


### Testing

Install the package in a separated _local_ namespace:

```
just install local
```

To uninstall it:

```
just remove local
```

The command `just install-all` installs it in both _preview_ and _local_
namespaces at the same time.


### Development

Create a direct symbolic link between this project and and the _local_ namespace,
under a special _0.0.0_ version:

```
just dev-link
```

This way, every change made into the package will instantly be available to 
Typst by using a `@local/min-article:0.0.0` import.

This command is a toggle: run it once, and it creates the link; run it again and
the link is removed; and so on.