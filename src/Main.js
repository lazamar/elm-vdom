exports.repeat = function repeat(callback) {
    var number = 0;
    // throw new Error("Something happened!");

    return function() {
        // throw new Error("Something happened!");
        setTimeout(function() {
            callback(number++);
        }, 1000);
    };
};
