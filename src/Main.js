exports.toDOM = function(text) {
    return function() {
        document.body.appendChild(document.createTextNode(text));
        return 4;
    };
};
