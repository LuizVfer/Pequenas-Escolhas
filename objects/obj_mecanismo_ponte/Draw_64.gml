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

var _raio_roda = 28;
var _escala_engrenagem = 1.65;

var _centros_rodas =
[
    210,
    320,
    430
];


// Paleta da Floresta
var _cor_fundo =
    make_color_rgb(
        23,
        30,
        37
    );

var _cor_borda =
    make_color_rgb(
        56,
        74,
        51
    );

var _cor_detalhe =
    make_color_rgb(
        82,
        115,
        70
    );

var _cor_selecao =
    make_color_rgb(
        251,
        204,
        75
    );

var _cor_texto =
    make_color_rgb(
        214,
        222,
        213
    );

var _cor_texto_secundario =
    make_color_rgb(
        122,
        150,
        138
    );

var _cor_ligacao =
    make_color_rgb(
        38,
        53,
        48
    );

var _cor_trava =
    make_color_rgb(
        26,
        36,
        27
    );

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
        : "Faça as três marcas apontarem para cima"
);

#endregion


#region Ligações entre as engrenagens

draw_set_color(_cor_ligacao);

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


#region Engrenagens

var _pulso_selecao =
    (
        sin(anim_puzzle * 1.5)
        + 1
    )
    * 0.5;


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


    // Destaque atrás da engrenagem
    if (_selecionada)
    {
        draw_set_alpha(
            0.25
            + _pulso_selecao * 0.20
        );

        draw_set_color(_cor_selecao);

        draw_circle(
            _x,
            _centro_y,
            _raio_roda + 5,
            false
        );

        draw_set_alpha(1);
    }


    // O desenho original aponta para cima.
    // Ângulos:
    // 0 = cima
    // 1 = direita
    // 2 = baixo
    var _angulo_engrenagem =
        -posicoes_rodas[_i] * 90;


    draw_sprite_ext(
        spr_engranagem,
        0,

        _x,
        _centro_y,

        _escala_engrenagem,
        _escala_engrenagem,

        _angulo_engrenagem,

        c_white,
        1
    );


    // Contorno da engrenagem selecionada
    if (_selecionada)
    {
        draw_set_color(_cor_selecao);

        draw_circle(
            _x,
            _centro_y,
            _raio_roda + 2,
            true
        );


        // Indicador abaixo da engrenagem
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
draw_set_color(_cor_ligacao);

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


    // Preenchimento da trava
    draw_set_color(
        _ativa
            ? _cor_selecao
            : _cor_trava
    );

    draw_rectangle(
        _x - 6,
        _trava_y - 6,
        _x + 6,
        _trava_y + 6,
        false
    );


    // Borda da trava
    draw_set_color(
        _ativa
            ? make_color_rgb(
                255,
                230,
                154
            )
            : _cor_borda
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