/* eslint-disable no-use-before-define */

function F5(fn) {
    return function(a) {
        return function(b) {
            return function(c) {
                return function(d) {
                    return function(e) {
                        return fn(a, b, c, d, e);
                    };
                };
            };
        };
    };
}

function dispatchCmds(cmds, enqueue) {
    var i;
    var length = cmds.length;
    for (i = 0; i < length; i++) {
        cmds[i](enqueue)();
    }
}

function program(scheduler, normalRenderer, init, update, view) {
    // -- create renderer --

    return function() {
        var parentNode = document.createElement("div");
        document.body.appendChild(parentNode);

        var initialModel = init.value0;
        var initialCmds = init.value1;

        var renderer = normalRenderer(parentNode, view);
        var updateView = renderer(enqueue, initialModel);
        // ---------------------
        var model = initialModel;

        function onMessage(msg) {
            var tup = update(msg)(model);
            model = tup.value0;
            var cmds = tup.value1;
            updateView(model);
            dispatchCmds(cmds, enqueue);
        }

        var mainProcess = scheduler.spawn(onMessage);
        dispatchCmds(initialCmds, enqueue);

        function enqueue(msg) {
            scheduler.send(mainProcess, msg);
            return function() {};
        }
    };
}

exports.program = F5(program);
