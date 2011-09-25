require_relative '../lib/batik'

svg = Batik::SVG.new(width: 200, height: 200) do
  rectangle x: 10, y: 10, width: 180, height: 180, fill: 'cyan'
  circle cx: 10, cy: 20, r: 5, fill: 'black'
  circle cx: 10, cy: 170, r: 5, fill: 'black'
end

svg.text x: 40, y: 160, body: 'Signature at the bottom'

File.open('rectangle_with_two_circles.svg', 'w+') do |file|
  file << svg.to_s
end
