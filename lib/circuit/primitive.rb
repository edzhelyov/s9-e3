module Circuit
  class Primitive
    attr_accessor :type, :inputs, :color

    def self.factory(type, options = {})
      Circuit.const_get(type.to_s).new(options)
    end

    def initialize(options = {})
      @type = options['type']
      @inputs = options['inputs'] || [OFF, OFF]
      @color = 'red'
    end

    def connect_with(pos, other)
      @inputs[pos] == other
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

      svg = Batik::SVG.new(:width => 40, :height => 40)
      group = Batik::Group.new('data-type' => type, 'font-size' => 8)
      group.rectangle(:fill => color, :x => 0, :y => 0, :width => 40, :height => 40)
      build_inputs(group)
      group.circle(:class => 'output', :cx => 35, :cy => 20, :r => 3, 'data-source' => 'off', :fill => output)
      group.text(:x => 10, :y => 22, :body => type)
      svg.elements << group

      svg
    end

    def build_inputs(group)
      input_1 = inputs[0].execute ? 'yellow' : 'black'
      input_2 = inputs[1].execute ? 'yellow' : 'black'
      group.circle(:class => 'input', :cx => 5, :cy => 5, :r => 3, 'data-source' => '0', :fill => input_1)
      group.circle(:class => 'input', :cx => 5, :cy => 35, :r => 3, 'data-source' => '1', :fill => input_2)
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
      group.circle(:class => 'input', :cx => 5, :cy => 5, :r => 3, 'data-source' => '0', :fill => input_1)
    end

    def execute
      ! @inputs[0].execute
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
