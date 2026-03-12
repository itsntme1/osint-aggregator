#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import fletcher.shapes: diamond

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
  numbering: "1.1"
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
  spacing: 24pt,
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
#set figure(
  numbering: "č. 1"
)

#show figure.caption: set text(
  font: "Calibri",
  style: "italic",
  weight: "light",
)

// Tables
#show table.cell.where(y: 0): strong
#set table(
  stroke: 0.8pt + black,
  align: (x, y) =>
    if y == 0 { center }
    else { left },
)

// Raw
#show raw: set text(font: "JetBrainsMono NF")

// CONTENT

#title-page(upper(title()), author)

#proclamation-page

#page(
  numbering: none
)[#outline()]

#pagebreak()
= Úvod <unnumbered>
Žijeme ve věku informací. Data o nás jsou sbírána a prodávána, ať už chceme nebo ne. Proto jsem se rozhodl vytvořit stránku/nástroj, který shromáždí některé z veřejně dostupných informací #footnote[V angličtině se používá pojem "OSINT"] o uživateli a podá mu je v přehledné formě. Práci jsem se rozhodl vypracovat v angličtině, jelikož ji všechny mé zdroje dat používají, a kdybych ji nepoužil, došlo by k nehezkému míchání.

#pagebreak()
= Teoretická část
== Použité technologie
Při vývoji aplikace jsem většinou vycházel z dokumentace jednotlivých technologií. Použil jsem pár ikon z webu "flaticon.com" @Flaticons a pár z ikonového fontu knihovny Bootstrap @BootstrapIcons.

=== Jazyky
Základ mé aplikace tvoří Python, s pomocí kterého jsem napsal základní fungování stránky a zpracovával jsem získaná data. JavaScript @JavaScriptDocs jsem využil k přidání reaktivity (tlačítka) a načitání zpracovaných dat. HTML @W3SchoolsHTML používám na strukturu stránky. Čisté CSS @W3SchoolsCSS používám pouze na malé úpravy a animace.

#figure(
  table(
    columns: (auto, 1fr),
    table.header([Jazyk],[Použití]),

    [Python],[Základní fungování stránky a zpracování dat],
    [JavaScript],[Reaktivita uživatelské části aplikace a zobrazení dat],
    [Typst],[Generování PDF shrnutí a získaných dat],
    [HTML],[Základní struktura a obsah stránky],
    [CSS],[Pár vlastních stylů a animací]
  ),
  caption: [Použité jazyky]
)

=== Externí knihovny
Pro zjednodušení vývoje jsem využil několik populárních knihoven a frameworků. Nejdůležitějším z nich je Flask @FlaskDocs, který se stará o backend stránky. Bootstrap @BootstrapDocs jsem použil k většině vizuální prezentace aplikace. Typst @TypstDocs jsem použil k navržení šablony pro generování zprávy o uživatelových datech a napsání tohoto manuálu.

#figure(
  table(
    columns: (auto, 1fr),
    table.header([Knihovna / Framework],[Použití]),

    [Bootstrap],[Vizuální prezentace stránky],
    [Flask],[Základní fungování stránky a systém šablon],
    [Typst (Python modul) @TypstPython],[Načítání dat do dokumentu a jeho kompilace],
  ),
  caption: [Externí knihovny]
)
=== Externí API
Externí API tvoří většinu zdrojů, z kterých získávám data. Informace z nich získávám pomocí standardního GET requestu nebo nástroje Wget.

#figure(
  table(
    columns: (auto, 1fr),
    table.header([Externí API],[Typy použitých dat]),
    
    [icanhazip.com @Icanhazip],[IP adresa],
    [ipinfo.io @IpInfo],[Časová zóna, země, region, město, ZIP kód a souřadnice],
    [disify.com @Disify],[Doména, validita a disposabilita],
    [xposedornot.com @Xposedornot],[Název úniku],
    [genderize.com @Genderize],[Odhad pohlaví a jeho pravděpodobnost],
    [agify.com @Agify],[Odhad věku],
    [nationalize.com @Nationalize],[Odhad země a jeho pravděpodobnost]
  ),
  caption: [Externí API]
)

