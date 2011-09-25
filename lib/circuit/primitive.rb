module Circuit
  class Primitive
    attr_accessor :id, :type, :inputs, :output

    def initialize(options = {})
      @id = options['id']
      @type = options['type']
      @inputs = options['inputs']
      @output = options['output']
    end

    def to_svg
      %Q{<svg contentScriptType="text/ecmascript" width="40" xmlns:xlink="http://www.w3.org/1999/xlink" zoomAndPan="magnify" contentStyleType="text/css" height="40" preserveAspectRatio="xMidYMid meet" xmlns="http://www.w3.org/2000/svg" version="1.0"><g data-type="#{type}" font-size="8"><rect fill="red" x="0" y="0" width="40" height="40" /><circle class="input" cx="5" cy="5" r="3" /><circle class="input" cx="5" cy="35" r="3" /><circle class="output" cx="35" cy="20" r="3" /><text x="10" y="22">#{type}</text></g></svg>}
    end
  end
end
