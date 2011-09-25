module Batik
  class Rectangle < Element
    include ElementAttributes::Coordinates
    include ElementAttributes::Dimension

    set_type 'rect'
    register 'rectangle'
  end
end
