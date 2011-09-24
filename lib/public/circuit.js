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

        var absoluteCoordinator = {
            getX: function() {
                return $(this).data('x');
            },
            getY: function() {
                return $(this).data('y');
            }
        }

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
        jQuery.extend(element, absoluteCoordinator);

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
        element.dblclick(function() {
            if ($(this).parents('#circuit').length == 0) return;

            if (Selected === null) Selected = $(this);
            else {
                connect(Selected, $(this));
                Selected = null;
            }
        });
    }

    function connect(from, to) {
        var sum = function(a, b) {
            return parseInt(a) + parseInt(b);
        }

        var o = from.find('.output'),
            i = to.find('.input:first'),
            svg = $('#circuit'),
            x = sum(from.data('x'), o.attr('cx')),
            y = sum(from.data('y') , o.attr('cy')),
            x1 = sum(to.data('x') , i.attr('cx')),
            y1 = sum(to.data('y') , i.attr('cy'));

        svg.svg();
        svg = svg.svg('get');

        console.log('o:', o);
        console.log('i:', i);

        svg.line(x, y, x1, y1, {stroke: 'green'});
    }
});

