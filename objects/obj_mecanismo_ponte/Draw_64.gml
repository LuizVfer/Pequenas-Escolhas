// Só aparece durante o puzzle
if (
    global.ponte_abaixada
    || (
        estado_mecanismo != MECANISMO_PUZZLE
        && estado_mecanismo != MECANISMO_CONCLUIDO
    )
)
{
    exit;
}


#region Dados da interface

var _concluido =
    estado_mecanismo
        == MECANISMO_CONCLUIDO;

var _centro_x = 320;
var _centro_y = 180;

var _painel_x1 = 112;
var _painel_y1 = 76;
var _painel_x2 = 528;
var _painel_y2 = 292;

var _raio_roda = 30;

var _centros_rodas =
[
    210,
    320,
    430
];

var _cor_fundo =
    make_color_rgb(18, 15, 13);

var _cor_borda =
    make_color_rgb(95, 73, 52);

var _cor_detalhe =
    make_color_rgb(151, 111, 69);

var _cor_roda =
    make_color_rgb(45, 35, 28);

var _cor_roda_borda =
    make_color_rgb(118, 88, 59);

var _cor_marca =
    make_color_rgb(220, 199, 160);

var _cor_selecao =
    make_color_rgb(207, 162, 101);

var _cor_texto =
    make_color_rgb(230, 214, 184);

var _cor_texto_secundario =
    make_color_rgb(145, 134, 116);

#endregion


#region Escurecimento

draw_set_alpha(0.35);
draw_set_color(c_black);

draw_rectangle(
    0,
    0,
    640,
    360,
    false
);

#endregion


#region Painel

// Sombra
draw_set_alpha(0.25);
draw_set_color(c_black);

draw_rectangle(
    _painel_x1 + 4,
    _painel_y1 + 4,
    _painel_x2 + 4,
    _painel_y2 + 4,
    false
);


// Fundo
draw_set_alpha(0.96);
draw_set_color(_cor_fundo);

draw_rectangle(
    _painel_x1,
    _painel_y1,
    _painel_x2,
    _painel_y2,
    false
);


// Borda
draw_set_alpha(1);
draw_set_color(_cor_borda);

draw_rectangle(
    _painel_x1,
    _painel_y1,
    _painel_x2,
    _painel_y2,
    true
);


// Detalhe superior
draw_set_color(_cor_detalhe);

draw_rectangle(
    _painel_x1 + 28,
    _painel_y1,
    _painel_x2 - 28,
    _painel_y1 + 1,
    false
);

#endregion


#region Título

draw_set_font(fnt_dialogo);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(_cor_texto);

draw_text(
    _centro_x,
    98,
    _concluido
        ? "Mecanismo alinhado"
        : "Mecanismo da ponte"
);


draw_set_font(fnt_minigame);
draw_set_color(_cor_texto_secundario);

draw_text(
    _centro_x,
    120,
    _concluido
        ? "As travas começaram a se soltar"
        : "Alinhe as três marcas"
);

#endregion


#region Ligações entre as rodas

draw_set_color(
    make_color_rgb(78, 58, 42)
);

draw_rectangle(
    _centros_rodas[0] + _raio_roda,
    _centro_y - 2,

    _centros_rodas[1] - _raio_roda,
    _centro_y + 2,

    false
);


draw_rectangle(
    _centros_rodas[1] + _raio_roda,
    _centro_y - 2,

    _centros_rodas[2] - _raio_roda,
    _centro_y + 2,

    false
);

#endregion


#region Rodas

var _pulso_selecao =
    (
        sin(anim_puzzle * 1.5)
        + 1
    ) * 0.5;


