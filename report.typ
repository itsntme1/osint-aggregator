#let name = json("export/name.json")
#let usernames = json("export/usernames.json")
#let emails = json("export/emails.json")
#let ip-info = json("export/ip_info.json")
#let coordinates = json("export/coordinates.json")
#let http-headers = json("export/http_headers.json")
#let disify = json("export/disify.json")
#let maigret = json("export/maigret.json")
#let xposedornot = json("export/xposedornot.json")
#let name-info = json("export/name_info.json")


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

#align(center)[#title("Report for " + [#name])]

== Personal Info
#table(
  columns: (auto, 1fr, 1fr),
  table.header([#name],[],[Probability]),
  [Age], [#name-info.age], [],
  [Country], [#name-info.country], [#name-info.country_probability],
  [Gender], [#name-info.gender], [#name-info.gender_probability]
)
Usernames: #usernames.join(", ") \
Emails: #emails.join(", ")

== HTTP Headers
#grid(
    columns: (1fr, 1fr),
    row-gutter: 10pt,
    [User Agent],align(right)[#http-headers.user_agent],
    [Operating System],align(right)[#http-headers.os],
    [Language],align(right)[#http-headers.language]
)

== Email Info
#for (email, data) in disify {
  align(center)[\ \ *#email*]
  line(length: 100%)

  grid(
    columns: (1fr, 1fr),
    row-gutter: 10pt,
    [*Domain*],align(right)[#data.domain],
    [*Valid*],align(right)[#data.valid],
    [*Disposable?*],align(right)[#data.disposable]
  )
}

== Email Credentials Breaches
#for (email, data) in xposedornot {
  if data.values().len() == 2 [
    #grid(
      columns: (1fr, 1fr),
      [*#email*:], align(right)[No breaches detected]
    )
  ] else [
    #grid(
      columns: (1fr, 1fr),
      [*#email*:], align(right)[#for breach in data.breaches.at(0) {breach}]
    )
  ]
}

== IP Info
#align(center)[*#ip-info.ip*]
#line(length: 100%)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 20pt,
  grid(
    columns: (1fr, 1fr),
    row-gutter: 10pt,
    [Country],align(right)[#ip-info.country],
    [Region],align(right)[#ip-info.region],
    [City],align(right)[#ip-info.city],
  ),
  grid(
    columns: (1fr, 1fr),
    row-gutter: 10pt,
    [Timezone],align(right)[#ip-info.timezone],
    [Postal Code],align(right)[#ip-info.postal],
    [Coordinates],align(right)[#coordinates.at(0)#sym.degree #coordinates.at(1)#sym.degree]
  )
)

#image("export/map.png")

== Maigret Lookup
#for (username, sites) in maigret {
  align(center)[\ \ *#username*]
  line(length: 100%)

  for (site, data) in sites {
    grid(
      columns: (1fr, 2fr),
      column-gutter: 20pt,
      [#site:], align(right)[#link(data.url)]
    )
  }
}