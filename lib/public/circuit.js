$(function() {
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

    handleDrop = function(event, ui) {
        var element = ui.draggable.find('g');
            self = $(this);

        initElement.call(element.find('rect'));

        function setCoordinates(e, c) {
            var cp = c.position(),
                ep = e.position();

            var x = ep.left - cp.left,
                y = ep.top - cp.top;

            return 'translate(' + x + ',' + y + ')';
        }

        var translate = setCoordinates(ui.draggable, self);
        element.attr('transform', translate);

        self.append(element);
        ui.draggable.remove();
    }

    b = $('#circuit').droppable().bind('drop', handleDrop);

    $('#save').submit(function() {
        var svg = $('#board').html(),
            hidden = $('<input />').attr({name: 'circuit', type: 'hidden', value: svg});
        $(this).append(hidden);
    });

    // Primitives
    function initPrimitive() {
        $(this).draggable(options).bind('dragstart', cloning);
    }
    $('.primitive svg').each(initPrimitive);

    // Element
    function initElement() {
        var element = $(this);

        element.data('init-color', element.attr('fill'));
        element.hover(function() {
                element.attr('fill', 'yellow');
            }, function() {
                element.attr('fill', element.data('init-color'));
        });
    }
});

