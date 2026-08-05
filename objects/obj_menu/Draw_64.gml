#region Paleta

var _cor_escurecimento =
    make_color_rgb(10, 8, 7);

var _cor_painel =
    make_color_rgb(15, 12, 10);

var _cor_divisor =
    make_color_rgb(81, 60, 42);

var _cor_titulo =
    make_color_rgb(225, 211, 184);

var _cor_texto =
    make_color_rgb(190, 178, 155);

var _cor_texto_secundario =
    make_color_rgb(130, 120, 105);

var _cor_texto_menu =
    make_color_rgb(150, 138, 118);

var _cor_texto_selecionado =
    make_color_rgb(235, 217, 180);

var _cor_selecao =
    make_color_rgb(190, 145, 90);

var _cor_dourado =
    make_color_rgb(205, 162, 104);

var _cor_linha =
    make_color_rgb(125, 94, 65);

#endregion


#region Fundo

draw_set_alpha(alpha_fundo);
draw_set_color(c_white);

draw_sprite(
    spr_menu_fundo,
    0,
    0,
    0
);


draw_set_alpha(0.18);
draw_set_color(_cor_escurecimento);

draw_rectangle(
    0,
    0,
    640,
    360,
    false
);

draw_set_alpha(1);

#endregion


#region Telas

