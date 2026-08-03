// ==================================================
// FUNDO
// ==================================================

draw_set_color(
    make_color_rgb(20, 16, 13)
);

draw_rectangle(
    0,
    0,
    640,
    360,
    false
);


draw_set_font(fnt_dialogo);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);


// ==================================================
// TEXTOS DA INTRODUÇÃO
// ==================================================

if (estado_intro == 0)
{
    var _frase_completa =
        frases_intro[frase_atual];

    var _frase_mostrada =
        string_copy(
            _frase_completa,
            1,
            floor(caracteres_visiveis)
        );


    draw_set_color(
        make_color_rgb(225, 211, 184)
    );


    draw_text_ext(
        320,
        165,
        _frase_mostrada,
        -1,
        500
    );


    // Indicador E
    if (
        caracteres_visiveis
        >= string_length(_frase_completa)
    )
    {
        draw_set_color(c_white);

        draw_sprite(
            spr_tecla_E,
            0,
            590,
            330
        );
    }
}


// ==================================================
// TÍTULO DO JOGO
// ==================================================

else if (estado_intro == 1)
{
    draw_set_alpha(alpha_titulo);


    draw_set_color(
        make_color_rgb(225, 211, 184)
    );

    draw_text(
        320,
        164,
        titulo_intro
    );


    draw_set_color(
        make_color_rgb(125, 94, 65)
    );

    draw_rectangle(
        220,
        190,
        420,
        191,
        false
    );


    draw_set_alpha(1);


    if (alpha_titulo >= 1)
    {
        draw_set_color(c_white);

        draw_sprite(
            spr_tecla_E,
            0,
            590,
            330
        );
    }
}


// ==================================================
// RESTAURA AS CONFIGURAÇÕES
// ==================================================

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);