=== Ostatní nástroje
Mezi ostatní nástroje, které jsem použil, patří Maigret @Maigret a Wget @Wget. Aplikace používá Maigret i Wget lokálně a nepotřebuje se připojovat přes žádnou externí API. Maigret je nástroj na vyhledávání uživatelských přezdívek na populárních sítích a službách. Může však najít falešná pozitiva. Tento problém se mi nepodařilo vyřešit a přetrvává i u podobných nástrojů. Wget je malý nástroj na stahování obrázků.

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
Verze aplikace jsem spravoval přes nástroj Git a kód programu je k dispozici na stránce #link("https://github.com/itsntme1/osint-aggregator")[GitHub]. Pracoval jsem výhradně v editoru VS Code.

== Přehled projektu
=== Přehled souborů
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

Soubory s příponou `.py` jsou napsány v Pythonu. Přípona `.js` značí JavaScript. Přípony `.html` a `.css` značí sebe sama. Soubory končící na `.typ` obsahují typst a soubory bez koncovky jsou složkami.

=== Přehled stránky
#figure(
  image("media/search.png"),
  caption: "Screenshot vyhledávacího formuláře"
)

#figure(
  image("media/dashboard.png"),
  caption: "Screenshot karet"
)

== Implementace backendu
Backend se nachází výhradně v souboru `app.py`. Spuštěním souboru pomocí Python interpreteru se spustí samotná aplikace. 

=== Server aplikace
Stránka je spouštěna lokálně a není hostována na veřejném serveru. Když je spuštěna, běží na `localhost:5000`, kde si ji pomocí prohlížeče můžeme zobrazit.

=== Endpointy
Stránka má dva endpointy #footnote[Podadresa domény, kde je uživateli servírována stránka \ (například `www.stranka.com/landing` nebo `www.stranka.com/dashboard`).] důležité pro uživatele `/`, který slouží pro vyhledávání a jako přistávací endpoint, a `/dashboard`, který slouží pro zobrazování dat. Dále má stránka 8 endpointů interních API, kde dochází k získávání a formátování dat.

=== Zpracování API dotazů <api-request-handling>
Nejdříve je požadavek spuštěn z frontendové části aplikace, kde funkce `loadData()` spustí odpovídající cestu #footnote[Pojem Flasku. V podstatě se jedná o to, co se stane, když je požádáno o endpoint stránky.], určenou argumentem `endpoint` v makru `card()`. Cesta požádá o data z externí API a přeformátuje je. Data jsou nakonec dosazena do schématu podle tabulky `schemaTable` a zobrazena uživateli.

#figure(
  [
    #codly(
      header: [*functions.py*],
      zebra-fill: none,
      offset: 8
    )
    ```python
    def query_api(endpoint: str, headers=None, timeout: int=5):
      try:
        response = requests.get(endpoint, headers=headers, timeout=timeout)

        if response.status_code != 200:
          print(f"Endpoint: {endpoint}")
          print(f"Headers: {headers}")
          print(f'Response: {response.text}')
          print(f"Status code: {response.status_code}")

      except Exception as error:
        print(f"query_api: {error}")
      try:
        return response.json()
      except:
        return response
    ```
  ],
  caption: [Funkce `query_api()`]
)

Implementuji mnoho funkcí okolo `query_api()`, ale všechny pouze mění formát požadavku.

Většinou do nich dodávám nějaký vyhledávací parametr.

#figure(
  [
    #codly(
      header: [*functions.py*],
      zebra-fill: none,
      offset: 34
    )
    ```python
    def query_xposedornot(email: str):
      return query_api(f"https://api.xposedornot.com/v1/check-email/{email}")
    ```
  ],
  caption: [Funkce `query_xposedornot()`]
)

Občas k nim musím do hlavičky nebo jiné části adresy přidat také tajný API klíč #footnote[Také se mu říká token.]. Klíče jsou uloženy v souboru `secret_keys.py`, který je ignorován nástrojem Git.

#figure(
  [
    #codly(
      header: [*functions.py*],
      zebra-fill: none,
      offset: 28
    )
    ```python
    def query_ip_info(ip: str, token: str):
      return query_api(f"https://ipinfo.io/{ip}", {"Authorization": f"Bearer {token}"})
    ```
  ],
  caption: [Funkce `query_ip_info()`]
)