switch (estado_menu)
{
    case MENU_PRINCIPAL:
    {
        var _movimento_logo =
            round(
                sin(anim_menu * 0.45)
            );

        var _movimento_marcador =
            round(
                sin(anim_menu) * 2
            );

        var _movimento_opcao =
            round(
                sin(anim_menu * 0.75)
            );

        var _pulso_selecao =
            0.12
            + (
                sin(anim_menu * 1.25)
                + 1
            ) * 0.025;

        var _brilho_linha =
            0.55
            + (
                sin(anim_menu * 0.65)
                + 1
            ) * 0.10;


        // Painel lateral
        draw_set_alpha(0.63);
        draw_set_color(_cor_painel);

        draw_rectangle(
            0,
            0,
            320,
            360,
            false
        );


        draw_set_alpha(0.65);
        draw_set_color(_cor_divisor);

        draw_rectangle(
            319,
            0,
            320,
            360,
            false
        );


        // Logo
        draw_set_alpha(alpha_logo);
        draw_set_color(c_white);

        draw_sprite(
            spr_logo_pequenas_escolhas,
            0,
            48,
            34 + _movimento_logo
        );


        // Frase
        draw_set_font(fnt_minigame);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);

        draw_set_color(
            make_color_rgb(183, 168, 142)
        );

        draw_text(
            160,
            126,
            "Toda jornada"
        );

        draw_text(
            160,
            142,
            "deixa marcas."
        );


        // Linha decorativa
        draw_set_alpha(
            _brilho_linha * alpha_logo
        );

        draw_set_color(
            make_color_rgb(110, 85, 60)
        );

        draw_rectangle(
            85,
            164,
            235,
            165,
            false
        );


        draw_set_alpha(alpha_logo);

        draw_set_color(
            make_color_rgb(170, 130, 84)
        );

        draw_rectangle(
            153,
            162,
            167,
            167,
            false
        );


        draw_set_color(
            make_color_rgb(38, 29, 22)
        );

        draw_rectangle(
            157,
            163,
            163,
            166,
            false
        );


        // Opções
        draw_set_font(fnt_dialogo);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);

        var _inicio_x = 82;
        var _inicio_y = 186;
        var _espacamento = 30;


        for (
            var _i = 0;
            _i < array_length(opcoes_menu);
            _i++
        )
        {
            var _y =
                _inicio_y
                + _i * _espacamento;


            if (_i == opcao_selecionada)
            {
                draw_set_alpha(
                    _pulso_selecao
                    * alpha_opcoes
                );

                draw_set_color(_cor_selecao);

                draw_rectangle(
                    45,
                    _y - 12,
                    286,
                    _y + 12,
                    false
                );


                draw_set_alpha(alpha_opcoes);
                draw_set_color(_cor_dourado);

                draw_rectangle(
                    45,
                    _y - 12,
                    48,
                    _y + 12,
                    false
                );


                draw_text(
                    54 + _movimento_marcador,
                    _y,
                    ">"
                );


                draw_set_color(
                    _cor_texto_selecionado
                );

                draw_text(
                    _inicio_x + _movimento_opcao,
                    _y,
                    opcoes_menu[_i]
                );
            }
            else
            {
                draw_set_alpha(alpha_opcoes);
                draw_set_color(_cor_texto_menu);

                draw_text(
                    _inicio_x,
                    _y,
                    opcoes_menu[_i]
                );
            }
        }


        // Rodapé
        draw_set_font(fnt_minigame);
        draw_set_alpha(alpha_opcoes);

        draw_set_color(
            make_color_rgb(68, 52, 39)
        );

        draw_rectangle(
            62,
            302,
            258,
            303,
            false
        );


        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);

        draw_set_color(
            make_color_rgb(122, 112, 97)
        );

        draw_text(
            82,
            316,
            "W/S navegar"
        );

        draw_text(
            82,
            338,
            "E confirmar"
        );


        draw_set_color(
            make_color_rgb(145, 108, 71)
        );

        draw_rectangle(
            69,
            315,
            72,
            318,
            false
        );

        draw_rectangle(
            69,
            337,
            72,
            340,
            false
        );
    }
    break;


    case MENU_CONTROLES:
    {
        // Painel
        draw_set_alpha(0.82);
        draw_set_color(_cor_painel);

        draw_rectangle(
            70,
            28,
            570,
            332,
            false
        );

        draw_set_alpha(1);


        // Título
        draw_set_font(fnt_dialogo);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);

        draw_set_color(_cor_titulo);

        draw_text(
            320,
            64,
            "Controles"
        );


        draw_set_color(_cor_linha);

        draw_rectangle(
            250,
            84,
            390,
            85,
            false
        );


        // Lista
        draw_set_font(fnt_minigame);
        draw_set_color(_cor_texto);

        draw_text(
            320,
            124,
            "A / D ou setas  -  Mover"
        );

        draw_text(
            320,
            154,
            "E  -  Interagir e avançar"
        );

        draw_text(
            320,
            184,
            "Enter  -  Avançar textos"
        );

        draw_text(
            320,
            214,
            "Esc  -  Pausar durante o jogo"
        );

        draw_text(
            320,
            244,
            "Esc  -  Voltar nos menus"
        );


        draw_set_color(
            _cor_texto_secundario
        );

        draw_text(
            320,
            312,
            "E, Enter ou Esc para voltar"
        );
    }
    break;


    case MENU_CONFIGURACOES:
    {
        // Painel
        draw_set_alpha(0.82);
        draw_set_color(_cor_painel);

        draw_rectangle(
            70,
            28,
            570,
            332,
            false
        );

        draw_set_alpha(1);


        // Título
        draw_set_font(fnt_dialogo);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);

        draw_set_color(_cor_titulo);

        draw_text(
            320,
            62,
            "Configurações"
        );


        draw_set_color(_cor_linha);

        draw_rectangle(
            228,
            84,
            412,
            85,
            false
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


        var _nomes =
        [
            "Volume da música",
            "Volume dos efeitos",
            "Tela cheia",
            "Voltar"
        ];

        var _valores =
        [
            "<  " + _valor_musica + "  >",
            "<  " + _valor_efeitos + "  >",
            "<  " + _valor_tela + "  >",
            ""
        ];


        draw_set_font(fnt_minigame);
        draw_set_valign(fa_middle);

        var _inicio_y = 128;
        var _espacamento = 42;

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
                + _i * _espacamento;


            if (_i == opcao_configuracao)
            {
                draw_set_color(
                    _cor_texto_selecionado
                );

                draw_set_halign(fa_left);

                draw_text(
                    105 + _movimento_marcador,
                    _y,
                    ">"
                );
            }
            else
            {
                draw_set_color(
                    _cor_texto_menu
                );
            }


            draw_set_halign(fa_left);

            draw_text(
                135,
                _y,
                _nomes[_i]
            );


            draw_set_halign(fa_right);

            draw_text(
                505,
                _y,
                _valores[_i]
            );
        }


        // Rodapé
        draw_set_halign(fa_center);
        draw_set_color(
            _cor_texto_secundario
        );

        draw_text(
            320,
            302,
            "W/S selecionar    A/D ajustar"
        );

        draw_text(
            320,
            323,
            "E confirmar    Esc voltar"
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