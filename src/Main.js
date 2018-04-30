exports.repeat = function repeat(callback) {
    var number = 0;
    return function() {
        setInterval(function() {
            console.log("Calling again");
            callback(number++);
        }, 1000);
    };
};
