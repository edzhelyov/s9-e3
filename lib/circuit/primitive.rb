module Circuit
  class Primitive
    attr_accessor :type, :inputs, :color
    WIDTH = 50
    HEIGTH = 40
    RADIUS = 4
    OUTPUT = { :x => WIDTH - RADIUS - 2, :y => HEIGTH / 2 }
    INPUT_1 = { :x => 2 + RADIUS, :y => 2 + RADIUS }
    INPUT_2 = { :x => 2 + RADIUS, :y => HEIGTH - RADIUS - 2 }

    def self.factory(type, options = {})
      Circuit.const_get(type.to_s).new(options)
    end

    def initialize(options = {})
      @type = options['type']
      @inputs = options['inputs'] || [OFF, OFF]
      @color = 'red'
    end

    def connect_with(pos, other)
      unless [ON, OFF].include?(@inputs[pos])
        return false
      end
      @inputs[pos] = other
    end

    def disconnect(pos)
      @inputs[pos] = OFF
    end

    def toggle_source(source)
      inp = inputs[source]
      if inp == ON
        inputs[source] = OFF
      elsif inp == OFF
        inputs[source] = ON
      end
    end

    def svg
      # Fix naming collision with Batik's own #color
      type = @type
      color = @color
      output = execute ? 'yellow' : 'black'

      svg = Batik::SVG.new(:width => WIDTH, :height => HEIGTH)
      group = Batik::Group.new('data-type' => type, 'font-size' => 8)
      group.rectangle(:fill => color, :x => 0, :y => 0, :width => WIDTH, :height => HEIGTH)
      build_inputs(group)
      group.circle(:class => 'output', :cx => OUTPUT[:x], :cy => OUTPUT[:y], :r => RADIUS, 'data-source' => 'off', :fill => output)
      build_text(group)
      svg.elements << group

      svg
    end

    def build_inputs(group)
      input_1 = inputs[0].execute ? 'yellow' : 'black'
      input_2 = inputs[1].execute ? 'yellow' : 'black'
      group.circle(:class => 'input', :cx => INPUT_1[:x], :cy => INPUT_1[:y], :r => RADIUS, 'data-source' => '0', :fill => input_1)
      group.circle(:class => 'input', :cx => INPUT_2[:x], :cy => INPUT_2[:y], :r => RADIUS, 'data-source' => '1', :fill => input_2)
    end

    def build_text(group)
      group.text(:x => 10, :y => 22, :body => type)
    end

    def to_svg
      svg.to_s
    end
  end

  class AND < Primitive
    def initialize(options = {})
      super
      @type = 'AND'
      @color = 'green'
    end

    def execute
      @inputs[0].execute && @inputs[1].execute
    end
  end

  class OR < Primitive
    def initialize(options = {})
      super
      @type = 'OR'
      @color = 'cyan'
    end

    def execute
      @inputs[0].execute || @inputs[1].execute
    end
  end

  class XOR < Primitive
    def initialize(options = {})
      super
      @type = 'XOR'
      @color = 'violet'
    end

    def execute
      @inputs[0].execute ^ @inputs[1].execute
    end
  end

  class NOT < Primitive
    def initialize(options = {})
      @inputs = options[:inputs] || [OFF]
      @type = 'NOT'
      @color = 'red'
    end

    def build_inputs(group)
      input_1 = inputs[0].execute ? 'yellow' : 'black'
      group.circle(:class => 'input', :cx => INPUT_1[:x], :cy => INPUT_1[:y], :r => RADIUS, 'data-source' => '0', :fill => input_1)
    end

    def execute
      ! @inputs[0].execute
    end
  end

  class SWITCH < NOT
    def initialize(options = {})
      super
      @type = 'SWITCH'
      @color = 'gray'
    end

    def build_text(group)
      group.text(:x => 5, :y => 22, :body => type)
    end

    def execute
      @inputs[0].execute
    end
  end

  class ON
    def self.execute
      true
    end

    def self.connection_size
      0
    end
  end

  class OFF
    def self.execute
      false
    end

    def self.connection_size
      0
    end
  end
end
