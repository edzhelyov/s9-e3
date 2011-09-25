UID = 0;
nextUID = function() {
    return UID++;
}

Elements = jQuery.extend([], {
    serialize: function() {
        var json = [];

        jQuery.each(this, function(idx, item) {
            json.push({
                id: item.id,
                type: item.type,
                inputs: item.connections.inputs,
                output: item.connections.output
            });
        });

        return JSON.stringify(json);
    }
});
Selected = null;

sum = function(a, b) {
    return parseInt(a) + parseInt(b);
}

drawLine = function(from, to) {
    var svg = $('#circuit');

    svg.svg();
    svg = svg.svg('get');

    svg.line(from.x, from.y, to.x, to.y, {stroke: 'blue'});
}

Locatable = {
    getX: function() {
        return parseInt(this.svg.data('x'));
    },
    getY: function() {
        return parseInt(this.svg.data('y'));
    },
    connectTo: function(to) {
        if (this.outputConnected) {
            alert('Output already connected');
            return;
        }

        if (to.alreadyConnected()) {
            alert('All inputs are connected');
            return;
        }

        this.connections.output.push(to.id);
        to.connections.inputs.push(this.id);

        drawLine(this.output(), to.freeInput());
    },
    output: function() {
        var o = this.svg.find('.output'),
            x = sum(this.getX(), o.attr('cx')),
            y = sum(this.getY(), o.attr('cy'));

        this.outputConnected = true;
        return {'x': x, 'y': y};
    },
    nextInput: 0,
    alreadyConnected: function() {
        var inputs = this.svg.find('.input');

        return this.nextInput >= inputs.length;
    },
    freeInput: function() {
        var inputs = this.svg.find('.input'),
            i = $(inputs[this.nextInput]),
            x = sum(this.getX(), i.attr('cx')),
            y = sum(this.getY(), i.attr('cy'));

        this.nextInput++;
        return {'x': x, 'y': y};
    }
}

Element = function(svg_element) {
    var self = this;
    this.svg = svg_element;
    this.type = svg_element.data('type');
    this.connections = {
        inputs: [],
        output: []
    }

    if (this.svg.data('id') === undefined) this.svg.attr('data-id', nextUID());
    this.id = this.svg.data('id');

    svg_element.dblclick(function() {
        if (Selected === null) Selected = self;
        else {
            Selected.connectTo(self);
            Selected = null;
        }
    });
    svg_element.find('.input').click(function() {
        var s = $(this).attr('data-source');

        if (s == '1') {
            $(this).attr({fill: 'black', 'data-source': '0'});
        } else {
            $(this).attr({fill: 'yellow', 'data-source': '1'});
        }
    });

    jQuery.extend(self, Locatable);

    Elements.push(self);
}
