module Batik
  import org.apache.batik.dom.svg.SVGDOMImplementation
  import org.apache.batik.dom.util.DOMUtilities
  import java.io.StringWriter

  class Document
    include AttributeMethods

    def initialize(root_attributes, elements)
      create_document
      set_attributes(@root, root_attributes)
      append_elements(elements)
    end

    def create_document
      dom = SVGDOMImplementation.getDOMImplementation
      @doc = dom.createDocument(SVGDOMImplementation::SVG_NAMESPACE_URI, "svg", nil)
      @root = @doc.getDocumentElement
    end

    def append_elements(elements)
      elements.each do |element|
        @root.appendChild(element.to_batik_element(@doc))
      end
    end

    def to_s
      writer = StringWriter.new
      DOMUtilities.writeDocument(@doc, writer)
      writer.to_s
    end
  end
end
