require_relative '../lib/batik'

Batik::SVG.draw('path_that_draw_triangle.svg', width: 400, height: 400) do
  path :d => 'M 100 100 L 300 100 L 200 300 z', :fill => 'red',
       :stroke => 'blue', 'stroke-width' => 3
end
