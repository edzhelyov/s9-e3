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

        initElement.call(element);

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
    Selected = null;

    function initElement() {
        var element = $(this);

        element.data('init-color', element.attr('fill'));
//        element.hover(function() {
//                element.attr('fill', 'yellow');
//            }, function() {
//                element.attr('fill', element.data('init-color'));
//        });
        element.click(function() {
            if (Selected === null) Selected = $(this);
            else {
                connect(Selected, $(this));
            }
        });
    }

    function connect(from, to) {
        var o = from.find('.output'),
            i = to.find('.input:first'),
            line = $('<line />').attr({
                x1: o.attr('cx'),
                y1: o.attr('cy'),
                x2: i.attr('cx'),
                y2: i.attr('cy'),
                stroke: 'white',
                'stroke-width': '3'
            });
        console.log('o:', o);
        console.log('i:', i);

        $('#circuit').append(line);
    }
});

