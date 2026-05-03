#let meeting = json("meetings.json").first()
#let drivers = json("drivers.json")
// #let starting_grid = json("starting_grid.json")
#let circuit_info = json("circuit_info.json")
#let sessions = json("sessions.json")
#let session_result = json("session_result.json")
#let qualifying_session_key = sessions.find(x => {x.session_name == "Qualifying"}).session_key
#let race_session_key = sessions.find(x => {x.session_name == "Race"}).session_key
#import "circuit.typ": *

#set page(margin: .5in)
#set text(font: "FreeSans")
// #set box(stroke: 1pt)

#let race_results = session_result.filter(x => {x.session_key == race_session_key})

#place(top + right, box(image("F1.svg", width: 2in)))
#box(width: 70%)[
  #text(meeting.meeting_name, size: 30pt)\
  #meeting.location
  #box(height: 1.5em, baseline: .5em, image("circuit.png"))
  #meeting.country_name
  #box(height: 1em,baseline: .1em, image("flag.png"))

//#image("circuit.png")
{date} //#datetime(session.date_start)

#line(length: 100%)
]


// #set grid.cell(stroke: 1pt)
#grid(columns: (80%, 1fr), gutter: 1em, inset: 2pt,
  grid(
    columns: (3em, 32pt, 1fr, 8em, 1fr),
    gutter: 4pt,

    "#", grid.cell(colspan: 2)[driver], [Time], [kk],

    ..for x in race_results {
    let driver = drivers.find(y => {y.driver_number == x.driver_number})
    (
    align(center + horizon, "1"),
    align(horizon, image("flag.png")),
    stack(spacing: 2pt,
      text(12pt, fill: rgb(driver.team_colour))[#driver.broadcast_name],
      text(9pt, fill: rgb(driver.team_colour))[#driver.team_name] 
    ),
    if type(x.duration) == float {str(x.duration)},
    str(x.points),
    )}
  ),
  [sdlfkjsldkjflsjkdlfkj]
)



// Encode and display
//#let encoded = image.encode(svg_content, format: "svg")
//#image.decode(svg_content))
#image(bytes(info2svg("circuit_info.json", img_width: 800, img_height: 600)))
