== COMPILE

create pdf
`typst foo.typ`

create pdf at path
`typst foo.typ path/bar.pdf`

watch mode
`typst watch foo.typ`

== FONTS

Adds additional directories to search for fonts.
`typst compile --font-path path/to/fonts file.typ`

Lists all of the discovered fonts in the system and the given directory.
`typst fonts --font-path path/to/fonts`

Or via environment variable (Linux syntax).
`TYPST_FONT_PATHS=path/to/fonts typst fonts`

== HELP

Prints available subcommands and options.
`typst help`

Prints detailed usage of a subcommand.
`typst help watch`
