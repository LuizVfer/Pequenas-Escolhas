// ==================================================
// FUNDO BASE
// ==================================================

draw_set_alpha(alpha_fundo);
draw_set_color(c_white);

draw_sprite(
    spr_menu_fundo,
    0,
    0,
    0
);

draw_set_alpha(1);


// ==================================================
// ESCURECIMENTO GERAL
// ==================================================

draw_set_alpha(0.18);

draw_set_color(
    make_color_rgb(10, 8, 7)
);

draw_rectangle(
    0,
    0,
    640,
    360,
    false
);

draw_set_alpha(1);


// ==================================================
// MENU PRINCIPAL
// ==================================================

if (estado_menu == 0)
{
    // ==============================================
    // VALORES DAS ANIMAÇÕES
    // ==============================================

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


    // ==============================================
    // PAINEL ESCURO DO LADO ESQUERDO
    // ==============================================

    draw_set_alpha(0.63);

    draw_set_color(
        make_color_rgb(15, 12, 10)
    );

    draw_rectangle(
        0,
        0,
        320,
        360,
        false
    );


    // Leve divisão entre painel e cenário
    draw_set_alpha(0.65);

    draw_set_color(
        make_color_rgb(81, 60, 42)
    );

    draw_rectangle(
        319,
        0,
        320,
        360,
        false
    );

    draw_set_alpha(1);


    // ==============================================
    // LOGO
    // ==============================================

    draw_set_alpha(alpha_logo);
    draw_set_color(c_white);

    draw_sprite(
        spr_logo_pequenas_escolhas,
        0,
        48,
        34 + _movimento_logo
    );


    // ==============================================
    // FRASE TEMÁTICA
    // ==============================================

    draw_set_font(fnt_dialogo);
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
        146,
        "deixa marcas."
    );


    // ==============================================
    // LINHA DECORATIVA ANIMADA
    // ==============================================

    draw_set_alpha(
        _brilho_linha
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


    // Detalhe central
    draw_set_alpha(1);

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


    // ==============================================
    // OPÇÕES
    // ==============================================

    draw_set_alpha(alpha_opcoes);
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
            // ======================================
            // FUNDO SUAVE DA OPÇÃO SELECIONADA
            // ======================================

            draw_set_alpha(
                _pulso_selecao
                * alpha_opcoes
            );

            draw_set_color(
                make_color_rgb(190, 145, 90)
            );

            draw_rectangle(
                45,
                _y - 12,
                286,
                _y + 12,
                false
            );


            // Linha lateral dourada
            draw_set_alpha(alpha_opcoes);

            draw_set_color(
                make_color_rgb(205, 162, 104)
            );

            draw_rectangle(
                45,
                _y - 12,
                48,
                _y + 12,
                false
            );


            // Marcador animado
            draw_set_halign(fa_left);

            draw_text(
                54 + _movimento_marcador,
                _y,
                ">"
            );


            // Texto selecionado
            draw_set_color(
                make_color_rgb(235, 217, 180)
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

            draw_set_color(
                make_color_rgb(150, 138, 118)
            );

            draw_text(
                _inicio_x,
                _y,
                opcoes_menu[_i]
            );
        }
    }


    // ==============================================
    // RODAPÉ
    // ==============================================

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


    // Pequenos símbolos no rodapé
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


    draw_set_alpha(1);
}


// ==================================================
// TELA DE CONTROLES
// ==================================================

else if (estado_menu == 1)
{
    // ==============================================
    // PAINEL CENTRAL
    // ==============================================

    draw_set_alpha(0.82);

    draw_set_color(
        make_color_rgb(15, 12, 10)
    );

    draw_rectangle(
        70,
        28,
        570,
        332,
        false
    );

    draw_set_alpha(1);


    draw_set_font(fnt_dialogo);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);


    // ==============================================
    // TÍTULO
    // ==============================================

    draw_set_color(
        make_color_rgb(225, 211, 184)
    );

    draw_text(
        320,
        64,
        "Controles"
    );


    // Linha decorativa
    draw_set_color(
        make_color_rgb(125, 94, 65)
    );

    draw_rectangle(
        250,
        84,
        390,
        85,
        false
    );


    // ==============================================
    // LISTA DE CONTROLES
    // ==============================================

    draw_set_color(
        make_color_rgb(190, 178, 155)
    );

    draw_text(
        320,
        130,
        "A / D ou setas  -  Mover"
    );

    draw_text(
        320,
        168,
        "E  -  Interagir e avançar"
    );

    draw_text(
        320,
        206,
        "Enter  -  Avançar textos"
    );

    draw_text(
        320,
        244,
        "Esc  -  Voltar ou abrir o menu"
    );


    // ==============================================
    // INSTRUÇÃO PARA VOLTAR
    // ==============================================

    draw_set_color(
        make_color_rgb(130, 120, 105)
    );

    draw_text(
        320,
        312,
        "Pressione E, Enter ou Esc para voltar"
    );
}


// ==================================================
// TELA DE CONFIGURAÇÕES
// ==================================================

else if (estado_menu == 2)
{
    // ==============================================
    // PAINEL CENTRAL
    // ==============================================

    draw_set_alpha(0.82);

    draw_set_color(
        make_color_rgb(15, 12, 10)
    );

    draw_rectangle(
        70,
        28,
        570,
        332,
        false
    );

    draw_set_alpha(1);


    draw_set_font(fnt_dialogo);
    draw_set_valign(fa_middle);


    // ==============================================
    // TÍTULO
    // ==============================================

    draw_set_halign(fa_center);

    draw_set_color(
        make_color_rgb(225, 211, 184)
    );

    draw_text(
        320,
        62,
        "Configurações"
    );


    draw_set_color(
        make_color_rgb(125, 94, 65)
    );

    draw_rectangle(
        228,
        84,
        412,
        85,
        false
    );


    // ==============================================
    // VALORES FORMATADOS
    // ==============================================

    var _valor_musica =
        string(
            round(global.volume_musica * 100)
        )
        + "%";

    var _valor_efeitos =
        string(
            round(global.volume_efeitos * 100)
        )
        + "%";

    var _valor_tela = "Não";

    if (global.tela_cheia)
    {
        _valor_tela = "Sim";
    }


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


    // ==============================================
    // DESENHAR OPÇÕES
    // ==============================================

    var _inicio_y = 128;
    var _espacamento = 42;

    var _marcador_anim =
        round(sin(anim_menu) * 2);


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
                make_color_rgb(235, 217, 180)
            );

            draw_set_halign(fa_left);

            draw_text(
                105 + _marcador_anim,
                _y,
                ">"
            );
        }
        else
        {
            draw_set_color(
                make_color_rgb(150, 138, 118)
            );
        }


        // Nome da configuração
        draw_set_halign(fa_left);

        draw_text(
            135,
            _y,
            _nomes[_i]
        );


        // Valor
        draw_set_halign(fa_right);

        draw_text(
            505,
            _y,
            _valores[_i]
        );
    }


    // ==============================================
    // INSTRUÇÕES
    // ==============================================

    draw_set_halign(fa_center);

    draw_set_color(
        make_color_rgb(125, 115, 100)
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


// ==================================================
// RESTAURA CONFIGURAÇÕES
// ==================================================

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);