#region Medidas

var _painel_centro_x = 124;

#endregion


#region Paleta

var _cor_dourado =
    make_color_rgb(
        235,
        188,
        96
    );

var _cor_dourado_escuro =
    make_color_rgb(
        173,
        139,
        71
    );

var _cor_texto =
    make_color_rgb(
        210,
        194,
        163
    );

var _cor_texto_secundario =
    make_color_rgb(
        143,
        129,
        103
    );

var _cor_selecao =
    make_color_rgb(
        96,
        77,
        41
    );

#endregion


#region Fundo animado

draw_set_alpha(
    clamp(
        alpha_fundo,
        0,
        1
    )
);

draw_set_color(c_white);


draw_sprite(
    spr_menu_fundo,
    floor(frame_fundo_menu),
    0,
    0
);


draw_set_alpha(1);

#endregion


#region Telas

switch (estado_menu)
{
    // ==============================================
    // MENU PRINCIPAL
    // ==============================================

    case MENU_PRINCIPAL:
    {
        var _movimento_logo =
            round(
                sin(
                    anim_menu * 0.45
                )
            );


        var _movimento_marcador =
            round(
                sin(anim_menu) * 2
            );


        var _movimento_opcao =
            round(
                sin(
                    anim_menu * 0.75
                )
            );


        var _pulso_selecao =
            0.12
            + (
                sin(
                    anim_menu * 1.25
                )
                + 1
            ) * 0.025;


        // ------------------------------------------
        // Logo
        // ------------------------------------------

        draw_set_alpha(alpha_logo);
        draw_set_color(c_white);


        draw_sprite(
            spr_logo_pequenas_escolhas,
            floor(frame_logo_menu),
            50,
            _movimento_logo
        );


        // ------------------------------------------
        // Opções
        // ------------------------------------------

        draw_set_font(fnt_dialogo);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);


        var _inicio_y = 151;
        var _espacamento = 35;

        var _quantidade_opcoes =
            array_length(
                opcoes_menu
            );


        for (
            var _i = 0;
            _i < _quantidade_opcoes;
            _i++
        )
        {
            var _y =
                _inicio_y
                + _i
                * _espacamento;


            if (
                _i
                == opcao_selecionada
            )
            {
                // Fundo sutil da opção selecionada
                draw_set_alpha(
                    _pulso_selecao
                    * alpha_opcoes
                );

                draw_set_color(
                    _cor_selecao
                );


                draw_rectangle(
                    15,
                    _y - 12,
                    233,
                    _y + 12,
                    false
                );


                // Marcador
                draw_set_alpha(
                    alpha_opcoes
                );

                draw_set_color(
                    _cor_dourado
                );

                draw_set_font(
                    fnt_minigame
                );

                draw_set_halign(
                    fa_left
                );


                draw_text(
                    18
                    + _movimento_marcador,
                    _y,
                    ">"
                );


                // Texto selecionado
                draw_set_font(
                    fnt_dialogo
                );

                draw_set_halign(
                    fa_center
                );


                draw_text(
                    _painel_centro_x
                    + _movimento_opcao,
                    _y,
                    opcoes_menu[_i]
                );
            }
            else
            {
                draw_set_alpha(
                    alpha_opcoes
                );

                draw_set_color(
                    _cor_dourado_escuro
                );

                draw_set_font(
                    fnt_dialogo
                );

                draw_set_halign(
                    fa_center
                );


                draw_text(
                    _painel_centro_x,
                    _y,
                    opcoes_menu[_i]
                );
            }
        }


        // ------------------------------------------
        // Rodapé
        // ------------------------------------------

        draw_set_font(fnt_minigame);
        draw_set_alpha(alpha_opcoes);

        draw_set_color(
            _cor_texto_secundario
        );

        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);


        draw_text(
            57,
            324,
            "W/S"
        );


        draw_text(
            160,
            324,
            "E"
        );
    }
    break;


    // ==============================================
    // CONTROLES
    // ==============================================

    case MENU_CONTROLES:
    {
        draw_set_alpha(1);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);


        // Título
        draw_set_font(fnt_dialogo);

        draw_set_color(
            _cor_dourado
        );


        draw_text(
            _painel_centro_x,
            58,
            "Controles"
        );


        // Lista
        draw_set_font(fnt_minigame);

        draw_set_color(
            _cor_texto
        );


        draw_text(
            _painel_centro_x,
            145,
            "A / D ou setas  -  Mover"
        );


        draw_text(
            _painel_centro_x,
            181,
            "E  -  Interagir e avançar"
        );


        draw_text(
            _painel_centro_x,
            217,
            "Enter  -  Avançar textos"
        );


        draw_text(
            _painel_centro_x,
            253,
            "Esc  -  Pausar ou voltar"
        );


        // Rodapé
        draw_set_color(
            _cor_texto_secundario
        );


        draw_text(
            _painel_centro_x,
            324,
            "E, Enter ou Esc para voltar"
        );
    }
    break;


    // ==============================================
    // CONFIGURAÇÕES
    // ==============================================

    case MENU_CONFIGURACOES:
    {
        draw_set_alpha(1);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);


        // Título
        draw_set_font(fnt_dialogo);

        draw_set_color(
            _cor_dourado
        );


        draw_text(
            _painel_centro_x,
            58,
            "Configurações"
        );


        // Valores
        var _valor_musica =
            string(
                round(
                    global.volume_musica
                    * 100
                )
            ) + "%";


        var _valor_efeitos =
            string(
                round(
                    global.volume_efeitos
                    * 100
                )
            ) + "%";


        var _valor_tela =
            global.tela_cheia
            ? "Sim"
            : "Não";


        var _linhas =
        [
            "Música       < "
                + _valor_musica
                + " >",

            "Efeitos      < "
                + _valor_efeitos
                + " >",

            "Tela cheia   < "
                + _valor_tela
                + " >",

            "Voltar"
        ];


        draw_set_font(fnt_minigame);


        var _inicio_y = 145;
        var _espacamento = 36;

        var _movimento_marcador =
            round(
                sin(anim_menu) * 2
            );


        for (
            var _i = 0;
            _i < quantidade_configuracoes;
            _i++
        )
        {
            var _y =
                _inicio_y
                + _i
                * _espacamento;


            if (
                _i
                == opcao_configuracao
            )
            {
                draw_set_alpha(0.14);

                draw_set_color(
                    _cor_selecao
                );


                draw_rectangle(
                    15,
                    _y - 11,
                    233,
                    _y + 11,
                    false
                );


                draw_set_alpha(1);

                draw_set_color(
                    _cor_dourado
                );

                draw_set_halign(
                    fa_left
                );


                draw_text(
                    18
                    + _movimento_marcador,
                    _y,
                    ">"
                );
            }
            else
            {
                draw_set_color(
                    _cor_dourado_escuro
                );
            }


            draw_set_halign(
                fa_center
            );


            draw_text(
                _painel_centro_x,
                _y,
                _linhas[_i]
            );
        }


        // Rodapé
        draw_set_color(
            _cor_texto_secundario
        );


        draw_text(
            _painel_centro_x,
            324,
            "A/D ajustar   E confirmar"
        );
    }
    break;
}

#endregion


#region Restaurar desenho

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(fnt_dialogo);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

#endregion