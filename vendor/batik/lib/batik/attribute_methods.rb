module Batik
  module AttributeMethods
    def set_attributes(element, attributes)
      attributes.each do |key, value|
        element.setAttributeNS(nil, key.to_s, value.to_s)
      end
    end
  end
end
