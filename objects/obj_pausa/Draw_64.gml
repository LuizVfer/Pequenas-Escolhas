if (!pausa_ativa)
{
    exit;
}


// ==================================================
// ANIMAÇÃO DE ENTRADA
// ==================================================

var _ease =
    1 - power(1 - anim_entrada, 3);

var _alpha_ui = _ease;

var _offset_y =
    round(
        12 * (1 - _ease)
    );


// ==================================================
// TAMANHO DA GUI
// ==================================================

var _gui_largura =
    display_get_gui_width();

var _gui_altura =
    display_get_gui_height();


// ==================================================
// CAPÍTULO ATUAL
// ==================================================

var _texto_capitulo = "A jornada continua";

switch (room)
{
    case rm_cidade:
        _texto_capitulo =
            "Capítulo I - Cidade";
    break;

    case rm_floresta:
        _texto_capitulo =
            "Capítulo II - Floresta";
    break;

    case rm_vila:
        _texto_capitulo =
            "Capítulo III - Vila";
    break;

    case rm_destino:
        _texto_capitulo =
            "Capítulo IV - Destino";
    break;
}


// ==================================================
// ESCURECIMENTO DO JOGO
// ==================================================

draw_set_alpha(
    0.72 * _alpha_ui
);

draw_set_color(c_black);

draw_rectangle(
    0,
    0,
    _gui_largura,
    _gui_altura,
    false
);


// Escurecimento adicional nas laterais
draw_set_alpha(
    0.20 * _alpha_ui
);

draw_rectangle(
    0,
    0,
    82,
    _gui_altura,
    false
);

draw_rectangle(
    _gui_largura - 82,
    0,
    _gui_largura,
    _gui_altura,
    false
);

draw_set_alpha(_alpha_ui);


// ==================================================
// POSIÇÃO DO PAINEL
// ==================================================

var _painel_x1 = 98;
var _painel_y1 = 22 + _offset_y;

var _painel_x2 = 542;
var _painel_y2 = 338 + _offset_y;


// ==================================================
// SOMBRA DO PAINEL
// ==================================================

draw_set_alpha(
    0.55 * _alpha_ui
);

draw_set_color(c_black);

draw_rectangle(
    _painel_x1 + 7,
    _painel_y1 + 7,
    _painel_x2 + 7,
    _painel_y2 + 7,
    false
);


// ==================================================
// FUNDO DO PAINEL
// ==================================================

draw_set_alpha(_alpha_ui);

draw_set_color(
    make_color_rgb(18, 14, 12)
);

draw_rectangle(
    _painel_x1,
    _painel_y1,
    _painel_x2,
    _painel_y2,
    false
);


// Faixa superior
draw_set_color(
    make_color_rgb(29, 22, 17)
);

draw_rectangle(
    _painel_x1 + 2,
    _painel_y1 + 2,
    _painel_x2 - 2,
    _painel_y1 + 73,
    false
);


// ==================================================
// BORDAS
// ==================================================

// Borda externa
draw_set_color(
    make_color_rgb(128, 96, 65)
);

draw_rectangle(
    _painel_x1,
    _painel_y1,
    _painel_x2,
    _painel_y2,
    true
);


// Borda intermediária
draw_set_color(
    make_color_rgb(73, 54, 39)
);

draw_rectangle(
    _painel_x1 + 4,
    _painel_y1 + 4,
    _painel_x2 - 4,
    _painel_y2 - 4,
    true
);


// Borda interna
draw_set_color(
    make_color_rgb(44, 33, 25)
);

draw_rectangle(
    _painel_x1 + 8,
    _painel_y1 + 8,
    _painel_x2 - 8,
    _painel_y2 - 8,
    true
);


// ==================================================
// DETALHES DECORATIVOS DOS CANTOS
// ==================================================

draw_set_color(
    make_color_rgb(154, 117, 76)
);


// Canto superior esquerdo
draw_rectangle(
    _painel_x1,
    _painel_y1,
    _painel_x1 + 28,
    _painel_y1 + 2,
    false
);

draw_rectangle(
    _painel_x1,
    _painel_y1,
    _painel_x1 + 2,
    _painel_y1 + 28,
    false
);


// Canto superior direito
draw_rectangle(
    _painel_x2 - 28,
    _painel_y1,
    _painel_x2,
    _painel_y1 + 2,
    false
);

draw_rectangle(
    _painel_x2 - 2,
    _painel_y1,
    _painel_x2,
    _painel_y1 + 28,
    false
);


