#region Configuração da GUI

var _gui_largura =
    display_get_gui_width();

var _gui_altura =
    display_get_gui_height();

var _centro_x =
    _gui_largura * 0.5;

var _centro_y =
    _gui_altura * 0.5;

#endregion


#region Fundo escuro

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

draw_set_color(c_white);

#endregion


#region Livro fechado

if (
    estado_final
        == ESTADO_LIVRO_FECHADO_INICIO

    || estado_final
        == ESTADO_LIVRO_FECHADO_FINAL
)
{
    draw_sprite(
        spr_livro_fechado,
        0,
        _centro_x,
        _centro_y
    );
}

#endregion


#region Consequências

else if (
    estado_final
    == ESTADO_CONSEQUENCIAS
)
{
    // O sprite já contém o livro,
    // o pergaminho e a ilustração.
    if (sprite_consequencia != noone)
    {
        draw_sprite(
            sprite_consequencia,
            0,
            0,
            0
        );
    }


    draw_set_halign(fa_center);
    draw_set_valign(fa_top);


    // ----------------------------------------------
    // Título
    // ----------------------------------------------

    draw_set_font(fnt_dialogo);

    draw_set_color(
        make_color_rgb(
            76,
            45,
            27
        )
    );

    draw_text(
        _centro_x,
        20,
        titulo_consequencia
    );


    // ----------------------------------------------
    // Frase atual
    // ----------------------------------------------

    var _quantidade_frases =
        array_length(
            frases_consequencia
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
                frases_consequencia[
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


        // Fonte menor para as frases maiores
        // caberem dentro da moldura.
        draw_set_font(fnt_minigame);

        draw_set_color(
            make_color_rgb(
                45,
                35,
                25
            )
        );


        draw_text_ext(
            _centro_x,
            164,
            _frase_mostrada,
            18,
            220
        );


        // Indicador para continuar
        if (
            caracteres_visiveis
            >= string_length(
                _frase_completa
            )
        )
        {
            draw_sprite(
                spr_tecla_E,
                0,
                574,
                330
            );
        }
    }
}

#endregion


#region Mensagem final

else if (
    estado_final
    == ESTADO_MENSAGEM_FINAL
)
{
    var _quantidade_finais =
        array_length(
            frases_finais
        );


    if (_quantidade_finais > 0)
    {
        var _indice_final =
            clamp(
                frase_final_atual,
                0,
                _quantidade_finais - 1
            );


        var _frase_final_completa =
            string(
                frases_finais[
                    _indice_final
                ]
            );


        var _caracteres_finais =
            clamp(
                floor(
                    caracteres_finais_visiveis
                ),
                0,
                string_length(
                    _frase_final_completa
                )
            );


        var _frase_final_mostrada =
            string_copy(
                _frase_final_completa,
                1,
                _caracteres_finais
            );


        draw_set_font(fnt_dialogo);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);


        draw_set_color(
            make_color_rgb(
                225,
                211,
                184
            )
        );


        draw_text_ext(
            _centro_x,
            170,
            _frase_final_mostrada,
            -1,
            500
        );


        // Indicador para avançar
        if (
            caracteres_finais_visiveis
            >= string_length(
                _frase_final_completa
            )
        )
        {
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


#region Título e créditos

else if (
    estado_final
    == ESTADO_CREDITOS
)
{
    draw_set_font(fnt_dialogo);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);


    // ----------------------------------------------
    // Título
    // ----------------------------------------------

    draw_set_alpha(
        clamp(
            alpha_titulo_final,
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
        86,
        titulo_final
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
        110,
        _centro_x + 100,
        111,
        false
    );


    // ----------------------------------------------
    // Créditos
    // ----------------------------------------------

    draw_set_alpha(
        clamp(
            alpha_creditos,
            0,
            1
        )
    );


    draw_set_color(
        make_color_rgb(
            190,
            178,
            155
        )
    );


    var _credito_y = 152;
    var _espacamento = 20;

    var _quantidade_creditos =
        array_length(creditos);


    for (
        var _i = 0;
        _i < _quantidade_creditos;
        _i++
    )
    {
        draw_text(
            _centro_x,
            _credito_y
                + _i * _espacamento,
            string(creditos[_i])
        );
    }


    // ----------------------------------------------
    // Instrução para voltar ao menu
    // ----------------------------------------------

    if (final_completo)
    {
        draw_set_alpha(1);

        draw_set_font(fnt_dialogo);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);

        draw_set_color(
            make_color_rgb(
                145,
                132,
                112
            )
        );


        draw_text(
            _centro_x,
            330,
            "Pressione E para voltar ao menu"
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