if (!ativo)
{
    exit;
}


// ==================================================
// PALETA DA CAIXA
// ==================================================

var _cor_nome =
    make_color_rgb(
        221,
        187,
        119
    );

var _cor_texto =
    make_color_rgb(
        230,
        224,
        207
    );

var _cor_separador =
    make_color_rgb(
        128,
        99,
        62
    );

var _cor_selecao =
    make_color_rgb(
        251,
        204,
        75
    );

var _cor_fundo_selecao =
    make_color_rgb(
        96,
        77,
        41
    );


// ==================================================
// CONFIGURAÇÃO DO TEXTO
// ==================================================

draw_set_font(fnt_dialogo);
draw_set_halign(fa_left);
draw_set_valign(fa_top);


// ==================================================
// CAIXA DE ESCOLHAS
// ==================================================

if (modo_escolha)
{
    var _cx =
        caixa_x;

    var _cy =
        caixa_y;

    var _cw =
        caixa_largura;


    var _pergunta_x =
        _cx + 18;

    var _pergunta_y =
        _cy + 40;

    var _pergunta_largura =
        _cw - 36;


    var _pergunta_altura =
        string_height_ext(
            texto_escolha,
            -1,
            _pergunta_largura
        );


    var _opcoes_y =
        _pergunta_y
        + _pergunta_altura
        + 10;

    var _altura_opcao =
        string_height("Ag") + 5;

    var _quantidade_opcoes =
        array_length(opcoes);


    var _ch =
        (_opcoes_y - _cy)
        + (
            _quantidade_opcoes
            * _altura_opcao
        )
        + 24;


    _ch = max(
        _ch,
        156
    );


    // ----------------------------------------------
    // Caixa
    // ----------------------------------------------

    draw_sprite_stretched(
        spr_caixa_dialogo,
        0,
        _cx,
        _cy,
        _cw,
        _ch
    );


    // ----------------------------------------------
    // Nome
    // ----------------------------------------------

    draw_set_color(_cor_nome);

    draw_text(
        _cx + 18,
        _cy + 10,
        nome_escolha
    );


    // ----------------------------------------------
    // Linha separadora
    // ----------------------------------------------

    draw_set_color(_cor_separador);

    draw_rectangle(
        _cx + 18,
        _cy + 31,
        _cx + _cw - 18,
        _cy + 32,
        false
    );


    // ----------------------------------------------
    // Pergunta
    // ----------------------------------------------

    draw_set_color(_cor_texto);

    draw_text_ext(
        _pergunta_x,
        _pergunta_y,
        texto_escolha,
        -1,
        _pergunta_largura
    );


    // ----------------------------------------------
    // Opções
    // ----------------------------------------------
    
    var _anim_selecao =
        current_time * 0.006;
    
    var _movimento_marcador =
        round(
            sin(_anim_selecao) * 2
        );
    
    var _movimento_opcao =
        round(
            sin(
                _anim_selecao * 0.75
            )
        );
    
    var _pulso_selecao =
        0.38
        + (
            sin(
                _anim_selecao * 1.25
            )
            + 1
        ) * 0.06;
    
    
    for (
        var _i = 0;
        _i < _quantidade_opcoes;
        _i++
    )
    {
        var _linha_y =
            _opcoes_y
            + _i * _altura_opcao;
    
        var _centro_linha_y =
            _linha_y
            + (
                _altura_opcao - 5
            ) * 0.5;
    
    
        if (_i == opcao_atual)
        {
            // Fundo pulsante da opção selecionada
            draw_set_alpha(
                _pulso_selecao
            );
    
            draw_set_color(
                _cor_fundo_selecao
            );
    
            draw_rectangle(
                _cx + 18,
                _linha_y - 3,
                _cx + _cw - 18,
                _linha_y
                    + _altura_opcao
                    - 2,
                false
            );
    
    
            // Marcador igual ao menu
            draw_set_alpha(1);
            draw_set_color(_cor_selecao);
    
            draw_set_font(fnt_minigame);
            draw_set_valign(fa_middle);
    
            draw_text(
                _cx
                    + 24
                    + _movimento_marcador,
                _centro_linha_y,
                ">"
            );
    
    
            // Texto selecionado
            draw_set_font(fnt_dialogo);
            draw_set_valign(fa_top);
    
            draw_text(
                _cx
                    + 44
                    + _movimento_opcao,
                _linha_y,
                string(opcoes[_i])
            );
        }
        else
        {
            // Opções não selecionadas
            draw_set_alpha(1);
            draw_set_color(_cor_texto);
    
            draw_set_font(fnt_dialogo);
            draw_set_valign(fa_top);
    
            draw_text(
                _cx + 44,
                _linha_y,
                string(opcoes[_i])
            );
        }
    }
    
    
    // Restaurar desenho
    draw_set_alpha(1);
    draw_set_font(fnt_dialogo);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);


    // ----------------------------------------------
    // Indicador E
    // ----------------------------------------------

    draw_sprite(
        spr_tecla_E,
        0,
        _cx + _cw - 22,
        _cy + _ch - 20
    );


    // ----------------------------------------------
    // Restaurar configurações
    // ----------------------------------------------

    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    exit;
}


// ==================================================
// VERIFICAR PÁGINA
// ==================================================

if (
    array_length(paginas) <= 0
    || pagina_atual < 0
    || pagina_atual >= array_length(paginas)
)
{
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    exit;
}


var _pagina =
    paginas[pagina_atual];

var _nome =
    string(_pagina.nome);

var _texto =
    string(_pagina.texto);

var _tem_nome =
    string_length(_nome) > 0;


// ==================================================
// CAIXA DO DIÁLOGO
// ==================================================

draw_sprite_stretched(
    spr_caixa_dialogo,
    0,
    caixa_x,
    caixa_y,
    caixa_largura,
    caixa_altura
);


// ==================================================
// NOME
// ==================================================

if (_tem_nome)
{
    draw_set_color(_cor_nome);

    draw_text(
        caixa_x + 18,
        caixa_y + 10,
        _nome
    );


    // ----------------------------------------------
    // Linha separadora
    // ----------------------------------------------

    draw_set_color(_cor_separador);

    draw_rectangle(
        caixa_x + 18,
        caixa_y + 31,
        caixa_x + caixa_largura - 18,
        caixa_y + 32,
        false
    );
}


// ==================================================
// TEXTO
// ==================================================

var _texto_x =
    caixa_x + 18;

var _texto_y;


if (_tem_nome)
{
    _texto_y =
        caixa_y + 40;
}
else
{
    _texto_y =
        caixa_y + 16;
}


var _texto_mostrado =
    string_copy(
        _texto,
        1,
        floor(texto_visivel)
    );


draw_set_color(_cor_texto);

draw_text_ext(
    _texto_x,
    _texto_y,
    _texto_mostrado,
    -1,
    texto_largura
);


// ==================================================
// INDICADOR E
// ==================================================

if (
    texto_visivel
    >= string_length(_texto)
)
{
    draw_sprite(
        spr_tecla_E,
        0,
        caixa_x + caixa_largura - 22,
        caixa_y + caixa_altura - 20
    );
}


// ==================================================
// RESTAURAR CONFIGURAÇÕES
// ==================================================

draw_set_color(c_white);
draw_set_alpha(1);

draw_set_halign(fa_left);
draw_set_valign(fa_top);