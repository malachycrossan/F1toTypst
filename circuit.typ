#let info2svg(file, img_width: int, img_height: int) = {
  let data = json(file)

  let corners = data.corners
  let x_coords = data.x
  let y_coords = data.y

  // Find bounds
  let min_x = calc.min(..x_coords)
  let max_x = calc.max(..x_coords)
  let min_y = calc.min(..y_coords)
  let max_y = calc.max(..y_coords)

  let width = max_x - min_x
  let height = max_y - min_y
  let padding = 50

  let scale_x = (img_width - 2 * padding) / width
  let scale_y = (img_height - 2 * padding) / height
  let scale = calc.min(scale_x, scale_y)

  // Generate SVG
  {
    let path_points = x_coords.enumerate().map(((i, x)) => {
      let y = y_coords.at(i)
      let px = padding + (x - min_x) * scale
      let py = padding + (max_y - y) * scale
      str(px) + "," + str(py)
    }).join(" ")
    
    "<svg viewBox=\"0 0 " + str(img_width) + " " + str(img_height) + "\" xmlns=\"http://www.w3.org/2000/svg\">" + "<rect width=\"" + str(img_width) + "\" height=\"" + str(img_height) + "\" fill=\"white\"/>" + "<polyline points=\"" + path_points + "\" fill=\"none\" stroke=\"blue\" stroke-width=\"2\"/>" + corners.map(corner => {
      let cx = padding + (corner.trackPosition.x - min_x) * scale
      let cy = padding + (max_y - corner.trackPosition.y) * scale
      "<circle cx=\"" + str(cx) + "\" cy=\"" + str(cy) + "\" r=\"10\" fill=\"orange\"/>" + "<text x=\"" + str(cx) + "\" y=\"" + str(cy + 4) + "\" font-size=\"12\" text-anchor=\"middle\" fill=\"black\">" + str(corner.number) + "</text>"
    }).join("") + "</svg>"
  }
}