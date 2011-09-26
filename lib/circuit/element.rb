module Circuit
  class Element
    attr_reader :primitive, :id

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

    def disconnect(pos, other)
      @primitive.disconnect(pos)
    end

    def connect_with(pos, other)
      @primitive.connect_with(pos, other.primitive)
    end

    def output_coordinates
      Point.new(@x + Primitive::OUTPUT[:x], @y + Primitive::OUTPUT[:y])
    end

    def input_coordinates(source)
      case source
      when 0
        Point.new(@x + Primitive::INPUT_1[:x], @y + Primitive::INPUT_1[:y])
      when 1
        Point.new(@x + Primitive::INPUT_2[:x], @y + Primitive::INPUT_2[:y])
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
    attr_reader :from, :to, :source

    def initialize(from, to, source)
      @from = from
      @to = to
      @source = source

      draw(@from.output_coordinates, @to.input_coordinates(@source))
    end

    def draw(from, to)
      line = "M #{from.x} #{from.y} L #{to.x} #{to.y}"
      @wire = Batik::Path.new(:stroke => 'lightgray', 'stroke-width' => 3, :d => line, 'data-from' => @from.id , 'data-to' => @to.id, 'data-source' => @source, :class => 'wire')
    end

    def to_svg
      @wire
    end

    def ==(other)
      @from == other.from && @to == other.to && @source == other.source
    end
  end
end
