require_relative '../lib/batik'

filename = 'polygon_and_ellipse_with_transformation.svg'
Batik::SVG.draw(filename, width: '1200', height: '400') do
  polygon :fill => 'red',
          :points => '850,75  958,137.5 958,262.5 850,325 742,262.6 742,137.5'
  ellipse :transform =>'translate(900 200) rotate(-30)', :rx => 250, :ry => 100,
          :fill => 'none', :stroke => 'blue', 'stroke-width' => 20
end
