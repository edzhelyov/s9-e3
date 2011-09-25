module Batik
  class SVG
    attr_reader :elements

    include SVGElements

    def self.draw(filename, options = {}, &block)
      svg = new(options, &block)

      File.open(filename, 'w+') do |file|
        file << svg.to_s
      end
    end

    def initialize(options = {}, &block)
      @root_attributes = options
      @elements = []

      instance_exec(&block) if block_given?
    end

    def to_s
      document = Document.new(@root_attributes, @elements)

      document.to_s
    end
  end
end
