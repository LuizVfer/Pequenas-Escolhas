#region Configuração da GUI

var _gui_largura =
    display_get_gui_width();

var _gui_altura =
    display_get_gui_height();

var _centro_x =
    _gui_largura * 0.5;

#endregion


#region Fundo

draw_set_alpha(1);


draw_set_color(
    make_color_rgb(
        20,
        16,
        13
    )
);


draw_rectangle(
    0,
    0,
    _gui_largura,
    _gui_altura,
    false
);


draw_set_font(
    fnt_dialogo
);

draw_set_halign(
    fa_center
);

draw_set_valign(
    fa_middle
);

#endregion


#region Textos da introdução

if (estado_intro == ESTADO_TEXTOS)
{
    var _quantidade_frases =
        array_length(
            frases_intro
        );


    if (_quantidade_frases > 0)
    {
        var _indice_frase =
            clamp(
                frase_atual,
                0,
                _quantidade_frases - 1
            );


        var _frase_completa =
            string(
                frases_intro[
                    _indice_frase
                ]
            );


        var _quantidade_caracteres =
            clamp(
                floor(
                    caracteres_visiveis
                ),
                0,
                string_length(
                    _frase_completa
                )
            );


        var _frase_mostrada =
            string_copy(
                _frase_completa,
                1,
                _quantidade_caracteres
            );


        draw_set_color(
            make_color_rgb(
                225,
                211,
                184
            )
        );


        draw_text_ext(
            _centro_x,
            165,
            _frase_mostrada,
            -1,
            500
        );


        // Indicador para continuar
        if (
            caracteres_visiveis
            >= string_length(
                _frase_completa
            )
        )
        {
            draw_set_color(
                c_white
            );


            draw_sprite(
                spr_tecla_E,
                0,
                590,
                330
            );
        }
    }
}

#endregion


#region Título do jogo

else if (
    estado_intro
    == ESTADO_TITULO
)
{
    draw_set_alpha(
        clamp(
            alpha_titulo,
            0,
            1
        )
    );


    draw_set_color(
        make_color_rgb(
            225,
            211,
            184
        )
    );


    draw_text(
        _centro_x,
        164,
        titulo_intro
    );


    // Linha abaixo do título
    draw_set_color(
        make_color_rgb(
            125,
            94,
            65
        )
    );


    draw_rectangle(
        _centro_x - 100,
        190,
        _centro_x + 100,
        191,
        false
    );


    draw_set_alpha(1);


    // Indicador para continuar
    if (alpha_titulo >= 1)
    {
        draw_set_color(
            c_white
        );


        draw_sprite(
            spr_tecla_E,
            0,
            590,
            330
        );
    }
}

#endregion


#region Restaurar configurações

draw_set_alpha(1);
draw_set_color(c_white);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

#endregion