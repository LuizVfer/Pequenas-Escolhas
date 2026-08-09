if (
    !minigame_ativo
    || (
        estado_puzzle_roda
            != ESTADO_MINIGAME_RODA

        && estado_puzzle_roda
            != ESTADO_MINIGAME_MARTELO
    )
)
{
    exit;
}


#region Dados da interface

var _modo_martelo =
    estado_puzzle_roda
        == ESTADO_MINIGAME_MARTELO;

var _titulo =
    _modo_martelo
        ? "Fixar a roda"
        : "Empurrar a roda";

var _progresso =
    _modo_martelo
        ? marteladas_corretas
        : impulso_atual;

var _total =
    _modo_martelo
        ? quantidade_marteladas
        : quantidade_impulsos;


var _painel_x1 = 160;
var _painel_y1 = 246;
var _painel_x2 = 480;
var _painel_y2 = 338;

var _centro_x =
    (_painel_x1 + _painel_x2) * 0.5;

var _barra_x1 = 210;
var _barra_y1 = 288;
var _barra_x2 = 430;
var _barra_y2 = 298;

var _largura_barra =
    _barra_x2 - _barra_x1;

var _pulso =
    (sin(anim_minigame_roda) + 1) * 0.5;


var _cor_fundo =
    make_color_rgb(39, 33, 30);

var _cor_borda =
    make_color_rgb(78, 78, 78);

var _cor_detalhe =
    make_color_rgb(163, 151, 113);

var _cor_texto =
    make_color_rgb(214, 196, 173);

var _cor_texto_secundario =
    make_color_rgb(154, 164, 167);

var _cor_erro =
    make_color_rgb(173, 78, 61);

#endregion


#region Painel

draw_set_alpha(0.25);
draw_set_color(c_black);

draw_rectangle(
    _painel_x1 + 3,
    _painel_y1 + 3,
    _painel_x2 + 3,
    _painel_y2 + 3,
    false
);


draw_set_alpha(0.95);
draw_set_color(_cor_fundo);

draw_rectangle(
    _painel_x1,
    _painel_y1,
    _painel_x2,
    _painel_y2,
    false
);


draw_set_alpha(1);
draw_set_color(_cor_borda);

draw_rectangle(
    _painel_x1,
    _painel_y1,
    _painel_x2,
    _painel_y2,
    true
);


draw_set_color(_cor_detalhe);

draw_rectangle(
    _painel_x1 + 24,
    _painel_y1,
    _painel_x2 - 24,
    _painel_y1 + 1,
    false
);

#endregion


#region Título e progresso

draw_set_font(fnt_minigame);
draw_set_valign(fa_middle);

draw_set_halign(fa_left);
draw_set_color(_cor_texto);

draw_text(
    _painel_x1 + 14,
    258,
    _titulo
);


var _espaco_circulos = 14;

var _inicio_circulos =
    _painel_x2
    - 18
    - (_total - 1)
    * _espaco_circulos;


for (
    var _i = 0;
    _i < _total;
    _i++
)
{
    var _circulo_x =
        _inicio_circulos
        + _i * _espaco_circulos;


    if (_i < _progresso)
    {
        draw_set_color(
            make_color_rgb(218, 183, 83)
        );
    }
    else
    {
        draw_set_color(
            make_color_rgb(63, 64, 62)
        );
    }


    draw_circle(
        _circulo_x,
        258,
        4,
        false
    );


    draw_set_color(
        make_color_rgb(89, 69, 56)
    );

    draw_circle(
        _circulo_x,
        258,
        4,
        true
    );
}

#endregion


#region Mensagem

draw_set_halign(fa_center);

if (feedback_erro > 0)
{
    draw_set_color(_cor_erro);

    draw_text(
        _centro_x,
        272,
        _modo_martelo
            ? "Sequência reiniciada"
            : "Tente novamente"
    );
}
else
{
    draw_set_color(_cor_texto_secundario);

    draw_text(
        _centro_x,
        274,
        _modo_martelo
        ? "Acerte a faixa"
        : "Segure E e solte na faixa"
    );
}

#endregion


#region Barra

draw_set_color(
    make_color_rgb(23, 22, 22)
);

draw_rectangle(
    _barra_x1,
    _barra_y1,
    _barra_x2,
    _barra_y2,
    false
);


draw_set_color(
    make_color_rgb(48, 46, 46)
);

draw_rectangle(
    _barra_x1 + 2,
    _barra_y1 + 2,
    _barra_x2 - 2,
    _barra_y2 - 2,
    false
);


var _zona_inicio =
    zona_centro
    - zona_largura * 0.5;

var _zona_fim =
    zona_centro
    + zona_largura * 0.5;

var _zona_x1 =
    _barra_x1
    + _largura_barra
    * _zona_inicio;

var _zona_x2 =
    _barra_x1
    + _largura_barra
    * _zona_fim;


// Brilho da área correta
draw_set_alpha(
    0.14 + _pulso * 0.08
);

draw_set_color(
    make_color_rgb(218, 183, 83)
);

draw_rectangle(
    _zona_x1 - 1,
    _barra_y1 - 1,
    _zona_x2 + 1,
    _barra_y2 + 1,
    false
);


// Faixa correta
draw_set_alpha(1);

draw_set_color(
    make_color_rgb(163, 151, 113)
);

draw_rectangle(
    _zona_x1,
    _barra_y1,
    _zona_x2,
    _barra_y2,
    false
);


draw_set_color(
    make_color_rgb(218, 183, 83)
);

draw_rectangle(
    _zona_x1 + 2,
    _barra_y1 + 2,
    _zona_x2 - 2,
    _barra_y2 - 2,
    false
);


// Marcador
var _marcador_x =
    _barra_x1
    + _largura_barra
    * marcador_posicao;

var _marcador_na_zona =
    marcador_posicao >= _zona_inicio
    && marcador_posicao <= _zona_fim;


draw_set_color(
    _marcador_na_zona
        ? make_color_rgb(255, 232, 154)
        : make_color_rgb(214, 196, 173)
);


draw_rectangle(
    _marcador_x - 1,
    _barra_y1 - 3,
    _marcador_x + 1,
    _barra_y2 + 3,
    false
);


draw_triangle(
    _marcador_x - 3,
    _barra_y1 - 5,

    _marcador_x + 3,
    _barra_y1 - 5,

    _marcador_x,
    _barra_y1 - 2,

    false
);


draw_set_color(
    make_color_rgb(89, 69, 56)
);

draw_rectangle(
    _barra_x1,
    _barra_y1,
    _barra_x2,
    _barra_y2,
    true
);

#endregion


#region Rodapé

draw_set_color(
    make_color_rgb(63, 64, 62)
);

draw_rectangle(
    _painel_x1 + 20,
    311,
    _painel_x2 - 20,
    312,
    false
);


draw_set_halign(fa_left);

draw_set_color(
    make_color_rgb(214, 196, 173)
);

draw_text(
    212,
    322,
    "E"
);


draw_set_color(
    make_color_rgb(154, 164, 167)
);

draw_text(
    232,
    322,
    _modo_martelo
    ? "confirmar"
    : "segurar e soltar"
);

#endregion


draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);