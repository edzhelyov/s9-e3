# Integration Exercise: SVG Batik Wrapper

[Batik](http://xmlgraphics.apache.org/batik/index.html) is Java library for creating and manipulating SVG images. This is complete SVG tool chain, you can create SVG image from the same graphics that use Graphics2D class or by using the DOM interface as specified by w3c, which is the one used in the browsers. Additionally there are classes that convert to/from other formats and classes that implement render engine, so you can display svg in your program.

I'm wrapping it into simple interface that allow creation of SVG images using a ruby block construct. The Batik's DOM interface is used, which means you can use the official [w3c specification](http://www.w3.org/TR/SVG/) to define elements.

## Examples

You can define your svg images using a block construct:

    svg = Batik::SVG.new(width: 200, height: 200) do
      rectangle x: 10, y: 10, width: 180, height: 180, fill: 'cyan'
      circle cx: 10, cy: 20, r: 5, fill: 'black'
      circle cx: 10, cy: 170, r: 5, fill: 'black'
    end

and later add additional elements directly to the svg object:

    svg.text x: 40, y: 160, body: 'Signature at the bottom'

More examples can be found into the _examples/_ directory . You can run them with `jruby -I"lib" examples/example_name.rb` and svg file with the example name will be generated in the current directory.

## Currently supported

SVG elements that can be created include:

* Rectangle
* Circle
* Text
* Path
* Ellipse
* Polygon
* G(roup)

All of them support the standard attributes from the w3c specification. The Text element support additional attribute _body_ where you specify the actual text that will be displayed.

## Block syntax

Additional block syntax is available for all elements. Instead of specifying the attributes as hash you can do that in a block. The attributes are grouped into logical method and differ from the w3c specification names.

The example from above will become:

    svg = Batik::SVG.new(width: 200, height: 200) do
      rectangle do
        coordinates 10, 10
        dimensions 100, 180
        color :fill => 'cyan'
      end
      circle do
        coordinates 10, 20
        radius 5
        color :fill => 'black'
      end
      circle do
        coordinates 10, 170
        radius 5
        fill => 'black'
      end
    end

    svg.text do
      coordinates 40, 160
      body 'Signature at the bottom'
    end


Here is complete list of the methods that are available in the block:

* `coordinates(x, y)` - coordinate of the top-left point for rectangular objects or the center for circular
* `dimensions(width, height)` - the width and height of the object
* `color(options)` - current options are: `fill` and `stroke` 
* `translate(tx, ty = 0)` - translates the object to the given coordinates
* `scale(sx, sy = sx)` - scales the object's x and y axises
* `rotate(angle)` - rotates on given angle
* `radius(r)` - radius of circle
* `radius(rx, ry)` - radius of ellipse
* `link(href)` - image's link
* `body(text)` - actual text body

List of specific `path` commands:

* `move(x, y)`
* `line(x, y)`
* `horizontal_line(x)`
* `vertical_line(y)`
* `curve(x1, y1, x2, y2, x, y)`
* `smooth_curve(x2, y2, x, y)`
* `close`

## Setup

1. Use jruby, version 1.6
2. `export JRUBY_OPTS=--1.9`

If you want to run the specs

1. `gem install rspec` 
2. `rspec spec/`
