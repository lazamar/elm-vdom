/* eslint-disable no-use-before-define */

function F4(fn) {
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

function dispatchCmds(cmds) {
    var cmd = cmds;
    while (cmd.value0) {
        cmd.value0();
        cmd = cmd.value1();
    }
}

function program(scheduler, normalRenderer, initialModel, update, view) {
    // -- create renderer --

    return function() {
        var parentNode = document.createElement("div");
        document.body.appendChild(parentNode);

        var renderer = normalRenderer(parentNode, view);
        var updateView = renderer(enqueue, initialModel);
        // ---------------------
        var model = initialModel;

        function onMessage(msg) {
            var tup = update(msg)(model);
            model = tup.value0;
            var cmds = tup.value1;
            updateView(model);
            dispatchCmds(cmds);
        }

        var mainProcess = scheduler.spawn(onMessage);

        function enqueue(msg) {
            scheduler.send(mainProcess, msg);
        }
    };
}

exports.programImpl = F4(program);
