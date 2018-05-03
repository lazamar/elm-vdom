exports.repeat = function repeat(callback) {
    var number = 0;
    throw new Error("Something happened!");

    return function() {
        throw new Error("Something happened!");
        setInterval(function() {
            callback(number++);
        }, 1000);
    };
};
