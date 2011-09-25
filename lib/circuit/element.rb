module Circuit
  class Element
    attr_reader :primitive

    def initialize(id, primitive, x, y)
      @primitive = primitive
      @id = id
      @x = x.to_i
      @y = y.to_i
    end

    def transform
      "translate(#{@x}, #{@y})"
    end

    def to_svg
      group = Batik::Group.new(:id => @id, :class => 'element', :transform => transform)
      group.elements.concat(@primitive.svg.elements)

      group
    end

    def toggle_source(source)
      @primitive.toggle_source(source)
    end

    def connect_with(pos, other)
      @primitive.connect_with(pos, other.primitive)
    end

    def output_coordinates
      Point.new(@x + 35, @y + 20)
    end

    def input_coordinates(source)
      case source
      when 0
        Point.new(@x + 5, @y + 5)
      when 1
        Point.new(@x + 5, @y + 35)
      end
    end

    class Point
      attr_reader :x, :y

      def initialize(x, y)
        @x, @y = x, y
      end
    end
  end

  class Wire
    def initialize(from, to)
      @from = from
      @to = to

      line = "M #{from.x} #{from.y} L #{to.x} #{to.y}"
      @wire = Batik::Path.new(:stroke => 'blue', :d => line)
    end

    def to_svg
      @wire
    end
  end
end
