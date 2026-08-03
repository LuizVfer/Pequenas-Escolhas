// ==================================================
// FUNDO ESCURO
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

draw_set_color(c_white);


// ==================================================
// ESTADOS 0 E 2 — LIVRO FECHADO
// ==================================================

if (
    estado_final == 0
    || estado_final == 2
)
{
    draw_sprite(
        spr_livro_fechado,
        0,
        320,
        180
    );
}


// ==================================================
// ESTADO 1 — CONSEQUÊNCIAS
// ==================================================

else if (estado_final == 1)
{
    // Fundo do livro
    draw_sprite(
        spr_fundo_pergaminho,
        0,
        0,
        0
    );


    draw_set_font(fnt_dialogo);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);


    // Título
    draw_set_color(
        make_color_rgb(80, 48, 30)
    );

    draw_text(
        320,
        14,
        titulo_consequencia
    );


    // Imagem
    if (sprite_consequencia != noone)
    {
        draw_sprite(
            sprite_consequencia,
            0,
            160,
            42
        );
    }


    // Frase atual
    if (array_length(frases_consequencia) > 0)
    {
        var _frase_completa =
            frases_consequencia[frase_atual];

        var _frase_mostrada = string_copy(
            _frase_completa,
            1,
            floor(caracteres_visiveis)
        );


        draw_set_color(
            make_color_rgb(45, 35, 25)
        );

        draw_text_ext(
            320,
            232,
            _frase_mostrada,
            -1,
            540
        );


        // Indicador para continuar
        if (
            caracteres_visiveis
            >= string_length(_frase_completa)
        )
        {
            draw_sprite(
                spr_tecla_E_placeholder,
                0,
                574,
                330
            );
        }
    }
}


// ==================================================
// ESTADO 3 — REFLEXÃO FINAL
// ==================================================

else if (estado_final == 3)
{
    var _frase_final_completa =
        frases_finais[frase_final_atual];

    var _frase_final_mostrada = string_copy(
        _frase_final_completa,
        1,
        floor(caracteres_finais_visiveis)
    );


    draw_set_font(fnt_dialogo);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_set_color(
        make_color_rgb(225, 211, 184)
    );


    draw_text_ext(
        320,
        170,
        _frase_final_mostrada,
        -1,
        500
    );


    // Indicador para avançar
    if (
        caracteres_finais_visiveis
        >= string_length(_frase_final_completa)
    )
    {
        draw_sprite(
            spr_tecla_E_placeholder,
            0,
            590,
            330
        );
    }
}

// ==================================================
// ESTADO 4 — TÍTULO FINAL E CRÉDITOS
// ==================================================

else if (estado_final == 4)
{
    draw_set_font(fnt_dialogo);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);


    // ==================================================
    // TÍTULO
    // ==================================================

    draw_set_alpha(alpha_titulo_final);

    draw_set_color(
        make_color_rgb(225, 211, 184)
    );

    draw_text(
        320,
        86,
        titulo_final
    );


    // Pequena linha abaixo do título
    draw_set_color(
        make_color_rgb(125, 94, 65)
    );

    draw_rectangle(
        220,
        110,
        420,
        111,
        false
    );


    // ==================================================
    // CRÉDITOS
    // ==================================================

    draw_set_alpha(alpha_creditos);

    draw_set_color(
        make_color_rgb(190, 178, 155)
    );


    var _credito_y = 152;
    var _espacamento = 20;

    for (
        var _i = 0;
        _i < array_length(creditos);
        _i++
    )
    {
        draw_text(
            320,
            _credito_y + _i * _espacamento,
            creditos[_i]
        );
    }
    
    // ==================================================
    // INSTRUÇÃO PARA VOLTAR AO MENU
    // ==================================================
    
    if (final_completo)
    {
        draw_set_alpha(1);
    
        draw_set_font(fnt_dialogo);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
    
        draw_set_color(
            make_color_rgb(145, 132, 112)
        );
    
        draw_text(
            320,
            330,
            "Pressione E para voltar ao menu"
        );
    }


    // Restaura o alpha
    draw_set_alpha(1);
}


// ==================================================
// RESTAURA CONFIGURAÇÕES
// ==================================================

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);