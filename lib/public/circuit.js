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
        initElement.call(element);

        self.append(element);
        ui.draggable.remove();
    }

    $('#circuit').droppable().bind('drop', handleDrop);
    // End dropping elements into svg



    // Element
    Elements = [];
    Selected = null;

    sum = function(a, b) {
        return parseInt(a) + parseInt(b);
    }

    Locatable = {
        getX: function() {
            return parseInt(this.data('x'));
        },
        getY: function() {
            return parseInt(this.data('y'));
        },
        nextInput: 0,
        freeInput: function() {
            var inputs = this.find('.input');

            if (this.nextInput >= inputs.length) throw 'Segmentation overflow inputs';
            
            var i = $(inputs[this.nextInput]),
                x = sum(this.getX(), i.attr('cx')),
                y = sum(this.getY(), i.attr('cy'));

            return {'x': x, 'y': y};
        },
        connectInput: function() {
            this.nextInput++;
        }
    }

    Connectable = {
        connected: false,
        connectedTo: null,
        isConnected: function() {
            return this.connected;
        },
        getX: function() {
            return parseInt(this.attr('cx')) + this.parent('g').getX();
        }
    }


    function initElement() {
        var element = $(this);

        element.data('init-color', element.attr('fill'));
//        element.hover(function() {
//                element.attr('fill', 'yellow');
//            }, function() {
//                element.attr('fill', element.data('init-color'));
//        });
        element.dblclick(function() {
            if (Selected === null) Selected = element;
            else {
                connect(Selected, element);
                Selected = null;
            }
        });
        jQuery.extend(element, Locatable);

        Elements.push(element);
    }

    function connect(from, to) {

        var o = from.find('.output'),
            i = to.find('.input:first'),
            svg = $('#circuit'),
            x = sum(from.getX(), o.attr('cx')),
            y = sum(from.getY(), o.attr('cy')),
            x1 = sum(to.getX(), i.attr('cx')),
            y1 = sum(to.getY(), i.attr('cy'));

        svg.svg();
        svg = svg.svg('get');

        console.log('o:', o);
        console.log('i:', i);

        svg.line(x, y, x1, y1, {stroke: 'green'});
    }

    // Saving
    $('#save').submit(function() {
        var svg = $('#board').html(),
            hidden = $('<input />').attr({name: 'circuit', type: 'hidden', value: svg});
        $(this).append(hidden);
    });
    // End saving
});

