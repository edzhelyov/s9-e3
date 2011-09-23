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
        var self = $(this);

        self.data('init-color', self.find('rect').attr('fill'));

        self.draggable(options).bind('dragstart', cloning);
        self.find('rect').hover(function() {
                $(this).attr('fill', 'yellow');
            }, function() {
                $(this).attr('fill', self.data('init-color'));
        });
    }
    $('.primitive svg').each(initPrimitive);

    // Circuit
});

