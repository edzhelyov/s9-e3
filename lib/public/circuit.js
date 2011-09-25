$(function() {
    // Primitives and moving
    options = {
        distance: 30,
        containment: $('#board')
    }

    cloning = function(event, ui) {
        var self = $(this),
            clone = self.clone();

        initPrimitive.call(clone);

        self.unbind('dragstart');
        self.parent().append(clone);
    }

    function initPrimitive() {
        $(this).draggable(options).bind('dragstart', cloning);
    }

    $('.primitive svg').each(initPrimitive);
    // End primitives and moving

    // Droping elements into svg
    // When element is dropped it should behave like Element that has
    // all needed information like inputs, outputs, connections, known
    // coordinates, etc.
    handleDrop = function(event, ui) {
        var element = ui.draggable.find('g');
            self = $(this);

        function setCoordinates(e, c) {
            var cp = c.position(),
                ep = e.position();

            var x = ep.left - cp.left,
                y = ep.top - cp.top;

            return { 'x': x, 'y': y }
        }

        var c = setCoordinates(ui.draggable, self);

        jQuery.ajax({
            url: '/add_element',
            data: {type: element.attr('data-type'), x: c.x, y: c.y},
            success: function(data) {
                $('#board').html(data);
                initialize();
            }
        });

        ui.draggable.remove();
    }

    function initialize() {
        $('#circuit').droppable().bind('drop', handleDrop);
    }
    initialize();
    // End dropping elements into svg

    // Saving
    $('#save').submit(function() {
        var svg = $('#board').html(),
            circuit = $('<input />').attr({name: 'circuit', type: 'hidden', value: svg}),
            elements = $('<input />').attr({name: 'elements', type: 'hidden', value: Elements.serialize()});
            
        $(this).append(circuit);
        $(this).append(elements);
    });
    // End saving
});