== Implementace uživatelského rozhraní
=== Struktura HTML šablon
Pro generování stránek byl použit systém Jinja @JinjaDocs, který je součástí Flasku. Umožňuje vytvářet znovupoužitelné šablony makra (HTML funkce). Systém je používán v HTML souborech ve složce `templates`.

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
      zebra-fill: none,
      offset: 1
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

V dětské šabloně můžeme použít funkci `super()`, která do ní doplní obsah rodičovské šablony v jejím bloku. Dále pomocí Flasku můžeme vkládat proměnné a provádět s nimi operace. Například ve @landing-jinja vložím proměnnou `error` pokud se nepovede vyhledávání a ona se zobrazí na stránce, pokud má nějaký obsah.

#figure(
  [
    #codly(
      header: [*templates/macros.html*],
      zebra-fill: none,
      offset: 1
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

Dále používám makra, která bych popsal jako funkce pro HTML. Funkci můžeme dát proměnné, které budou doplněny přímo do kódu. Funkce můžeme v jiném templatu, když je importujeme (například takto `{% from 'macros.html' import card %}`).

#figure(
  [
    #codly(
      header: [*templates/dashboard.html*],
      zebra-fill: none,
      offset: 1
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
      <div class="d-flex flex-wrap gap-3 justify-content-center">
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

Ve finální podobě bude HTML kód stránky vypadat tak, že pokud uživatel požádá například o endpoint `/dashboard`, tak dostane soubor spojen s makry, šablony `dashboard.html` a jeho rodiče `layout.html`.

=== Načítání dat
Nejdůležitější funkce pro načítání dat je funkce `loadData()` v souboru `static/script.js`, který se stará o všechen frontend kód.

#figure(
  [
    #codly(
      header: [*static/script.js*],
      zebra-fill: none,
      offset: 3
    )
    ```js
    async function loadData(element) {
      try {
        const endpoint = element.closest("[data-endpoint]").dataset.endpoint;
        const schema = element.closest("[data-schema]").dataset.schema;
        
        const response = await fetch(endpoint);
        const data = await response.json();
        
        element.innerHTML = await schemaTable[schema](data);
      }
      catch (error) {
        console.log(error)

        element.innerHTML = schemaTable['error']();
      }
    }
    ```
  ],
  caption: [Funkce `loadData()`]
)

Funkce bere `element`, kterým je plocha pro obsah karty. Podívá se na svoje rodičovské prvky a načte z nich proměnné data-endpoint a data-schema (V HTML můžeme deklarovat vlastní atributy s pomocí předpony `data-`, což já s pomocí systému Jinja a maker využívám jako proměnné). Zavolá funkci `fetch()` s proměnnou endpoint jako parametrem a výsledek přiřadí do proměnné data. Podívá se na mapu `schemaTable` a do HTML prvku vloží správný obsah podle schématu a dat získaných z endpointu.

Pokud se v průběhu funkce stane chyba, do HTML prvku je vloženo schéma pro chybu.

Ve funkci se vyskytují klíčová slova `await`, která ve spojení s `async` před funkcí způsobí, že program na daném řádku počká na výsledek, než bude postupovat dál."

V souboru `static/script.js` jsou další funkce, které fungují okolo `loadData()`:

- *reloadData():* Spustí se při stisknutí tlačítka obnovit a zavolá `loadData()` pro svoji kartu.
- *initialLoadData():* Spustí se při načtení dokumentu a zavolá `loadData()` pro všechny karty.
- *assignReloadData():* Spustí se při načtení dokumentu a přiřadí `reloadData()` ke všem tlačítkům obnovit.

=== Schémata
Funkce `loadData()` se rozhodne podle `schemaTable`, kterou funkci má zavolat.

#figure(
  [
    #codly(
      header: [*static/schemas.js*],
      zebra-fill: none,
      offset: 1
    )
    ```js
    export const schemaTable = {
      'load': load,
      'error': error,
      'ipInfo': ipInfo,
      'mapyCz': mapyCz,
      'httpHeaders': httpHeaders,
      'disify': disify,
      'maigret': maigret,
      'xposedornot': xposedornot,
      'nameInfo': nameInfo
    };
    ```
  ],
  caption: [Hašovací tabulka `schemaTable`]
)

