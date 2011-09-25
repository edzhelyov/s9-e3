module Circuit
  class Element
    attr_reader :primitive

    def initialize(id, primitive, x, y)
      @primitive = primitive
      @id = id
      @x = x
      @y = y
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
  end
end
