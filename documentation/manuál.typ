#import "@preview/codly:1.3.0": *
#show: codly-init

#import "@preview/codly-languages:0.1.10": *
#codly(languages: codly-languages)

#import "modules/variables.typ": *
#import "modules/title-page.typ": title-page
#import "modules/proclamation-page.typ": proclamation-page

// Document setup
#set document(
  title: project-title,
  author: author,
)

// Page setup
#set page(
  paper: "a4",
  margin: (
    top: 2.5cm,
    bottom: 3cm,
    left: 3cm,
    right: 3cm,
  ),
  numbering: "1",
)

// Headings
#show heading: set text(font: "Calibri")
#show heading.where(level: 1): set text(size: 24pt)
#show heading.where(label: <unnumbered>): set heading(numbering: none)
#set heading(
  // Suspicious
  numbering: "1.1."
)

// Text
#set text(
  size: 12pt,
  font: "Cambria",
  lang: "cs",
  hyphenate: false
)

// Paragraphs
#set par(
  // Suspicious spacing
  spacing: 30pt,
  leading: 1.15em,
  justify: true
)

// Footnotes
#show footnote.entry: set text(
  size: 10pt,
  style: "italic"
)

// Figures
#show figure.caption: set text(
  font: "Calibri",
  style: "italic",
  weight: "light"
)

// Tables
#show table.cell.where(y: 0): strong
#set table(
  stroke: 0.8pt + black,
  align: (x, y) =>
    if y == 0 { center }
    else { left },
)


// CONTENT

#title-page(upper(title()), author)

#proclamation-page

#outline()

#pagebreak()
= Úvod <unnumbered>
Žijeme ve věku informací. Data o nás se jsou sbírána a prodávána, ať už chceme nebo ne. Proto jsem se rozhodl vytvořit stránku/nástroj, který shromáždí některé z veřejně dostupných informací #footnote[V angličtině se používá pojem "OSINT"] o uživateli a podá mu je v přehledné formě.

#pagebreak()
= Teoretická část
== Použité technologie
Při vývoji aplikace jsem většinou vycházel z dokumentace jednotlivých technologií.

=== Jazyky
Základ mé aplikace tvoří python, s pomocí kterého jsem napsal základní fungování stránky a zpracovávál jsem získaná data. Javascript jsem využil k přidání reaktivity (tlačítka) a načitání zpracovaných dat. HTML používám na strukturu stránky. CSS používám málo, pouze na malé úpravy a animace.

#figure(
  table(
    columns: (auto, 1fr),
    table.header([Jazyk],[Použití]),

    [Python],[Základní fungování stránky a zpracování dat],
    [Javascript],[Reaktivita uživatelské části aplikace a zobrazení dat],
    [Typst],[Generovavání pdf shrnutí a získaných datech],
    [HTML],[Základní struktura a obsah stránky],
    [CSS],[Pár vlastních stylů a animací]
  ),
  caption: [Použité jazyky]
)

=== Externí knihovny
Pro zjednodušení vývoje jsem využil několik populárních knihoven a frameworků. Nejdůležitějším z nich je Flask, který se stará o backend stránky. Bootstrap jsem použil k většině visuální prezentace aplikace. Typst jsem použil k navržení templatu pro generování zprávy o uživatelových datech a napsání tohoto manuálu.

#figure(
  table(
    columns: (auto, 1fr),
    table.header([Knihovna / Framework],[Použití]),

    [Bootstrap],[Visuální prezentace stránky],
    [Flask],[Základní fungování stránky a systém šablon],
    [Typst (python modul)],[Načítání dat do dokumentu a jeho kompilace],
  ),
  caption: [Externí knihovny]
)
=== Externí API
Externí API tvoří většinu zdrojů z kterých získávám data. Informace z nich získávám pomocí standartního GET requestu nebo nástoje Wget.

#figure(
  table(
    columns: (auto, 1fr),
    table.header([Externí API],[Typy dat použitých dat]),
    
    [icanhazip.com],[Ip adresa],
    [ip_info.io],[Časová zóna, země, region, město, ZIP kód a souřadnice],
    [disify.com],[Doména, validita a disposabilita],
    [xposedornot.com],[Název úniku],
    [genderize.com],[Odhad pohlaví a jeho pravděpodobnost],
    [agify.com],[Odhad věku],
    [nationalize.com],[Odhad země a jeho pravděpodobnost]
  ),
  caption: [Externí API]
)

=== Ostatní nástroje
Mezi ostatní nástroje, které jsem použil patří Maigret a Wget. Aplikace používá Maigret i Wget lokálně nepotřebuje se připojovat přes žádnou externí API. Maigret je nástroj na vyhledávání uživatelovy přezdívky na populárních sítích a službách. Může však najít falešná pozitiva. Tento problém se mi nepodařilo vyřešit a přetrvává i u podobných nástrojů. Wget je malý nástoj na stahování obrázků.

#figure(
  table(
    columns: (auto, 1fr),
    table.header([Nástroj],[Použití]),

    [Maigret],[Hledání uživatelovy přezdívky na ostatních sítích a službách],
    [Wget],[Stahování statických map z mapy.com],
  ),
  caption: [Ostatní nástroje]
)

#pagebreak()
= Praktická část

#pagebreak()
= Vyhodnocení

#pagebreak()
= Další

#pagebreak()
= Testing
asd#footnote()[fghd]


#codly(
  header: [*Test*],
  offset: 33,
  zebra-fill: none,
)
```python
@app.route("/dashboard")
def dashboard():
    if not session['name'] or not session['usernames'] or not session['emails']:
        return redirect("/")

    return render_template("dashboard.html")
```

#pagebreak()
= Závěr <unnumbered>