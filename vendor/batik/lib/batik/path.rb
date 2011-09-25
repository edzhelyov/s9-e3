module Batik
  class Path < Element
    def move(x, y)
      @attributes[:d] ||= ""
      @attributes[:d] += "M #{x} #{y} "
    end

    def line(x, y)
      @attributes[:d] ||= ""
      @attributes[:d] += "L #{x} #{y} "
    end

    def horizontal_line(x)
      @attributes[:d] ||= ""
      @attributes[:d] += "H #{x} "
    end

    def vertical_line(y)
      @attributes[:d] ||= ""
      @attributes[:d] += "V #{y} "
    end

    def curve(x1, y1, x2, y2, x, y)
      @attributes[:d] ||= ""
      @attributes[:d] += "C #{x1} #{y1} #{x2} #{y2} #{x} #{y} "
    end

    def smooth_curve(x2, y2, x, y)
      @attributes[:d] ||= ""
      @attributes[:d] += "S #{x2} #{y2} #{x} #{y} "
    end

    def close
      @attributes[:d] ||= ""
      @attributes[:d] += "Z "
    end

    set_type 'path'
    register 'path'
  end
end
