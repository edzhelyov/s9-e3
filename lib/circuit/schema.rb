module Circuit
  class Schema
    def initialize
      @elements = []
      @map = {}
      @uid = 0
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

    def next_uid
      @uid += 1
    end

    def add_element(primitive, x, y)
      id = next_uid
      el = Element.new(id, primitive, x, y)
      @map[id] = el
      @elements << el
    end

    def toggle_source(id, source)
      @map[id].toggle_source(source)
    end

    def connect(from, to, source)
      from = @map[from]
      to = @map[to]
      to.connect_with(source, from)
      draw_wire(from, to, source)
    end

    def disconnect(from, to, source)
      from = @map[from]
      to = @map[to]
      to.disconnect(source, from)
      remove_wire(from, to, source)
    end

    def toggle_connection(from, to, source)
      f= @map[from]
      t= @map[to]
      if @elements.include?(Wire.new(f, t, source))
        disconnect(from, to, source)
      else
        connect(from, to, source)
      end
    end

    def draw_wire(from, to, source)
      @elements << Wire.new(from, to, source)
    end

    def remove_wire(from, to, source)
      @elements.delete(Wire.new(from, to, source))
    end
  end
end
