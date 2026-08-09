// Só desenha enquanto o minigame estiver aberto
if (
    estado_cacador != CACADOR_PUZZLE
    && estado_cacador != CACADOR_CONCLUIDO
)
{
    exit;
}


#region Configuração visual

var _concluido =
    estado_cacador == CACADOR_CONCLUIDO;

var _centro_x = 320;

var _painel_x1 = 92;
var _painel_y1 = 68;
var _painel_x2 = 548;
var _painel_y2 = 302;

var _peca_y = 184;
var _tamanho_slot = 62;
var _metade_slot = _tamanho_slot * 0.5;

var _inicio_pecas_x = 188;
var _espacamento = 88;

var _escala_corda = 1.75;

var _meia_largura_horizontal =
    sprite_get_width(spr_corda_direita)
    * _escala_corda
    * 0.5;

var _cor_fundo =
    make_color_rgb(23, 30, 37);

var _cor_borda =
    make_color_rgb(56, 74, 51);

var _cor_detalhe =
    make_color_rgb(82, 115, 70);

var _cor_slot =
    make_color_rgb(15, 19, 21);

var _cor_slot_borda =
    make_color_rgb(49, 65, 54);

var _cor_corda_escura =
    make_color_rgb(73, 49, 28);

var _cor_corda_luz =
    make_color_rgb(118, 82, 48);

var _cor_selecao =
    make_color_rgb(251, 204, 75);

var _cor_correta =
    make_color_rgb(112, 153, 91);

var _cor_texto =
    make_color_rgb(214, 222, 213);

var _cor_texto_secundario =
    make_color_rgb(122, 150, 138);

#endregion


#region Fundo e painel

draw_set_alpha(0.38);
draw_set_color(c_black);
draw_rectangle(0, 0, 640, 360, false);


// Sombra
draw_set_alpha(0.28);

draw_rectangle(
    _painel_x1 + 4,
    _painel_y1 + 4,
    _painel_x2 + 4,
    _painel_y2 + 4,
    false
);


// Fundo
draw_set_alpha(0.97);
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


// Detalhes decorativos
draw_set_color(_cor_detalhe);

draw_rectangle(
    _painel_x1 + 30,
    _painel_y1,
    _painel_x2 - 30,
    _painel_y1 + 1,
    false
);

draw_rectangle(
    _painel_x1 + 46,
    _painel_y2 - 1,
    _painel_x2 - 46,
    _painel_y2,
    false
);

#endregion


#region Título

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_font(fnt_dialogo);
draw_set_color(_cor_texto);

draw_text(
    _centro_x,
    91,

    _concluido
        ? "Cordas alinhadas"
        : "Cordas emaranhadas"
);


draw_set_font(fnt_minigame);
draw_set_color(_cor_texto_secundario);

draw_text(
    _centro_x,
    116,

    _concluido
        ? "A passagem foi liberada"
        : "Gire os trechos até formar uma única corda"
);

#endregion


#region Extremidades e ligações

var _primeira_peca_x =
    _inicio_pecas_x;

var _ultima_peca_x =
    _inicio_pecas_x
    + (quantidade_pecas - 1)
    * _espacamento;

var _pino_entrada_x = 124;
var _pino_saida_x = 516;


// Textos das extremidades
draw_set_color(_cor_texto_secundario);

draw_text(
    _pino_entrada_x,
    145,
    "Início"
);

draw_text(
    _pino_saida_x,
    145,
    "Saída"
);


// Corda antes da primeira peça
draw_set_color(_cor_corda_escura);

draw_rectangle(
    _pino_entrada_x,
    _peca_y - 3,

    _primeira_peca_x
        - _metade_slot,

    _peca_y + 3,
    false
);


// Cordas entre as peças
for (
    var _i = 0;
    _i < quantidade_pecas - 1;
    _i++
)
{
    var _x_atual =
        _inicio_pecas_x
        + _i * _espacamento;

    var _x_seguinte =
        _x_atual + _espacamento;


    draw_rectangle(
        _x_atual
            + _metade_slot,

        _peca_y - 3,

        _x_seguinte
            - _metade_slot,

        _peca_y + 3,
        false
    );
}


// Corda depois da última peça
draw_rectangle(
    _ultima_peca_x
        + _metade_slot,

    _peca_y - 3,
    _pino_saida_x,
    _peca_y + 3,
    false
);


// Pinos que prendem as pontas
draw_rectangle(
    _pino_entrada_x - 4,
    _peca_y - 12,
    _pino_entrada_x + 4,
    _peca_y + 12,
    false
);

draw_rectangle(
    _pino_saida_x - 4,
    _peca_y - 12,
    _pino_saida_x + 4,
    _peca_y + 12,
    false
);


// Reflexo nos pinos
draw_set_color(_cor_corda_luz);

