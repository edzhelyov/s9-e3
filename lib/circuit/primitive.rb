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

    def svg
      # Fix naming collision with Batik's own #color
      type = @type
      color = @color
      input_1 = inputs[0].execute ? 'yellow' : 'black'
      input_2 = inputs[1].execute ? 'yellow' : 'black'
      output = execute ? 'yellow' : 'black'

      Batik::SVG.new(:width => 40, :height => 40) do
        group('data-type' => type, 'font-size' => 8) do
          rectangle(:fill => color, :x => 0, :y => 0, :width => 40, :height => 40)
          circle(:class => 'input', :cx => 5, :cy => 5, :r => 3, 'data-source' => 'off', :fill => input_1)
          circle(:class => 'input', :cx => 5, :cy => 35, :r => 3, 'data-source' => 'off', :fill => input_2)
          circle(:class => 'output', :cx => 35, :cy => 20, :r => 3, 'data-source' => 'off', :fill => output)
          text(:x => 10, :y => 22, :body => type)
        end
      end
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

  class ON
    def self.execute
      true
    end
  end

  class OFF
    def self.execute
      false
    end
  end
end
