# text formatting

## docs

- https://typst.app/docs/reference/model/emph/
- https://typst.app/docs/reference/model/strong/
- https://typst.app/docs/reference/model/underline/
- https://typst.app/docs/reference/model/strike/
- https://typst.app/docs/reference/model/smallcaps/
- https://typst.app/docs/reference/model/overline/
- https://typst.app/docs/reference/model/highlight/
- https://typst.app/docs/reference/model/text/
- https://typst.app/docs/reference/model/sub/
- https://typst.app/docs/reference/model/super/

## recipes

italic
`_text_` or `#emph[text]`

bold
`*text*` or `#strong[text]`

underline
`#underline[text]`

strikethrough
`#strike[text]`

small caps
`#smallcaps[text]`

overline
`#overline[text]`

highlight
`#highlight[text]`
`#highlight(fill: yellow)[text]`

subscript
`#sub[text]`
`H#sub[2]O`

superscript
`#super[text]`
`x#super[2]`

font size
`#text(size: 14pt)[text]`

font family
`#text(font: "Linux Libertine")[text]`

font color
`#text(fill: red)[text]`
`#text(fill: rgb("#ff0000"))[text]`

font weight
`#text(weight: "bold")[text]`
`#text(weight: 700)[text]`

combined formatting
`#text(size: 12pt, fill: blue, weight: "bold")[text]`

monospace/code
`` `inline code` ``

verbatim block
````
```
code block
```
````

raw inline with syntax
`` `code`rust ``

raw block with syntax
