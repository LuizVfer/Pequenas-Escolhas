if (
    estado_cacador != CACADOR_PUZZLE
    && estado_cacador != CACADOR_CONCLUIDO
)
{
    exit;
}


#region Dados da interface

var _concluido =
    estado_cacador == CACADOR_CONCLUIDO;

var _painel_x1 = 100;
var _painel_y1 = 92;
var _painel_x2 = 540;
var _painel_y2 = 280;

var _centro_x = 320;

var _peca_y = 184;
var _tamanho_peca = 54;

var _inicio_pecas_x = 194;
var _espacamento = 84;

var _cor_fundo =
    make_color_rgb(18, 15, 13);

var _cor_borda =
    make_color_rgb(95, 73, 52);

var _cor_detalhe =
    make_color_rgb(151, 111, 69);

var _cor_peca =
    make_color_rgb(38, 31, 26);

var _cor_peca_borda =
    make_color_rgb(92, 70, 51);

var _cor_corda =
    make_color_rgb(191, 154, 103);

var _cor_corda_escura =
    make_color_rgb(105, 78, 54);

var _cor_selecao =
    make_color_rgb(214, 169, 105);

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

draw_set_alpha(0.25);
draw_set_color(c_black);

draw_rectangle(
    _painel_x1 + 4,
    _painel_y1 + 4,
    _painel_x2 + 4,
    _painel_y2 + 4,
    false
);


draw_set_alpha(0.96);
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
    _painel_x1 + 30,
    _painel_y1,
    _painel_x2 - 30,
    _painel_y1 + 1,
    false
);

#endregion


#region Título

draw_set_font(fnt_minigame);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(_cor_texto);

draw_text(
    _centro_x,
    114,
    _concluido
        ? "Cordas alinhadas"
        : "Cordas emaranhadas"
);


draw_set_color(_cor_texto_secundario);

draw_text(
    _centro_x,
    136,
    _concluido
        ? "Caminho liberado"
        : "Alinhe as cordas"
);

#endregion


#region Entrada e saída

draw_set_font(fnt_minigame);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(_cor_texto_secundario);


// Rótulo da entrada
draw_text(
    148,
    _peca_y - 38,
    "Entrada"
);


// Rótulo da saída
draw_text(
    492,
    _peca_y - 38,
    "Saída"
);

#endregion


#region Ligações externas

draw_set_color(_cor_corda_escura);


// Entrada até a primeira peça
draw_rectangle(
    116,
    _peca_y - 2,
    _inicio_pecas_x
        - _tamanho_peca * 0.5,
    _peca_y + 2,
    false
);


// Centro da última peça
var _ultima_peca_x =
    _inicio_pecas_x
    + (quantidade_pecas - 1)
    * _espacamento;


// Última peça até a saída
draw_rectangle(
    _ultima_peca_x
        + _tamanho_peca * 0.5,
    _peca_y - 2,
    524,
    _peca_y + 2,
    false
);

#endregion


#region Peças da corda

var _pulso =
    (
        sin(anim_puzzle * 1.5)
        + 1
    ) * 0.5;


for (
    var _i = 0;
    _i < quantidade_pecas;
    _i++
)
{
    var _x =
        _inicio_pecas_x
        + _i * _espacamento;

    var _metade =
        _tamanho_peca * 0.5;

    var _selecionada =
        !_concluido
        && _i == peca_selecionada;


    // Ligação entre as peças
    if (_i < quantidade_pecas - 1)
    {
        var _proxima_x =
            _x + _espacamento;

        draw_set_color(_cor_corda_escura);

        draw_rectangle(
            _x + _metade,
            _peca_y - 2,
            _proxima_x - _metade,
            _peca_y + 2,
            false
        );
    }


    // Destaque da seleção
    if (_selecionada)
    {
        draw_set_alpha(
            0.35 + _pulso * 0.30
        );

        draw_set_color(_cor_selecao);

        draw_rectangle(
            _x - _metade - 4,
            _peca_y - _metade - 4,
            _x + _metade + 4,
            _peca_y + _metade + 4,
            true
        );

        draw_set_alpha(1);
    }


    // Fundo da peça
    draw_set_color(_cor_peca);

    draw_rectangle(
        _x - _metade,
        _peca_y - _metade,
        _x + _metade,
        _peca_y + _metade,
        false
    );


    // Borda da peça
    draw_set_color(
        _selecionada
            ? _cor_selecao
            : _cor_peca_borda
    );

    draw_rectangle(
        _x - _metade,
        _peca_y - _metade,
        _x + _metade,
        _peca_y + _metade,
        true
    );


    // Cor da corda
    draw_set_color(
        _concluido
            ? _cor_selecao
            : _cor_corda
    );


    switch (rotacoes_corda[_i])
    {
        // Horizontal
        case 0:
        {
            draw_line_width(
                _x - 20,
                _peca_y,
                _x + 20,
                _peca_y,
                4
            );
        }
        break;


        // Curva para baixo
        case 1:
        {
            draw_line_width(
                _x - 20,
                _peca_y,
                _x,
                _peca_y,
                4
            );

            draw_line_width(
                _x,
                _peca_y,
                _x,
                _peca_y + 20,
                4
            );
        }
        break;


        // Vertical
        case 2:
        {
            draw_line_width(
                _x,
                _peca_y - 20,
                _x,
                _peca_y + 20,
                4
            );
        }
        break;


        // Curva para cima
        case 3:
        {
            draw_line_width(
                _x - 20,
                _peca_y,
                _x,
                _peca_y,
                4
            );

            draw_line_width(
                _x,
                _peca_y,
                _x,
                _peca_y - 20,
                4
            );
        }
        break;
    }


    // Nó central
    draw_circle(
        _x,
        _peca_y,
        4,
        false
    );


    // Indicador da peça selecionada
    if (_selecionada)
    {
        draw_set_color(_cor_selecao);

        draw_triangle(
            _x - 4,
            _peca_y + _metade + 12,

            _x + 4,
            _peca_y + _metade + 12,

            _x,
            _peca_y + _metade + 7,

            false
        );
    }
}

#endregion


#region Progresso

draw_set_font(fnt_minigame);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);


if (_concluido)
{
    draw_set_color(_cor_selecao);

    draw_text(
        _centro_x,
        238,
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


    draw_set_color(_cor_texto_secundario);

    draw_text(
        _centro_x,
        230,
        string(_pecas_corretas)
        + " de "
        + string(quantidade_pecas)
        + " peças alinhadas"
    );


    draw_text(
        _centro_x,
        258,
        "A/D mover   E girar   Esc sair"
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