draw_rectangle(
    _pino_entrada_x - 3,
    _peca_y - 10,
    _pino_entrada_x - 2,
    _peca_y + 10,
    false
);

draw_rectangle(
    _pino_saida_x - 3,
    _peca_y - 10,
    _pino_saida_x - 2,
    _peca_y + 10,
    false
);

#endregion


#region Peças da corda

var _pulso =
    (sin(anim_puzzle * 1.5) + 1)
    * 0.5;


for (
    var _i = 0;
    _i < quantidade_pecas;
    _i++
)
{
    var _x =
        _inicio_pecas_x
        + _i * _espacamento;

    var _selecionada =
        !_concluido
        && _i == peca_selecionada;

    var _horizontal =
        rotacoes_corda[_i] == 0;


    // Fundo do encaixe
    draw_set_color(_cor_slot);

    draw_rectangle(
        _x - _metade_slot,
        _peca_y - _metade_slot,

        _x + _metade_slot,
        _peca_y + _metade_slot,

        false
    );


    // Pontas internas da corda.
    // Elas encostam no sprite somente quando
    // o trecho está na horizontal.
    draw_set_color(_cor_corda_escura);

    draw_rectangle(
        _x - _metade_slot,
        _peca_y - 3,

        _x
            - _meia_largura_horizontal,

        _peca_y + 3,
        false
    );

    draw_rectangle(
        _x
            + _meia_largura_horizontal,

        _peca_y - 3,
        _x + _metade_slot,
        _peca_y + 3,
        false
    );


    // Borda do encaixe
    draw_set_color(
        _concluido
            ? _cor_selecao
            : (
                _selecionada
                    ? _cor_selecao
                    : _cor_slot_borda
            )
    );

    draw_rectangle(
        _x - _metade_slot,
        _peca_y - _metade_slot,

        _x + _metade_slot,
        _peca_y + _metade_slot,

        true
    );


    // Pulso da peça selecionada
    if (_selecionada)
    {
        draw_set_alpha(
            0.20
            + _pulso * 0.22
        );

        draw_set_color(_cor_selecao);

        draw_rectangle(
            _x - _metade_slot - 4,
            _peca_y - _metade_slot - 4,

            _x + _metade_slot + 4,
            _peca_y + _metade_slot + 4,

            true
        );

        draw_set_alpha(1);
    }


    // O Auto Trim deixou a horizontal com 32x11
    // e a vertical com 11x32.
    var _sprite_corda =
        _horizontal
            ? spr_corda_direita
            : spr_corda_baixo;


    // Obtém as medidas reais do sprite
    var _largura_sprite =
        sprite_get_width(
            _sprite_corda
        );

    var _altura_sprite =
        sprite_get_height(
            _sprite_corda
        );

    var _origem_x =
        sprite_get_xoffset(
            _sprite_corda
        );

    var _origem_y =
        sprite_get_yoffset(
            _sprite_corda
        );


    // Centraliza corretamente mesmo depois
    // de outro Auto Trim
    var _desenho_x =
        _x
        + (
            _origem_x
            - _largura_sprite * 0.5
        )
        * _escala_corda;

    var _desenho_y =
        _peca_y
        + (
            _origem_y
            - _altura_sprite * 0.5
        )
        * _escala_corda;


    draw_sprite_ext(
        _sprite_corda,
        0,

        _desenho_x,
        _desenho_y,

        _escala_corda,
        _escala_corda,

        0,
        c_white,
        1
    );


    // Pequena marca de progresso
    draw_set_color(
        _horizontal
            ? _cor_correta
            : _cor_slot_borda
    );

    draw_rectangle(
        _x - 5,
        _peca_y + _metade_slot + 7,

        _x + 5,
        _peca_y + _metade_slot + 9,

        false
    );


    // Ponteiro da seleção
    if (_selecionada)
    {
        draw_set_color(_cor_selecao);

        draw_triangle(
            _x - 5,
            _peca_y - _metade_slot - 11,

            _x + 5,
            _peca_y - _metade_slot - 11,

            _x,
            _peca_y - _metade_slot - 6,

            false
        );
    }
}

#endregion


#region Progresso e controles

draw_set_font(fnt_minigame);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);


if (_concluido)
{
    draw_set_color(_cor_selecao);

    draw_text(
        _centro_x,
        252,
        "Corda desembaraçada"
    );
}
else
{
    var _pecas_corretas = 0;


    for (
        var _i = 0;
        _i < quantidade_pecas;
        _i++
    )
    {
        if (
            rotacoes_corda[_i]
            == solucao_corda[_i]
        )
        {
            _pecas_corretas++;
        }
    }


    draw_set_color(
        _cor_texto_secundario
    );

    draw_text(
        _centro_x,
        246,

        string(_pecas_corretas)
        + " de "
        + string(quantidade_pecas)
        + " trechos alinhados"
    );


    draw_text(
        _centro_x,
        278,
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