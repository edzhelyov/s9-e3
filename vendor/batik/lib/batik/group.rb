module Batik
  class Group < Element
    attr_reader :elements

    include SVGElements

    set_type 'g'
    register 'group'

    def initialize(attributes = {}, &block)
      @elements = []

      super
    end

    def to_batik_element(doc)
      batik_element = super
      # TODO: This duplicates the code from Document#append_elements
      elements.each do |element|
        batik_element.appendChild(element.to_batik_element(doc))
      end
      
      batik_element
    end
  end
end
