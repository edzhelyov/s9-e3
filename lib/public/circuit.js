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

        var c = setCoordinates(ui.draggable, self),
            translate = 'translate(' + c.x + ',' + c.y + ')';
        element.attr('transform', translate);
        element.data('x', c.x);
        element.data('y', c.y);
        
        new Element(element);

        self.append(element);
        ui.draggable.remove();
    }

    $('#circuit').droppable().bind('drop', handleDrop);
    // End dropping elements into svg

    // Saving
    $('#save').submit(function() {
        var svg = $('#board').html(),
            hidden = $('<input />').attr({name: 'circuit', type: 'hidden', value: svg});
        $(this).append(hidden);
    });
    // End saving
});

