module Circuit
  class Schema
    def initialize
      @elements = []

    end

    def container
      Batik::SVG.new(:width => '100%', :height => '100%', :id => 'circuit') do
        rectangle :fill => 'black', :x => 0, :y => 0, :width => '100%', :height => '100%'
      end
    end

    def to_s
      svg = container
      @elements.each do |e|
        svg.elements << e.to_svg
      end

      svg.to_s
    end

    def add_element(primitive, x, y)
      id = @elements.size
      @elements << Element.new(id, primitive, x, y)
    end

    def toggle_source(id, source)
    end

    def connect(from, to, source)
    end
  end
end
