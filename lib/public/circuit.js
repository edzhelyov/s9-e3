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
        output: function() {
            if (this.outputConnected) throw 'Output already connected';
            var o = this.find('.output'),
                x = sum(this.getX(), o.attr('cx')),
                y = sum(this.getY(), o.attr('cy'));

            return {'x': x, 'y': y};
        },
        connectOutput: function() {
            this.outputConnected = true;
        },
        nextInput: 0,
        freeInput: function() {
            var inputs = this.find('.input');

            if (this.nextInput >= inputs.length) throw 'All inputs already connected';
            
            var i = $(inputs[this.nextInput]),
                x = sum(this.getX(), i.attr('cx')),
                y = sum(this.getY(), i.attr('cy'));

            return {'x': x, 'y': y};
        },
        connectInput: function() {
            this.nextInput++;
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

        try {
            var o = from.output(),
                i = to.freeInput();
        } catch(e) {
            alert("Can't connect these elements");
            return;
        }
        var svg = $('#circuit');

        svg.svg();
        svg = svg.svg('get');

        svg.line(o.x, o.y, i.x, i.y, {stroke: 'green'});
        to.connectInput();
        from.connectOutput();
    }

    // Saving
    $('#save').submit(function() {
        var svg = $('#board').html(),
            hidden = $('<input />').attr({name: 'circuit', type: 'hidden', value: svg});
        $(this).append(hidden);
    });
    // End saving
});

