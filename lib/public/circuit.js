$(function() {
    options = {
        distance: 30
    }

    cloning = function(event, ui) {
        $(this).unbind('dragstart');
        $(this).parent().append($(this).clone().draggable(options).bind('dragstart', cloning));
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

    $('.primitive svg').draggable(options).bind('dragstart', cloning);
    b = $('#circuit').droppable().bind('drop', handleDrop);
});

