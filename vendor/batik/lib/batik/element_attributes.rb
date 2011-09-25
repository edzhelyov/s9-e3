module Batik
  module ElementAttributes
    module Coordinates
      def coordinates(x, y)
        @attributes[:x] = x
        @attributes[:y] = y
      end
    end

    module CircleCoordinates
      def coordinates(x, y)
        @attributes[:cx] = x
        @attributes[:cy] = y
      end
    end

    module Dimension
      def dimensions(width, height)
        @attributes[:width] = width
        @attributes[:height] = height
      end
    end

    module Color
      def color(options)
        @attributes[:fill] = options[:fill] if options[:fill]
        @attributes[:stroke] = options[:stroke] if options[:stroke]
      end
    end

    module Transformations
      def translate(tx, ty = 0)
        @attributes['transform'] ||= ""
        @attributes['transform'] += "translate(#{tx}, #{ty}) "
      end

      def scale(sx, sy = sx)
        @attributes['transform'] ||= ""
        @attributes['transform'] += "scale(#{sx}, #{sy}) "
      end

      def rotate(angle)
        @attributes['transform'] ||= ""
        @attributes['transform'] += "rotate(#{angle}) "
      end
    end
  end
end
