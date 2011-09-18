# Academic Exercise: Digital Logic Simulator

1. Web interface with two panels:
  * Left panel where the actual circuit with wires is displayed
  * Right panel with all available gates/switches
  
  User can drag and drop elements and connect them by pointing from source
  element to destination element.

  The circuit could be saved and then re used as available gate.

  * Maybe I should allow only gate elements and handle the switch statements
    in other view. You could assign on/off value to the left most input places
    of gate ?

2. Backed that compose the connection graph for the elements
3. SVG representation - try to use Batik if possible

# TODO

1. Freeze circle into right panel
2. Drag the copy of the cirle and drop it into the left panel
3. Save the state of the left panel

4. Allow connection between circles in the left panel
5. Save the state of the circle and their connection into graph object
6. Reload the actual state

7. Add input/output areas on the circle
8. Handle connecting the output with input
9. Create a chain of circles A -> B -> C -> D
10. Save this chain into graph

11. Handle on/off input simulation
12. Add two inputs to circle
13. Add execution logic
