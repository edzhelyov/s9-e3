# Academic Exercise: Digital Logic Simulator

# Usage

This run on JRuby with 1.9 compatability `export JRUBY_OPTS=--1.9`.
Install the dependencies with `bundle install`.
Run the `./bin/circuit` executable, this will start a WEBrick server with sinatra app at 4567 port.

# Interface
You have two panels: one at left that where the actual circuit is drawn and one at right when primitives elements are listed.
Each primitive has inputs which are represented as little circles on the left side and output which is the little circle on the right.
If you click on the inputs they will toggle their state, as black is for 'off' and yellow for 'on'.

You can connect elements by clicking on the output circle of the source element and clicking on the appropriate input circle of the destination element. Then you can toggle the source of different elements for see how the whole circuit reacts to the changes.