for (
    var _i = 0;
    _i < quantidade_rodas;
    _i++
)
{
    var _x =
        _centros_rodas[_i];

    var _selecionada =
        !_concluido
        && _i == roda_selecionada;


    // Destaque da roda selecionada
    if (_selecionada)
    {
        draw_set_alpha(
            0.45 + _pulso_selecao * 0.30
        );

        draw_set_color(_cor_selecao);

        draw_circle(
            _x,
            _centro_y,
            _raio_roda + 5,
            true
        );

        draw_set_alpha(1);
    }


    // Fundo da roda
    draw_set_color(_cor_roda);

    draw_circle(
        _x,
        _centro_y,
        _raio_roda,
        false
    );


    // Borda da roda
    draw_set_color(
        _selecionada
            ? _cor_selecao
            : _cor_roda_borda
    );

    draw_circle(
        _x,
        _centro_y,
        _raio_roda,
        true
    );


    // Eixo central
    draw_set_color(
        make_color_rgb(91, 68, 48)
    );

    draw_circle(
        _x,
        _centro_y,
        7,
        false
    );


    draw_set_color(
        make_color_rgb(142, 105, 68)
    );

    draw_circle(
        _x,
        _centro_y,
        7,
        true
    );


    // Pequenos suportes internos
    draw_set_color(
        make_color_rgb(73, 54, 40)
    );

    draw_line(
        _x - 22,
        _centro_y,
        _x + 22,
        _centro_y
    );

    draw_line(
        _x,
        _centro_y - 22,
        _x,
        _centro_y + 22
    );


    // Direção da marca
    var _direcao_x = 0;
    var _direcao_y = -18;

    switch (posicoes_rodas[_i])
    {
        // Cima
        case 0:
            _direcao_x = 0;
            _direcao_y = -18;
        break;


        // Direita
        case 1:
            _direcao_x = 18;
            _direcao_y = 0;
        break;


        // Baixo
        case 2:
            _direcao_x = 0;
            _direcao_y = 18;
        break;
    }


    // Marca da roda
    draw_set_color(
        _concluido
            ? _cor_selecao
            : _cor_marca
    );

    draw_line_width(
        _x,
        _centro_y,
        _x + _direcao_x,
        _centro_y + _direcao_y,
        3
    );


    draw_circle(
        _x + _direcao_x,
        _centro_y + _direcao_y,
        3,
        false
    );


    // Indicador de seleção
    if (_selecionada)
    {
        draw_triangle(
            _x - 4,
            _centro_y + 40,

            _x + 4,
            _centro_y + 40,

            _x,
            _centro_y + 35,

            false
        );
    }
}

#endregion


#region Travas da reação em cadeia

var _travas_ativas = 0;

if (_concluido)
{
    var _tempo_passado =
        espera_conclusao
        - contador_conclusao;

    _travas_ativas =
        clamp(
            1 + floor(_tempo_passado / 6),
            1,
            quantidade_rodas
        );
}


var _trava_y = 232;

var _inicio_travas_x = 286;
var _espaco_travas = 34;


// Linhas entre as travas
draw_set_color(
    make_color_rgb(71, 53, 39)
);

draw_rectangle(
    _inicio_travas_x + 8,
    _trava_y - 1,
    _inicio_travas_x
        + _espaco_travas * 2
        - 8,
    _trava_y + 1,
    false
);


for (
    var _i = 0;
    _i < quantidade_rodas;
    _i++
)
{
    var _x =
        _inicio_travas_x
        + _i * _espaco_travas;

    var _ativa =
        _i < _travas_ativas;


    draw_set_color(
        _ativa
            ? _cor_selecao
            : make_color_rgb(54, 42, 34)
    );

    draw_rectangle(
        _x - 6,
        _trava_y - 6,
        _x + 6,
        _trava_y + 6,
        false
    );


    draw_set_color(
        _ativa
            ? make_color_rgb(238, 199, 130)
            : make_color_rgb(105, 78, 54)
    );

    draw_rectangle(
        _x - 6,
        _trava_y - 6,
        _x + 6,
        _trava_y + 6,
        true
    );
}

#endregion


#region Controles

draw_set_font(fnt_minigame);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(_cor_texto_secundario);


if (_concluido)
{
    draw_text(
        _centro_x,
        266,
        "Mecanismo liberado"
    );
}
else
{
    draw_text(
        _centro_x,
        264,
        "A / D selecionar     E girar     Esc sair"
    );
}

#endregion


#region Restaurar desenho

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(fnt_dialogo);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

#endregion