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

exports.f2 = F2;
exports.f3 = F3;
exports.f4 = F4;
exports.f5 = F5;
exports.f6 = F6;
exports.f7 = F7;
exports.f8 = F8;
exports.f9 = F9;
exports.a2 = A2;
exports.a3 = A3;
exports.a4 = A4;
exports.a5 = A5;
exports.a6 = A6;
exports.a7 = A7;
exports.a8 = A8;
exports.a9 = A9;
