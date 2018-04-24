//import Maybe, Native.Array, Native.List, Native.Utils, Result //

function F(arity, fun, wrapper) {
    wrapper.a = arity;
    wrapper.f = fun;
    return wrapper;
}

function F2(fun) {
    return F(2, fun, function(a) {
        return function(b) {
            return fun(a, b);
        };
    });
}
function F3(fun) {
    return F(3, fun, function(a) {
        return function(b) {
            return function(c) {
                return fun(a, b, c);
            };
        };
    });
}
function F4(fun) {
    return F(4, fun, function(a) {
        return function(b) {
            return function(c) {
                return function(d) {
                    return fun(a, b, c, d);
                };
            };
        };
    });
}
function F5(fun) {
    return F(5, fun, function(a) {
        return function(b) {
            return function(c) {
                return function(d) {
                    return function(e) {
                        return fun(a, b, c, d, e);
                    };
                };
            };
        };
    });
}
function F6(fun) {
    return F(6, fun, function(a) {
        return function(b) {
            return function(c) {
                return function(d) {
                    return function(e) {
                        return function(f) {
                            return fun(a, b, c, d, e, f);
                        };
                    };
                };
            };
        };
    });
}
function F7(fun) {
    return F(7, fun, function(a) {
        return function(b) {
            return function(c) {
                return function(d) {
                    return function(e) {
                        return function(f) {
                            return function(g) {
                                return fun(a, b, c, d, e, f, g);
                            };
                        };
                    };
                };
            };
        };
    });
}
function F8(fun) {
    return F(8, fun, function(a) {
        return function(b) {
            return function(c) {
                return function(d) {
                    return function(e) {
                        return function(f) {
                            return function(g) {
                                return function(h) {
                                    return fun(a, b, c, d, e, f, g, h);
                                };
                            };
                        };
                    };
                };
            };
        };
    });
}
function F9(fun) {
    return F(9, fun, function(a) {
        return function(b) {
            return function(c) {
                return function(d) {
                    return function(e) {
                        return function(f) {
                            return function(g) {
                                return function(h) {
                                    return function(i) {
                                        return fun(a, b, c, d, e, f, g, h, i);
                                    };
                                };
                            };
                        };
                    };
                };
            };
        };
    });
}

function A2(fun, a, b) {
    return fun.a === 2 ? fun.f(a, b) : fun(a)(b);
}
function A3(fun, a, b, c) {
    return fun.a === 3 ? fun.f(a, b, c) : fun(a)(b)(c);
}
function A4(fun, a, b, c, d) {
    return fun.a === 4 ? fun.f(a, b, c, d) : fun(a)(b)(c)(d);
}
function A5(fun, a, b, c, d, e) {
    return fun.a === 5 ? fun.f(a, b, c, d, e) : fun(a)(b)(c)(d)(e);
}
function A6(fun, a, b, c, d, e, f) {
    return fun.a === 6 ? fun.f(a, b, c, d, e, f) : fun(a)(b)(c)(d)(e)(f);
}
function A7(fun, a, b, c, d, e, f, g) {
    return fun.a === 7 ? fun.f(a, b, c, d, e, f, g) : fun(a)(b)(c)(d)(e)(f)(g);
}
function A8(fun, a, b, c, d, e, f, g, h) {
    return fun.a === 8 ? fun.f(a, b, c, d, e, f, g, h) : fun(a)(b)(c)(d)(e)(f)(g)(h);
}
function A9(fun, a, b, c, d, e, f, g, h, i) {
    return fun.a === 9 ? fun.f(a, b, c, d, e, f, g, h, i) : fun(a)(b)(c)(d)(e)(f)(g)(h)(i);
}

window._elm_lang$core$Native_Core = {
    F2: F2,
    F3: F3,
    F4: F4,
    F5: F5,
    F6: F6,
    F7: F7,
    F8: F8,
    F9: F9,
    A2: A2,
    A3: A3,
    A4: A4,
    A5: A5,
    A6: A6,
    A7: A7,
    A8: A8,
    A9: A9
};

