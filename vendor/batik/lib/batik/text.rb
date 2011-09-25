module Batik
  class Text < Element
    include ElementAttributes::Coordinates

    def body(text)
      @attributes[:body] = text
    end

    set_type 'text'
    register 'text'

    def text
      @text ||= @attributes.delete(:body)
    end

    def to_batik_element(doc)
      text # Force text creation
      batik_element = super
      batik_element.appendChild(doc.createTextNode(text))
      batik_element
    end
  end
end