Každá funkce vrátí HTML jako string a funkce `loadData()` ho dosadí na správné místo do karty. Funkce přijímají jako argument JSON #footnote[JSON je zkratka pro "JavaScript Object Notation" a populární formát pro přenos dat mezi jazyky a službami.] data, které do stringu dosazují.

#figure(
  [
    #codly(
      header: [*static/schemas.js*],
      zebra-fill: none,
      offset: 232
    )
    ```js
    export function nameInfo(data) {
      return `
        <ul class="list-group list-group-flush">
          <li class="list-group-item">
            <p class="d-inline fw-semibold">Name:</p>
            <p class="float-end m-0">${data.name}</p>
          </li>
          <li class="list-group-item">
            <p class="d-inline fw-semibold">Gender:</p>
            <p class="float-end m-0">${data.gender} (${data.gender_probability}% sure)</p>
          </li>
          <li class="list-group-item">
            <p class="d-inline fw-semibold">Age:</p>
            <p class="float-end m-0">${data.age}</p>
          </li>
          <li class="list-group-item">
            <p class="d-inline fw-semibold">Country:</p>
            <p class="float-end m-0">${data.country} (${data.country_probability}% sure)</p>
          </li>
        </ul>
      `;
    }
    ```
  ],
  caption: [Funkce `nameInfo()`]
)

Některá schémata také obsahují logiku pro lepší formátování. Například schéma `Maigret`.

#figure(
  [
    #codly(
      header: [*static/schemas.js*],
      zebra-fill: none,
      offset: 145
    )
    ```js
    export function maigret(data) {
      let outputData = "";
      let sitesData = "";

      for(let username in data) {
        for(let site in data[username]) {
          sitesData += `
            <li class="list-group-item">
              <p class="p-0 d-inline fw-semibold">${data[username][site]['site']}</p>
              <a class="float-end me-2 text-dark" href="${data[username][site]['url']}" target="_blank"><i class="bi bi-link-45deg"></i></a>
            </li>
          `;
        }

        outputData += `
          <li class="list-group-item">
            <p class="fw-bold">${username}</p>
            <ul class="list-group">
              ${sitesData}
            </ul>
          </li>
        `;
      }

      return `
        <ul class="list-group list-group-flush">
          ${outputData}
        </ul>
      `;
    }
    ```
  ],
  caption: [Funkce `maigret()`]
)

Toto schéma používá cykly a podmínky, aby vytvořilo list úniků pro každý email a kontrolovalo, jestli byly vůbec nějaké úniky nalezeny.

Dále jsou tu speciální schémata `load`, `error`, `disifyError` a `xposedornotError`, které nevyžadují žádné argumenty a pouze vrací animaci, nebo zprávu o chybě.

=== Stylování
Ke stylování používám většinou knihovnu Bootstrap. Mám ale v souboru `static/style.css` pár vlastních stylů, které slouží, pro drobné úpravy pozic, velikostí a načítací animaci pro karty.

Bootstrap funguje pomocí CSS tříd, které se dosazují do HTML prvku.

Jednou z nejdůležitějších funkcí Bootstrapu je systém breakpointů. Breakpoint má 3 hlavní části. První část uvádí vlastnost, kterou upravujeme. Druhá část specifikuje šířku obrazovky, pokud je nižší, aplikuje se nižší breakpoint, pokud je specifikován. Třetí část specifikuje šířku prvku od 1 do 12 (maximální délka je rozdělena do 12 dílů). Například `column-12 column-lg-4` bude mít 1 sloupec na řadu na malých obrazovkách a 3 na velkých. Systém je obzvlášť užitečný pro design, který má vypadat dobře na mobilním telefonu i počítači zároveň.

Je tu mnoho dalších funkcí.