window._elm_lang$core$Native_Json = (function() {
    // CORE DECODERS

    function succeed(msg) {
        return {
            ctor: "<decoder>",
            tag: "succeed",
            msg: msg
        };
    }

    function fail(msg) {
        return {
            ctor: "<decoder>",
            tag: "fail",
            msg: msg
        };
    }

    function decodePrimitive(tag) {
        return {
            ctor: "<decoder>",
            tag: tag
        };
    }

    function decodeContainer(tag, decoder) {
        return {
            ctor: "<decoder>",
            tag: tag,
            decoder: decoder
        };
    }

    function decodeNull(value) {
        return {
            ctor: "<decoder>",
            tag: "null",
            value: value
        };
    }

    function decodeField(field, decoder) {
        return {
            ctor: "<decoder>",
            tag: "field",
            field: field,
            decoder: decoder
        };
    }

    function decodeIndex(index, decoder) {
        return {
            ctor: "<decoder>",
            tag: "index",
            index: index,
            decoder: decoder
        };
    }

    function decodeKeyValuePairs(decoder) {
        return {
            ctor: "<decoder>",
            tag: "key-value",
            decoder: decoder
        };
    }

    function mapMany(f, decoders) {
        return {
            ctor: "<decoder>",
            tag: "map-many",
            func: f,
            decoders: decoders
        };
    }

    function andThen(callback, decoder) {
        return {
            ctor: "<decoder>",
            tag: "andThen",
            decoder: decoder,
            callback: callback
        };
    }

    function oneOf(decoders) {
        return {
            ctor: "<decoder>",
            tag: "oneOf",
            decoders: decoders
        };
    }

    // DECODING OBJECTS

    function map1(f, d1) {
        return mapMany(f, [d1]);
    }

    function map2(f, d1, d2) {
        return mapMany(f, [d1, d2]);
    }

    function map3(f, d1, d2, d3) {
        return mapMany(f, [d1, d2, d3]);
    }

    function map4(f, d1, d2, d3, d4) {
        return mapMany(f, [d1, d2, d3, d4]);
    }

    function map5(f, d1, d2, d3, d4, d5) {
        return mapMany(f, [d1, d2, d3, d4, d5]);
    }

    function map6(f, d1, d2, d3, d4, d5, d6) {
        return mapMany(f, [d1, d2, d3, d4, d5, d6]);
    }

    function map7(f, d1, d2, d3, d4, d5, d6, d7) {
        return mapMany(f, [d1, d2, d3, d4, d5, d6, d7]);
    }

    function map8(f, d1, d2, d3, d4, d5, d6, d7, d8) {
        return mapMany(f, [d1, d2, d3, d4, d5, d6, d7, d8]);
    }

    // DECODE HELPERS

    function ok(value) {
        return { tag: "ok", value: value };
    }

    function badPrimitive(type, value) {
        return { tag: "primitive", type: type, value: value };
    }

    function badIndex(index, nestedProblems) {
        return { tag: "index", index: index, rest: nestedProblems };
    }

    function badField(field, nestedProblems) {
        return { tag: "field", field: field, rest: nestedProblems };
    }

    function badIndex(index, nestedProblems) {
        return { tag: "index", index: index, rest: nestedProblems };
    }

    function badOneOf(problems) {
        return { tag: "oneOf", problems: problems };
    }

    function bad(msg) {
        return { tag: "fail", msg: msg };
    }

    function badToString(problem) {
        var context = "_";
        while (problem) {
            switch (problem.tag) {
                case "primitive":
                    return (
                        "Expecting " +
                        problem.type +
                        (context === "_" ? "" : " at " + context) +
                        " but instead got: " +
                        jsToString(problem.value)
                    );

                case "index":
                    context += "[" + problem.index + "]";
                    problem = problem.rest;
                    break;

                case "field":
                    context += "." + problem.field;
                    problem = problem.rest;
                    break;

                case "index":
                    context += "[" + problem.index + "]";
                    problem = problem.rest;
                    break;

                case "oneOf":
                    var problems = problem.problems;
                    for (var i = 0; i < problems.length; i++) {
                        problems[i] = badToString(problems[i]);
                    }
                    return (
                        "I ran into the following problems" +
                        (context === "_" ? "" : " at " + context) +
                        ":\n\n" +
                        problems.join("\n")
                    );

                case "fail":
                    return (
                        "I ran into a `fail` decoder" +
                        (context === "_" ? "" : " at " + context) +
                        ": " +
                        problem.msg
                    );
            }
        }
    }

    function jsToString(value) {
        return value === undefined ? "undefined" : JSON.stringify(value);
    }

    // DECODE

    function runOnString(decoder, string) {
        var json;
        try {
            json = JSON.parse(string);
        } catch (e) {
            return _elm_lang$core$Result$Err("Given an invalid JSON: " + e.message);
        }
        return run(decoder, json);
    }

    function _elm_lang$core$Result$Err(a) {
        return { ctor: "Err", _0: a };
    }

    function _elm_lang$core$Result$Ok(a) {
        return { ctor: "Ok", _0: a };
    }

    function run(decoder, value) {
        var result = runHelp(decoder, value);
        return result.tag === "ok"
            ? _elm_lang$core$Result$Ok(result.value)
            : _elm_lang$core$Result$Err(badToString(result));
    }

    function runHelp(decoder, value) {
        switch (decoder.tag) {
            case "bool":
                return typeof value === "boolean" ? ok(value) : badPrimitive("a Bool", value);

            case "int":
                if (typeof value !== "number") {
                    return badPrimitive("an Int", value);
                }

                if (-2147483647 < value && value < 2147483647 && (value | 0) === value) {
                    return ok(value);
                }

                if (isFinite(value) && !(value % 1)) {
                    return ok(value);
                }

                return badPrimitive("an Int", value);

            case "float":
                return typeof value === "number" ? ok(value) : badPrimitive("a Float", value);

            case "string":
                return typeof value === "string"
                    ? ok(value)
                    : value instanceof String ? ok(value + "") : badPrimitive("a String", value);

            case "null":
                return value === null ? ok(decoder.value) : badPrimitive("null", value);

            case "value":
                return ok(value);

            case "list":
                if (!(value instanceof Array)) {
                    return badPrimitive("a List", value);
                }

                var list = _elm_lang$core$Native_List.Nil;
                for (var i = value.length; i--; ) {
                    var result = runHelp(decoder.decoder, value[i]);
                    if (result.tag !== "ok") {
                        return badIndex(i, result);
                    }
                    list = _elm_lang$core$Native_List.Cons(result.value, list);
                }
                return ok(list);

            case "array":
                if (!(value instanceof Array)) {
                    return badPrimitive("an Array", value);
                }

                var len = value.length;
                var array = new Array(len);
                for (var i = len; i--; ) {
                    var result = runHelp(decoder.decoder, value[i]);
                    if (result.tag !== "ok") {
                        return badIndex(i, result);
                    }
                    array[i] = result.value;
                }
                return ok(_elm_lang$core$Native_Array.fromJSArray(array));

            case "maybe":
                var result = runHelp(decoder.decoder, value);
                return result.tag === "ok"
                    ? ok(_elm_lang$core$Maybe$Just(result.value))
                    : ok(_elm_lang$core$Maybe$Nothing);

            case "field":
                var field = decoder.field;
                if (typeof value !== "object" || value === null || !(field in value)) {
                    return badPrimitive("an object with a field named `" + field + "`", value);
                }

                var result = runHelp(decoder.decoder, value[field]);
                return result.tag === "ok" ? result : badField(field, result);

            case "index":
                var index = decoder.index;
                if (!(value instanceof Array)) {
                    return badPrimitive("an array", value);
                }
                if (index >= value.length) {
                    return badPrimitive(
                        "a longer array. Need index " +
                            index +
                            " but there are only " +
                            value.length +
                            " entries",
                        value
                    );
                }

                var result = runHelp(decoder.decoder, value[index]);
                return result.tag === "ok" ? result : badIndex(index, result);

            case "key-value":
                if (typeof value !== "object" || value === null || value instanceof Array) {
                    return badPrimitive("an object", value);
                }

                var keyValuePairs = _elm_lang$core$Native_List.Nil;
                for (var key in value) {
                    var result = runHelp(decoder.decoder, value[key]);
                    if (result.tag !== "ok") {
                        return badField(key, result);
                    }
                    var pair = _elm_lang$core$Native_Utils.Tuple2(key, result.value);
                    keyValuePairs = _elm_lang$core$Native_List.Cons(pair, keyValuePairs);
                }
                return ok(keyValuePairs);

            case "map-many":
                var answer = decoder.func;
                var decoders = decoder.decoders;
                for (var i = 0; i < decoders.length; i++) {
                    var result = runHelp(decoders[i], value);
                    if (result.tag !== "ok") {
                        return result;
                    }
                    answer = answer(result.value);
                }
                return ok(answer);

            case "andThen":
                var result = runHelp(decoder.decoder, value);
                return result.tag !== "ok"
                    ? result
                    : runHelp(decoder.callback(result.value), value);

            case "oneOf":
                var errors = [];
                var temp = decoder.decoders;
                while (temp.ctor !== "[]") {
                    var result = runHelp(temp._0, value);

                    if (result.tag === "ok") {
                        return result;
                    }

                    errors.push(result);

                    temp = temp._1;
                }
                return badOneOf(errors);

            case "fail":
                return bad(decoder.msg);

            case "succeed":
                return ok(decoder.msg);
        }
    }

    // EQUALITY

    function equality(a, b) {
        if (a === b) {
            return true;
        }

        if (a.tag !== b.tag) {
            return false;
        }

        switch (a.tag) {
            case "succeed":
            case "fail":
                return a.msg === b.msg;

            case "bool":
            case "int":
            case "float":
            case "string":
            case "value":
                return true;

            case "null":
                return a.value === b.value;

            case "list":
            case "array":
            case "maybe":
            case "key-value":
                return equality(a.decoder, b.decoder);

            case "field":
                return a.field === b.field && equality(a.decoder, b.decoder);

            case "index":
                return a.index === b.index && equality(a.decoder, b.decoder);

            case "map-many":
                if (a.func !== b.func) {
                    return false;
                }
                return listEquality(a.decoders, b.decoders);

            case "andThen":
                return a.callback === b.callback && equality(a.decoder, b.decoder);

            case "oneOf":
                return listEquality(a.decoders, b.decoders);
        }
    }

    function listEquality(aDecoders, bDecoders) {
        var len = aDecoders.length;
        if (len !== bDecoders.length) {
            return false;
        }
        for (var i = 0; i < len; i++) {
            if (!equality(aDecoders[i], bDecoders[i])) {
                return false;
            }
        }
        return true;
    }

    // ENCODE

    function encode(indentLevel, value) {
        return JSON.stringify(value, null, indentLevel);
    }

    function identity(value) {
        return value;
    }

    function encodeObject(keyValuePairs) {
        var obj = {};
        while (keyValuePairs.ctor !== "[]") {
            var pair = keyValuePairs._0;
            obj[pair._0] = pair._1;
            keyValuePairs = keyValuePairs._1;
        }
        return obj;
    }

    return {
        encode: F2(encode),
        runOnString: F2(runOnString),
        run: F2(run),

        decodeNull: decodeNull,
        decodePrimitive: decodePrimitive,
        decodeContainer: F2(decodeContainer),

        decodeField: F2(decodeField),
        decodeIndex: F2(decodeIndex),

        map1: F2(map1),
        map2: F3(map2),
        map3: F4(map3),
        map4: F5(map4),
        map5: F6(map5),
        map6: F7(map6),
        map7: F8(map7),
        map8: F9(map8),
        decodeKeyValuePairs: decodeKeyValuePairs,

        andThen: F2(andThen),
        fail: fail,
        succeed: succeed,
        oneOf: oneOf,

        identity: identity,
        encodeNull: null,
        // encodeArray: _elm_lang$core$Native_Array.toJSArray,
        // encodeList: _elm_lang$core$Native_List.toArray,
        encodeObject: encodeObject,

        equality: equality
    };
})();

var json = window._elm_lang$core$Native_Json;

exports.encode = json.encode;
exports.runOnString = json.runOnString;
exports.run = json.run;

exports.decodeNull = json.decodeNull;
exports.decodePrimitive = json.decodePrimitive;
exports.decodeContainer = json.decodeContainer;

exports.decodeField = json.decodeField;
exports.decodeIndex = json.decodeIndex;

exports.map1 = json.map1;
exports.map2 = json.map2;
exports.map3 = json.map3;
exports.map4 = json.map4;
exports.map5 = json.map5;
exports.map6 = json.map6;
exports.map7 = json.map7;
exports.map8 = json.map8;
exports.decodeKeyValuePairs = json.decodeKeyValuePairs;

exports.andThen = json.andThen;
exports.fail = json.fail;
exports.succeed = json.succeed;
exports.oneOf = json.oneOf;

exports.identity = json.identity;
exports.encodeNull = json.encodeNull;
exports.encodeArray = json.encodeArray;
exports.encodeList = json.encodeList;
exports.encodeObject = json.encodeObject;

exports.equality = json.equality;
