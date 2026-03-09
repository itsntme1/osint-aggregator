
#let title-page(title, author) = [
  #set page(footer: none)
  #set text(
    size: 18pt,
    font: "Calibri"
  )

  #align(center)[
    Gymnázium Ústí nad Orlicí, T. G. Masaryka 106
  ]

  #align(center + horizon)[
    #text(size: 28pt)[#title]
    MANUÁL K MATURITNÍ PRÁCI Z INFORMATIKY
  ]

  #align(bottom)[
    Školní rok: 2025/2026
    #columns(2)[
      Autor: #author 8.B

      #colbreak()

      #align(right)[Vyučující: Drahomír Vrba]
    ]
  ]

  #pagebreak()
]
