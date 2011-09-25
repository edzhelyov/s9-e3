require 'json'

module Circuit
  class Elements
    attr_reader :elements, :map

    def self.from_json(json)
      elements = JSON.parse(json)

      new(elements.map{ |e| Primitive.factory(e['type'], e) })
    end

    def initialize(elements)
      @map = {}
      elements.each do |e|
        @map[e.id] = e
      end

      elements.each do |e|
        e.inputs = e.inputs.map{ |i| @map[i] }
        e.output = e.output.map{ |o| @map[o] }
      end

      @elements = elements
    end
  end
end
