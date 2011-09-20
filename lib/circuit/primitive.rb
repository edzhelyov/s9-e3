module Circuit
  class Primitive
    def to_svg
      '<svg contentScriptType="text/ecmascript" width="40" xmlns:xlink="http://www.w3.org/1999/xlink" zoomAndPan="magnify" contentStyleType="text/css" height="40" preserveAspectRatio="xMidYMid meet" xmlns="http://www.w3.org/2000/svg" version="1.0"><g><rect fill="red" x="0" y="0" width="40" height="40" /><circle cx="5" cy="5" r="3" /></g></svg>'
    end
  end

  class GreePrimitive
    def to_svg
      '<svg contentScriptType="text/ecmascript" width="40" xmlns:xlink="http://www.w3.org/1999/xlink" zoomAndPan="magnify" contentStyleType="text/css" height="40" preserveAspectRatio="xMidYMid meet" xmlns="http://www.w3.org/2000/svg" version="1.0"><g><rect fill="green" x="0" y="0" width="40" height="40" /><circle cx="5" cy="5" r="3" /></g></svg>'
    end
  end
end
