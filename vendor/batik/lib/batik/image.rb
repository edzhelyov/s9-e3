module Batik
  class Image < Element
    include ElementAttributes::Coordinates
    include ElementAttributes::Dimension

    def link(href)
      @attributes['xlink-href'] = href
    end

    set_type 'image'
    register 'image'

    def initialize(attributes = {})
      super
      convert_href_attribute
    end

    def convert_href_attribute
      href = @attributes.delete(:href) || @attributes.delete('href')
      @attributes['xlink-href'] = href if href
    end
  end
end
