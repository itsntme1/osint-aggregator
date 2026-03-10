#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import fletcher.shapes: diamond

#import "@preview/codly:1.3.0": *
#show: codly-init

#import "@preview/codly-languages:0.1.10": *
#codly(languages: codly-languages)

#import "modules/variables.typ": *
#import "modules/functions.typ": *
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

// Links
#show link: underline

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
Pro zjednodušení vývoje jsem využil několik populárních knihoven a frameworků. Nejdůležitějším z nich je Flask, který se stará o backend stránky. Bootstrap jsem použil k většině visuální prezentace aplikace. Typst jsem použil k navržení šablony pro generování zprávy o uživatelových datech a napsání tohoto manuálu.

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
Verze aplikace jsem spravoval přes nástroj Git a kód programu je k dispozici na stránce #link("https://github.com/itsntme1/osint-aggregator")[Github]. Pracoval jsem výhradně v editoru Vscode.

== Přehleded souborů
Zde je přehled důležitých souborů mého projektu. Z přehledu jsem vynechal soubory, které nejsou důležité pro fungování aplikace (například dočasné soubory, staré verze softwaru a soubory sloužící pro vybudování prostředí).

#figure(
  [
    #codly(
      header: [*Struktura projektu*],
      zebra-fill: none
    )
    ```bash
    ├── app.py
    ├── export
    ├── functions.py
    ├── reports
    ├── report.typ
    ├── secret_keys.py
    ├── static
    │   ├── media
    │   │   ├── email-icon.png
    │   │   └── warning-icon.png
    │   ├── script.js
    │   ├── schemas.js
    │   └── style.css
    └── templates
        ├── dashboard.html
        ├── landing.html
        ├── layout.html
        └── macros.html
    ```
  ],
  caption: [Přehled souborů]
)

Soubory s příponou ".py" jsou napsány v pythonu. Přípona ".js" značí javascript. Přípony ".html" a "css" značí sebe sama. Soubory končící na ".typ" obsahují typst a souboru bez koncovek jsou složkamy.

== Implementace backendu
Backend se nachází výhradně v souboru `app.py`. Spuštěním souboru pomocí python interpeteru se spustí samotná aplikace. 

=== Server aplikace
Stránka je spouštěna lokálně a není hostována na žádném serveru. Když je spuštěna, běží na `localhost:5000`, kde si ji pomocí prohlížeče můžeme zobrazit.

=== Endpointy
#callout("Endpoint")[Podadresa domény, kde je uživateli servírována stránka \ (například `ww.stranka.com/landing` nebo `www.stranka.com/dashboard`).]

Stránka má dva endpointy důležité pro uživatele "/", který slouží pro vyhledávání a jako přistávací endpoint, a "/dashboard", který slouží pro zobrazování dat.

Dále má stránka 8 endpointů interních API. Které více rozeberu v sekci *TODO*.

=== Zpracování API dotazů
Vysvětlit jak funguje `query` a funkce okolo

== Implementace uživatelského rozhraní
=== Struktura HTML šablon
Pro generování stránek byl použit systém Jinja2, který je součástí Flasku. Umožňuje vytvářet znovupoužitelné šablony makra (HTML funkce). Systém je používán v HTML souborech ve složce `templates`.

#figure(
  [
    #codly(
      header: [*templates/layout.html*],
      zebra-fill: none
    )
    ```html
    <!DOCTYPE html>
    <html lang="en">
    <head>
        {% block head %}
            <!-- Irelevantní kód -->

        {% endblock head %}
    </head>
    <body>
        {% block body %}

        {% endblock body %}
    </body>
    </html>
    ```
  ],
  caption: [Příklad fungování rodičovské šablony]
)

V rodičovské šabloně jsou deklarovány bloky `head` a `body` do kterých můžeme vložit jiný kód v dětských šablonách.

#figure(
  [
    #codly(
      header: [*templates/landing.html*],
      zebra-fill: none
    )
    ```html
    {% extends "layout.html" %}

    {% block head %}
        {{ super() }}
        
    {% endblock head %}

    {% block body %}
        <form action="/" method="post">
            <!-- kód pro vyhledávací formulář -->
        </form>

        {% if error is not none() %}
            <!-- kód pro stylování chyby -->
                {{ error }}
        {% endif %}
    {% endblock body %}
    ```
  ],
  caption: [Příklad fungování dětské šablony]
) <landing-jinja>