#figure(
  [
    #codly(
      header: [*templates/landing.html*],
      zebra-fill: none,
      offset: 9
    )
    ```html
    <div class="card border-dark shadow">
      <div class="card-body">
        <div class="row mb-3 px-2">
          <label for="name" class="form-label fw-semibold">Name</label>
          <input name="name" type="text" class="form-control" placeholder="John Doe">
        </div>
        <div class="row mb-3 px-2">
          <label for="usernames" class="form-label fw-semibold">Usernames</label>
          <input name="usernames" type="text" class="form-control" placeholder="username1 username2 ...">
        </div>
        <div class="row mb-4 px-2">
          <label for="emails" class="form-label fw-semibold">Emails</label>
          <input name="emails" type="text" class="form-control" placeholder="user1@email.cz user2@email.cz ...">
        </div>
      </div>

      <!-- kód pro vyhledávací tlačítko -->
    </div>
    ```
  ],
  caption: [Formulář pro vyhledávání]
)

Například třída `card` používá stylování pro bootstrap komponent karty. Třída `shadow` aplikuje na prvek černý stín, `border-dark` vytváří černý okraj a `form-control` přidává stylování pro pole formulářů.

== Integrace externích služeb
=== Práce s daty
Když je zavolána cesta, spustí se její funkce v `app.py`. Nachází se cesta pro každou interní API. Cesta je volána z frontendu.

#figure(
  [
    #codly(
      header: [*app.py*],
      zebra-fill: none,
      offset: 137
    )
    ```python
    @app.route("/api/xposedornot")
    def xposedornot():
      data = {}

      for email in session['emails']:
        xposedornot_data = query_xposedornot(email)

        data[email] = xposedornot_data

        # This is here to avoid rate limits
        time.sleep(1)

      export_to_json(data, "xposedornot", session, session['user_hash'])

      return data
    ```
  ],
  caption: [Cesta interní API pro xposedornot]
)

Dekorátor `@app.route()` přiřadí k cestě endpoint. Pro interní API `xposedornot` je odhalen endpoint `/api/xposedornot`. Dále se pro každý email, který byl zadán do vyhledávacího formuláře a uložen v cookies, získají data z externí API. Mezi požadavky musí být nějaký interval, aby se zamezilo zablokování kvůli DDOS ochraně. Data jsou exportována do složky `export`.

#figure(
  [
    #codly(
      header: [*functions.py*],
      zebra-fill: none,
      offset: 58
    )
    ```python
    def export_to_json(variable, name, session, user_hash):
      with open(f"export/{user_hash}_{name}.json", "w") as file:
        json.dump(variable, file)
    ```
  ],
  caption: [Funkce `export_to_json()`]
)

Funkce uloží data do souboru typu JSON a pojmenuje ho podle uživatelského hashe a názvu služby. Hash je vytvořen pomocí hashovací funkce, která jako argument bere uživatelovo jméno, přezdívky a emaily. Tato metoda vytvoří číslo unikátní pro argumenty funkce, což umožní pracovat s daty pro více uživatelů současně.

Existují také funkce `load_from_json()` a `load_report()`, které se starají o načítání dat z JSONu.

=== Wget
Wget je použit pouze pro stažení statické mapy z "mapy.com".

=== Maigret
Nástroj Maigret slouží pro vyhledávání daných uživatelských jmen na známých službách. Je spouštěn pomocí vestavěné pythonové funkce `subprocess.run()`, jehož výsledkem je vytvoření zprávy a její následné uložení do složky `reports`.

#figure(
  [
    #codly(
      header: [*functions.py*],
      zebra-fill: none,
      offset: 46
    )
    ```python
    def run_maigret(username: str):
      arguments = ["maigret", "--no-recursion", "--json", "simple"]
      arguments.extend([username])

      subprocess.run(arguments)
    ```
  ],
  caption: [Funkce `run_maigret()`]
)

== Generování reportu
=== Vytváření reportu
Export se odehrává v cestě `/export`. Nejdříve se stáhne mapa a načtou se data z JSON souborů uložených ve složce `export`. Všechna data se uloží do jednoho objektu a ten se podá funkci na kompilaci souboru, která pochází z pythonového modulu pro Typst.

#figure(
  [
    #codly(
      header: [*app.py*],
      zebra-fill: none,
      offset: 202
    )
    ```python
    typst.compile("report.typ",
      output=f"reports/{session['name']}_report.pdf",
      sys_inputs=data
    )
    ```
  ],
  caption: [Funkce pro kompilaci reportu]
)

Funkce zkompiluje soubor `report.typ`.

