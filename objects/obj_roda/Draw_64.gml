// ==================================================
// MINIGAME DA RODA
// ==================================================

if (
    (
        estado_puzzle_roda != 2
        && estado_puzzle_roda != 6
    )
    || !minigame_ativo
)
{
    exit;
}


var _modo_martelo =
    estado_puzzle_roda == 6;

var _progresso_atual =
    impulso_atual;

var _quantidade_progresso =
    quantidade_impulsos;

var _titulo_minigame =
    "Empurrar a roda";


if (_modo_martelo)
{
    _progresso_atual =
        marteladas_corretas;

    _quantidade_progresso =
        quantidade_marteladas;

    _titulo_minigame =
        "Fixar a roda";
}


// ==================================================
// POSIÇÕES
// ==================================================

var _painel_x1 = 160;
var _painel_y1 = 246;

var _painel_x2 = 480;
var _painel_y2 = 338;

var _barra_x1 = 210;
var _barra_y1 = 288;

var _barra_x2 = 430;
var _barra_y2 = 298;

var _largura_barra =
    _barra_x2 - _barra_x1;

var _pulso =
(
    sin(anim_minigame_roda)
    + 1
) * 0.5;


// ==================================================
// PAINEL MINIMALISTA
// ==================================================

// Sombra bem discreta
draw_set_alpha(0.25);
draw_set_color(c_black);

draw_rectangle(
    _painel_x1 + 3,
    _painel_y1 + 3,
    _painel_x2 + 3,
    _painel_y2 + 3,
    false
);


// Fundo principal
draw_set_alpha(0.95);

draw_set_color(
    make_color_rgb(18, 15, 13)
);

draw_rectangle(
    _painel_x1,
    _painel_y1,
    _painel_x2,
    _painel_y2,
    false
);


// Borda única e discreta
draw_set_alpha(1);

draw_set_color(
    make_color_rgb(100, 76, 53)
);

draw_rectangle(
    _painel_x1,
    _painel_y1,
    _painel_x2,
    _painel_y2,
    true
);


// Pequeno detalhe superior
draw_set_color(
    make_color_rgb(153, 113, 70)
);

draw_rectangle(
    _painel_x1 + 24,
    _painel_y1,
    _painel_x2 - 24,
    _painel_y1 + 1,
    false
);


// ==================================================
// TEXTO BASE
// ==================================================

draw_set_font(fnt_minigame);
draw_set_valign(fa_middle);


// ==================================================
// TÍTULO
// ==================================================

draw_set_halign(fa_left);

draw_set_color(
    make_color_rgb(237, 219, 182)
);

draw_text(
    174,
    258,
    _titulo_minigame
);


// ==================================================
// PROGRESSO (BOLINHAS)
// ==================================================

for (
    var _i = 0;
    _i < _quantidade_progresso;
    _i++
)
{
    var _circulo_x =
        430 + _i * 16;

    if (_i < _progresso_atual)
    {
        draw_set_color(
            make_color_rgb(210, 166, 101)
        );
    }
    else
    {
        draw_set_color(
            make_color_rgb(72, 57, 43)
        );
    }

    draw_circle(
        _circulo_x,
        258,
        4,
        false
    );

    draw_set_color(
        make_color_rgb(137, 104, 70)
    );

    draw_circle(
        _circulo_x,
        258,
        4,
        true
    );
}


// ==================================================
// INSTRUÇÃO / ERRO
// ==================================================

draw_set_halign(fa_center);

if (feedback_erro > 0)
{
    draw_set_color(
        make_color_rgb(207, 125, 101)
    );

    if (_modo_martelo)
    {
        draw_text(
            320,
            272,
            "Voltou ao início"
        );
    }
    else
    {
        draw_text(
            320,
            272,
            "Errou"
        );
    }
}
else
{
    draw_set_color(
        make_color_rgb(151, 138, 118)
    );

    draw_text(
        320,
        274,
        "Acerte a faixa"
    );
}


// ==================================================
// FUNDO DA BARRA
// ==================================================

draw_set_color(
    make_color_rgb(43, 34, 28)
);

draw_rectangle(
    _barra_x1,
    _barra_y1,
    _barra_x2,
    _barra_y2,
    false
);

draw_set_color(
    make_color_rgb(57, 46, 37)
);

draw_rectangle(
    _barra_x1 + 2,
    _barra_y1 + 2,
    _barra_x2 - 2,
    _barra_y2 - 2,
    false
);


// ==================================================
// ZONA CORRETA
// ==================================================

var _zona_inicio =
    zona_centro
    - zona_largura * 0.5;

var _zona_fim =
    zona_centro
    + zona_largura * 0.5;

var _zona_x1 =
    _barra_x1
    + _largura_barra * _zona_inicio;

var _zona_x2 =
    _barra_x1
    + _largura_barra * _zona_fim;


// brilho
draw_set_alpha(
    0.14 + _pulso * 0.08
);

draw_set_color(
    make_color_rgb(225, 174, 98)
);

draw_rectangle(
    _zona_x1 - 1,
    _barra_y1 - 1,
    _zona_x2 + 1,
    _barra_y2 + 1,
    false
);


// faixa dourada
draw_set_alpha(1);

draw_set_color(
    make_color_rgb(174, 128, 72)
);

draw_rectangle(
    _zona_x1,
    _barra_y1,
    _zona_x2,
    _barra_y2,
    false
);

draw_set_color(
    make_color_rgb(198, 151, 88)
);

draw_rectangle(
    _zona_x1 + 2,
    _barra_y1 + 2,
    _zona_x2 - 2,
    _barra_y2 - 2,
    false
);


// ==================================================
// MARCADOR
// ==================================================

var _marcador_x =
    _barra_x1
    + _largura_barra
    * marcador_posicao;

var _marcador_na_zona =
    marcador_posicao >= _zona_inicio
    && marcador_posicao <= _zona_fim;

if (_marcador_na_zona)
{
    draw_set_color(
        make_color_rgb(255, 230, 169)
    );
}
else
{
    draw_set_color(
        make_color_rgb(225, 214, 190)
    );
}


// Linha principal
draw_rectangle(
    _marcador_x - 1,
    _barra_y1 - 3,
    _marcador_x + 1,
    _barra_y2 + 3,
    false
);


// Ponta superior
draw_triangle(
    _marcador_x - 3,
    _barra_y1 - 5,
    _marcador_x + 3,
    _barra_y1 - 5,
    _marcador_x,
    _barra_y1 - 2,
    false
);


// Borda da barra
draw_set_color(
    make_color_rgb(120, 89, 59)
);

draw_rectangle(
    _barra_x1,
    _barra_y1,
    _barra_x2,
    _barra_y2,
    true
);


// ==================================================
// LINHA INFERIOR
// ==================================================

draw_set_color(
    make_color_rgb(64, 48, 36)
);

draw_rectangle(
    180,
    311,
    460,
    312,
    false
);


// ==================================================
// RODAPÉ MÍNIMO
// ==================================================

draw_set_halign(fa_left);

draw_set_color(
    make_color_rgb(147, 134, 115)
);

draw_text(
    212,
    322,
    "E"
);


draw_set_color(
    make_color_rgb(118, 108, 92)
);

draw_text(
    232,
    322,
    "acertar"
);


// ==================================================
// RESTAURAR DRAW
// ==================================================

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);