V dětské šabloně můžeme použít funkci `super()`, která do ní doplní obsah rodičovaské šablony v jejím bloku. Dále pomocí flasku můžeme pomocí flasku vkládat proměné a provádět s nimi operace. Například ve @landing-jinja vložím proměnou `error` pokud se nepovede vyhledávání a ona se zobrazí na stránce, pokud má nějaký obsah.

#figure(
  [
    #codly(
      header: [*templates/macros.html*],
      zebra-fill: none
    )
    ```html
    {% macro card(title, endpoint, schema) %}
    <div class="card fixed-card shadow border-dark" data-title="{{ title }}" data-endpoint="{{ endpoint }}" data-schema="{{ schema }}">
        <div class="card-header bg-dark shadow">
            <p class="m-0 fs-5 fw-semibold d-inline text-white">{{ title }}</p>
            <button class="btn btn-dark btn-lg m-0 p-0 px-1 float-end" data-reload>
                <i class="bi bi-arrow-repeat text-white"></i>
            </button>
        </div>
        <div class="card-body fixed-card-body p-0 overflow-y-scroll rounded" data-display>
            <div class="position-absolute top-50 start-50 translate-middle">
                <div class="loader"></div>
            </div>
        </div>
    </div>
    {% endmacro %}
    ```
  ],
  caption: [Implementace makra pro karty]
)

Dále používám makra, která bych popsal jako funkce pro HTML. Funkci můžeme dát proměné, které budou doplněni přímo do kódu. Funkce můžeme v jiném templatu, když je importujeme (například takto `{% from 'macros.html' import card %}`).

#figure(
  [
    #codly(
      header: [*templates/dashboard.html*],
      zebra-fill: none
    )
    ```html
    {% from 'macros.html' import card %}

    {% extends "layout.html" %}

    {% block head %}
        {{ super() }}

        <!-- kód pro importování javascriptu -->
    {% endblock head %}

    {% block body %}
    <div class="container-fluid py-3 w-100 card-container">
        < class="d-flex flex-wrap gap-3 justify-content-center">
            {{ card("IPinfo.io", "/api/ip_info", "ipInfo") }}
            {{ card("HTTP Headers", "/api/http_headers", "httpHeaders") }}
            {{ card("Mapy.com", "/api/mapy_cz", "mapyCz") }}
            {{ card("Disify", "/api/disify", "disify") }}
            {{ card("Maigret", "/api/maigret", "maigret") }}
            {{ card("XposedOrNot", "/api/xposedornot", "xposedornot")}}
            {{ card("Name Info", "/api/name_info", "nameInfo") }}

            <!-- kód pro sekci O Programu -->
        </div>
    </div>
    {% endblock body %}
    ```
  ],
  caption: [Použití karet]
)

Ve finální podobě bude HTML kód stránky vypadat tak, že pokud uživatel požádá například o enpoint `/dashboard`, tak dostane soubor spojen s maker a šablony `dashboard.html` a jeho rodiče `layout.html`.

=== Dynamické načítání dat
Vysvětlit loadData funkce a systém schémat

=== Stylování a responzivita
Vysvětlit bootstrap a moje styly

== Integrace externích služeb
=== Tok dat
Frontend request na interní API -> request na externí api -> zpracování dat -> formátování dat

=== Zpracování OSINT dat
Vysvětlit pár cest v app.py

=== Integrace dalších nástrojů
Maigret, Wget

== Generování reportu
=== Příprava dat pro report 
Napsat o json systému a user_hashy

=== Generování dokumentu pomocí Typst
Vysvětlit `report.typ` dokument a základy Typstu

=== Export výsledků
Psát o `export` cestě v app.py

#pagebreak()
= Vyhodnocení
Se svou prací nejsem vůbec spokojen. Kdybych měl tu možnost udělat ji znovu rozhodně bych systém načítání dat přes frontend tlačítko. Byl to špatný nápad. Všechny informace bych začal shánět a načítat hned po té co je uživatel zadá do formuláře a vše by bylo nezávislé na frontendu. Dále bych se pokusil změnit například HTML kód, který mám v javascript stringu.

Celkově jsem spokojený s funkčností mojí práce, ale změnil bych provedení. I když bych mohl přidat třeba zjišťování lokace uživatele nezávislé na ip adrese.

#pagebreak()
= Závěr <unnumbered>