// Canto inferior esquerdo
draw_rectangle(
    _painel_x1,
    _painel_y2 - 2,
    _painel_x1 + 28,
    _painel_y2,
    false
);

draw_rectangle(
    _painel_x1,
    _painel_y2 - 28,
    _painel_x1 + 2,
    _painel_y2,
    false
);


// Canto inferior direito
draw_rectangle(
    _painel_x2 - 28,
    _painel_y2 - 2,
    _painel_x2,
    _painel_y2,
    false
);

draw_rectangle(
    _painel_x2 - 2,
    _painel_y2 - 28,
    _painel_x2,
    _painel_y2,
    false
);


// ==================================================
// CONFIGURAÇÃO DE TEXTO
// ==================================================

draw_set_font(fnt_dialogo);
draw_set_valign(fa_middle);


// ==================================================
// MENU PRINCIPAL
// ==================================================

if (estado_pausa == 0)
{
    // ==============================================
    // TÍTULO
    // ==============================================

    draw_set_halign(fa_center);

    draw_set_color(
        make_color_rgb(238, 220, 184)
    );

    draw_text(
        320,
        48 + _offset_y,
        "Jogo pausado"
    );


    draw_set_color(
        make_color_rgb(151, 135, 108)
    );

    draw_text(
        320,
        69 + _offset_y,
        _texto_capitulo
    );


    // Linha decorativa
    draw_set_color(
        make_color_rgb(116, 86, 57)
    );

    draw_rectangle(
        224,
        88 + _offset_y,
        416,
        89 + _offset_y,
        false
    );


    draw_set_color(
        make_color_rgb(176, 135, 88)
    );

    draw_rectangle(
        304,
        86 + _offset_y,
        336,
        91 + _offset_y,
        false
    );


    // ==============================================
    // OPÇÕES
    // ==============================================

    var _inicio_y = 125 + _offset_y;
    var _espacamento = 39;

    var _pulso =
        sin(anim_destaque) * 0.025;


    for (
        var _i = 0;
        _i < array_length(opcoes_pausa);
        _i++
    )
    {
        var _y =
            _inicio_y
            + _i * _espacamento;


        if (_i == opcao_selecionada)
        {
            // Fundo da opção selecionada
            draw_set_alpha(
                (0.20 + _pulso)
                * _alpha_ui
            );

            draw_set_color(
                make_color_rgb(177, 133, 84)
            );

            draw_rectangle(
                143,
                _y - 14,
                497,
                _y + 14,
                false
            );


            // Linha lateral
            draw_set_alpha(_alpha_ui);

            draw_set_color(
                make_color_rgb(218, 176, 112)
            );

            draw_rectangle(
                143,
                _y - 14,
                147,
                _y + 14,
                false
            );


            // Marcador
            draw_set_halign(fa_center);

            draw_text(
                171,
                _y,
                ">"
            );


            draw_set_color(
                make_color_rgb(239, 221, 184)
            );
        }
        else
        {
            draw_set_alpha(_alpha_ui);

            draw_set_color(
                make_color_rgb(151, 139, 119)
            );
        }


        draw_set_halign(fa_left);

        draw_text(
            200,
            _y,
            opcoes_pausa[_i]
        );
    }


    // ==============================================
    // RODAPÉ
    // ==============================================

    draw_set_alpha(_alpha_ui);

    draw_set_color(
        make_color_rgb(65, 49, 36)
    );

    draw_rectangle(
        130,
        285 + _offset_y,
        510,
        286 + _offset_y,
        false
    );


    draw_set_halign(fa_center);

    draw_set_color(
        make_color_rgb(133, 121, 104)
    );

    draw_text(
        320,
        300 + _offset_y,
        "W / S  Navegar     E  Confirmar"
    );

    draw_set_color(
        make_color_rgb(101, 91, 79)
    );

    draw_text(
        320,
        317 + _offset_y,
        "Esc  Continuar jornada"
    );
}


// ==================================================
// TELA DE CONTROLES
// ==================================================

