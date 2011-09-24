UID = 0;
nextUID = function() {
    return UID++;
}

Elements = [];
Selected = null;

sum = function(a, b) {
    return parseInt(a) + parseInt(b);
}

Locatable = {
    getX: function() {
        return parseInt(this.svg.data('x'));
    },
    getY: function() {
        return parseInt(this.svg.data('y'));
    },
    output: function() {
        if (this.outputConnected) throw 'Output already connected';
        var o = this.svg.find('.output'),
            x = sum(this.getX(), o.attr('cx')),
            y = sum(this.getY(), o.attr('cy'));

        return {'x': x, 'y': y};
    },
    connectOutput: function() {
        this.outputConnected = true;
    },
    nextInput: 0,
    freeInput: function() {
        var inputs = this.svg.find('.input');

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

Element = function(svg_element) {
    var self = this;
    this.svg = svg_element;
    this.type = svg_element.data('type');

    if (this.svg.data('id') === undefined) this.svg.attr('data-id', nextUID());
    this.id = this.svg.data('id');

    svg_element.dblclick(function() {
        if (Selected === null) Selected = self;
        else {
            connect(Selected, self);
            Selected = null;
        }
    });

    jQuery.extend(self, Locatable);

    Elements.push(self);
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