=== Fungování Typstu
V souboru nejdřív importujeme proměnné z našeho objektu.

#figure(
  [
    #codly(
      header: [*report.typ*],
      zebra-fill: none,
    )
    ```typ
    #let data = sys.inputs

    #let name = data.name
    #let usernames = json(bytes(data.usernames))
    #let emails = json(bytes(data.emails))
    #let ip-info = json(bytes(data.ip_info))
    #let map-location = json(bytes(data.map_location))
    #let coordinates = json(bytes(data.coordinates))
    #let http-headers = json(bytes(data.http_headers))
    #let disify = json(bytes(data.disify))
    #let maigret = json(bytes(data.maigret))
    #let xposedornot = json(bytes(data.xposedornot))
    #let name-info = json(bytes(data.name_info))
    ```
  ],
  caption: [Importování proměnných v Typstu]
)

Dále se nastaví vzhled dokumentu.

#figure(
  [
    #codly(
      header: [*report.typ*],
      zebra-fill: none,
      offset: 15
    )
    ```typ
    #set text(size: 11pt)
    #show heading: set block(above: 30pt, below: 30pt)
    #show link: set text(fill: blue)


    #set table(
      stroke: (x, y) => (
        right: if x == 0 {1pt},
        bottom: if y == 0 {1pt}
      ),
      align: (x, _) => if x == 0 {left} else {center},
    )
    ```
  ],
  caption: [Konfigurace dokumentu]
)

Poté už můžeme psát obsah. V dokumentu používám například funkce pro tabulky nebo zarovnání textu. Rovná se se používají pro nadpisy a hvězdičky pro zvýraznění textu. Jelikož jsme si importovali proměnné, můžeme s nimi pracovat pomocí různých metod. Například metoda `.join(", ")` spojí členy listu čárkou a mezerou v souvislý text.

#figure(
  [
    #codly(
      header: [*report.typ*],
      zebra-fill: none,
      offset: 28
    )
    ```typ
    #align(center)[#title("Report for " + [#name])]

    == Personal Info
    #table(
      columns: (auto, 1fr, 1fr),
      table.header([*#name*],[],[*Probability*]),
      [*Age*], [#name-info.age], [],
      [*Country*], [#name-info.country], [#name-info.country_probability],
      [*Gender*], [#name-info.gender], [#name-info.gender_probability]
    )
    *Usernames*: #usernames.join(", ") \
    *Emails*: #emails.join(", ")
    ```
  ],
  caption: [Ukázka tabulky a zarovnávání v Typstu]
)

Můžeme také používat cykly.

#figure(
  [
    #codly(
      header: [*report.typ*],
      zebra-fill: none,
      offset: 103
    )
    ```typ
    == Maigret Lookup
    #for (username, sites) in maigret {
      align(center)[\ \ *#username*]
      line(length: 100%)

      for (site, data) in sites {
        grid(
          columns: (1fr, 2fr),
          column-gutter: 20pt,
          [*#site*:], align(right)[#link(data.url)]
        )
      }
    }
    ```
  ],
  caption: [Ukázka cyklů v Typstu]
)

#pagebreak()
= Vyhodnocení
Se svou prací nejsem spokojen. Kdybych měl možnost udělat ji znovu, rozhodně bych změnil systém načítání dat přes frontend tlačítko. Byl to špatný nápad. Všechny informace bych začal shánět a načítat hned poté, co je uživatel zadá do formuláře, a vše by bylo nezávislé na frontendu. Dále bych se pokusil změnit například HTML kód, který mám v javascriptovém stringu.

Celkově jsem spokojený s funkčností mojí práce, ale změnil bych provedení. Mohl bych také přidat například zjišťování lokace uživatele nezávisle na IP adrese.

#pagebreak()
= Závěr <unnumbered>
Tvorbu práce jsem si celkem užil a můžu říci, že jsem se naučil nové věci. Nejhodnotnější mi připadají moje nové zkušenosti s jazykem Typst, jelikož se mi bude hodit na jakékoliv další práce. Myslím si, že finální produkt vizuálně vypadá celkem dobře a jsem s ním po vzhledové stránce spokojen.

#pagebreak()

#set page(numbering: none)
#bibliography("sources.bib")