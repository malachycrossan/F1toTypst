#let drivers = json("drivers.json")
#let meeting = {
  let data = json("meetings.json")
  if data.len() == 0 {} else {}
}
#let starting_grid = json("starting_grid.json")
#let circuit_info = json("circuit_info.json")
#import "circuit.typ": *

#meeting

#meeting.meeting_name

#meeting.location
#box(height: 1.5em, baseline: .5em, image("circuit.png"))
//#meeting.country_name
#box(height: 1em,baseline: .1em, image("flag.png"))

//#image("circuit.png")
{date} //#datetime(session.date_start)



// Encode and display
//#let encoded = image.encode(svg_content, format: "svg")
//#image.decode(svg_content))
#image(bytes(info2svg("circuit_info.json", img_width: 800, img_height: 600)))