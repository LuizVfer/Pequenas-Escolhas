#region Desenhar poeira

var _proporcao =
    clamp(
        vida / vida_total,
        0,
        1
    );


var _alpha =
    alpha_maximo
    * sqr(_proporcao);


var _x =
    round(x);


var _y =
    round(y);


draw_set_color(cor);
draw_set_alpha(_alpha);


// Partícula principal
draw_rectangle(
    _x,
    _y,
    _x + tamanho,
    _y + 2,
    false
);


// Pequeno grão separado
draw_set_alpha(
    _alpha * 0.70
);


draw_rectangle(
    _x - 3,
    _y + 1,
    _x - 1,
    _y + 2,
    false
);


draw_set_alpha(1);
draw_set_color(c_white);

#endregion