exports.repeat = function repeat(callback) {
    var number = 0;
    return function() {
        setInterval(function() {
            callback(number++);
        }, 1000);
    };
};