else if (estado_pausa == 1)
{
    draw_set_halign(fa_center);

    draw_set_color(
        make_color_rgb(238, 220, 184)
    );

    draw_text(
        320,
        50 + _offset_y,
        "Controles"
    );


    draw_set_color(
        make_color_rgb(151, 135, 108)
    );

    draw_text(
        320,
        70 + _offset_y,
        "Comandos da jornada"
    );


    draw_set_color(
        make_color_rgb(116, 86, 57)
    );

    draw_rectangle(
        224,
        88 + _offset_y,
        416,
        89 + _offset_y,
        false
    );


    // ==============================================
    // LINHAS DOS CONTROLES
    // ==============================================

    var _nomes_controles =
    [
        "Mover",
        "Interagir",
        "Avançar textos",
        "Pausar ou voltar"
    ];

    var _teclas_controles =
    [
        "A / D ou setas",
        "E",
        "E ou Enter",
        "Esc"
    ];

    var _inicio_controle =
        125 + _offset_y;


    for (
        var _i = 0;
        _i < array_length(_nomes_controles);
        _i++
    )
    {
        var _y =
            _inicio_controle
            + _i * 38;


        if ((_i mod 2) == 0)
        {
            draw_set_alpha(
                0.10 * _alpha_ui
            );

            draw_set_color(
                make_color_rgb(180, 140, 90)
            );

            draw_rectangle(
                136,
                _y - 14,
                504,
                _y + 14,
                false
            );
        }


        draw_set_alpha(_alpha_ui);

        draw_set_halign(fa_left);

        draw_set_color(
            make_color_rgb(190, 178, 155)
        );

        draw_text(
            158,
            _y,
            _nomes_controles[_i]
        );


        draw_set_halign(fa_right);

        draw_set_color(
            make_color_rgb(231, 211, 174)
        );

        draw_text(
            482,
            _y,
            _teclas_controles[_i]
        );
    }


    // Rodapé
    draw_set_color(
        make_color_rgb(65, 49, 36)
    );

    draw_rectangle(
        130,
        284 + _offset_y,
        510,
        285 + _offset_y,
        false
    );


    draw_set_halign(fa_center);

    draw_set_color(
        make_color_rgb(133, 121, 104)
    );

    draw_text(
        320,
        313 + _offset_y,
        "E, Enter ou Esc para voltar"
    );
}


// ==================================================
// CONFIGURAÇÕES
// ==================================================

else if (estado_pausa == 2)
{
    draw_set_halign(fa_center);

    draw_set_color(
        make_color_rgb(238, 220, 184)
    );

    draw_text(
        320,
        50 + _offset_y,
        "Configurações"
    );


    draw_set_color(
        make_color_rgb(151, 135, 108)
    );

    draw_text(
        320,
        70 + _offset_y,
        "Som e exibição"
    );


    draw_set_color(
        make_color_rgb(116, 86, 57)
    );

    draw_rectangle(
        224,
        88 + _offset_y,
        416,
        89 + _offset_y,
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
    // DESENHAR CONFIGURAÇÕES
    // ==============================================

    var _inicio_y = 125 + _offset_y;
    var _espacamento = 39;

    var _pulso =
        sin(anim_destaque) * 0.025;


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
            draw_set_alpha(
                (0.20 + _pulso)
                * _alpha_ui
            );

            draw_set_color(
                make_color_rgb(177, 133, 84)
            );

            draw_rectangle(
                132,
                _y - 14,
                508,
                _y + 14,
                false
            );


            draw_set_alpha(_alpha_ui);

            draw_set_color(
                make_color_rgb(218, 176, 112)
            );

            draw_rectangle(
                132,
                _y - 14,
                136,
                _y + 14,
                false
            );


            draw_set_halign(fa_center);

            draw_text(
                157,
                _y,
                ">"
            );


            draw_set_color(
                make_color_rgb(239, 221, 184)
            );
        }
        else
        {
            draw_set_alpha(_alpha_ui);

            draw_set_color(
                make_color_rgb(151, 139, 119)
            );
        }


        draw_set_halign(fa_left);

        draw_text(
            180,
            _y,
            _nomes[_i]
        );


        draw_set_halign(fa_right);

        draw_text(
            485,
            _y,
            _valores[_i]
        );
    }


    // ==============================================
    // RODAPÉ
    // ==============================================

    draw_set_color(
        make_color_rgb(65, 49, 36)
    );
    
    draw_rectangle(
        130,
        284 + _offset_y,
        510,
        285 + _offset_y,
        false
    );
    
    draw_set_halign(fa_center);
    
    draw_set_color(
        make_color_rgb(133, 121, 104)
    );
    
    draw_text(
        320,
        300 + _offset_y,
        "W / S  Navegar     E  Confirmar"
    );
    
    draw_set_color(
        make_color_rgb(101, 91, 79)
    );
    
    draw_text(
        320,
        317 + _offset_y,
        "Esc  Continuar jornada"
    );
}


// ==================================================
// RESTAURA O DRAW
// ==================================================

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);