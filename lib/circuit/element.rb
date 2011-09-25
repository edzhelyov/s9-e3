module Circuit
  class Element
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
      group = Batik::Group.new(:id => @id, :transform => transform)
      group.elements.concat(@primitive.svg.elements)

      group
    end

    def toggle_source(source)
      @primitive.toggle_source(source)
    end
  end
end
