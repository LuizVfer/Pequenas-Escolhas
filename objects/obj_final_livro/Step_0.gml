// O livro final mantém o gameplay bloqueado
global.controle_bloqueado = true;


// ==================================================
// LIVRO FECHADO NO INÍCIO
// ==================================================

if (
    estado_final
    == ESTADO_LIVRO_FECHADO_INICIO
)
{
    if (fade_ativo())
    {
        exit;
    }


    contador++;


    if (
        contador >= tempo_livro_fechado
        && !abertura_iniciada
    )
    {
        var _abrir_livro = method(
            id,

            function()
            {
                if (som_livro_abrindo != noone)
                {
                    abaixar_musica_final(
                        70,
                        0.15
                    );


                    var _som_abrindo =
                        audio_play_sound(
                            som_livro_abrindo,
                            2,
                            false
                        );


                    if (_som_abrindo != -1)
                    {
                        audio_sound_gain(
                            _som_abrindo,
                            1,
                            0
                        );
                    }
                }


                estado_final =
                    ESTADO_CONSEQUENCIAS;

                contador = 0;

                configurar_consequencia_pedra();
            }
        );


        var _fade_abertura_iniciado =
            iniciar_fade_final(
                _abrir_livro,
                0.03,
                60
            );


        abertura_iniciada =
            _fade_abertura_iniciado;
    }


    exit;
}


// ==================================================
// CONSEQUÊNCIAS
// ==================================================

if (
    estado_final
    == ESTADO_CONSEQUENCIAS
)
{
    if (fade_ativo())
    {
        parar_som_lapis();
        exit;
    }


    var _quantidade_consequencia =
        array_length(
            frases_consequencia
        );


    if (_quantidade_consequencia <= 0)
    {
        parar_som_lapis();

        show_debug_message(
            "ERRO: consequência sem frases."
        );

        exit;
    }


    frase_atual =
        clamp(
            frase_atual,
            0,
            _quantidade_consequencia - 1
        );


    var _frase_consequencia =
        string(
            frases_consequencia[
                frase_atual
            ]
        );

    var _tamanho_consequencia =
        string_length(
            _frase_consequencia
        );


    // ----------------------------------------------
    // Máquina de escrever
    // ----------------------------------------------

    if (
        caracteres_visiveis
        < _tamanho_consequencia
    )
    {
        iniciar_som_lapis();


        caracteres_visiveis =
            min(
                caracteres_visiveis
                    + velocidade_frase,

                _tamanho_consequencia
            );


        if (
            caracteres_visiveis
            >= _tamanho_consequencia
        )
        {
            parar_som_lapis();
        }
    }
    else
    {
        parar_som_lapis();
    }


    var _confirmar_consequencia =
        keyboard_check_pressed(
            ord("E")
        )
        || keyboard_check_pressed(
            vk_enter
        );


    if (!_confirmar_consequencia)
    {
        exit;
    }


    // Completa a frase atual
    if (
        caracteres_visiveis
        < _tamanho_consequencia
    )
    {
        caracteres_visiveis =
            _tamanho_consequencia;

        parar_som_lapis();

        exit;
    }


    // Avança para a próxima frase
    if (
        frase_atual
        < _quantidade_consequencia - 1
    )
    {
        frase_atual++;
        caracteres_visiveis = 0;

        exit;
    }


    if (transicao_consequencia_iniciada)
    {
        exit;
    }


    // ----------------------------------------------
    // Próxima consequência
    // ----------------------------------------------

    if (consequencia_atual < 3)
    {
        var _mostrar_proxima = method(
            id,

            function()
            {
                tocar_som_pagina();


                switch (consequencia_atual)
                {
                    case 0:
                        configurar_consequencia_cachorro();
                    break;


                    case 1:
                        configurar_consequencia_sementes();
                    break;


                    case 2:
                        configurar_consequencia_brinquedo();
                    break;


                    default:
                        show_debug_message(
                            "ERRO: consequência atual inválida."
                        );
                    break;
                }
            }
        );


        var _fade_proxima_iniciado =
            iniciar_fade_final(
                _mostrar_proxima,
                0.03,
                45
            );


        transicao_consequencia_iniciada =
            _fade_proxima_iniciado;


        exit;
    }


    // ----------------------------------------------
    // Fechar o livro
    // ----------------------------------------------

    var _fechar_livro = method(
        id,

        function()
        {
            consequencia_concluida = true;

            parar_som_lapis();


            if (som_livro_fechando != noone)
            {
                abaixar_musica_final(
                    75,
                    0.15
                );


                var _som_fechando =
                    audio_play_sound(
                        som_livro_fechando,
                        2,
                        false
                    );


                if (_som_fechando != -1)
                {
                    audio_sound_gain(
                        _som_fechando,
                        1,
                        0
                    );

                    audio_sound_pitch(
                        _som_fechando,
                        0.85
                    );
                }
            }


            estado_final =
                ESTADO_LIVRO_FECHADO_FINAL;

            contador = 0;

            transicao_mensagem_iniciada =
                false;
        }
    );


    var _fade_fechamento_iniciado =
        iniciar_fade_final(
            _fechar_livro,
            0.03,
            60
        );


    transicao_consequencia_iniciada =
        _fade_fechamento_iniciado;


    exit;
}


// ==================================================
// LIVRO FECHADO NO ENCERRAMENTO
// ==================================================

if (
    estado_final
    == ESTADO_LIVRO_FECHADO_FINAL
)
{
    if (fade_ativo())
    {
        exit;
    }


    contador++;


    if (
        contador
            >= tempo_livro_fechado_final

        && !transicao_mensagem_iniciada
    )
    {
        var _mostrar_mensagem_final =
            method(
                id,

                function()
                {
                    estado_final =
                        ESTADO_MENSAGEM_FINAL;

                    frase_final_atual = 0;

                    caracteres_finais_visiveis =
                        0;

                    mensagem_final_concluida =
                        false;

                    transicao_creditos_iniciada =
                        false;
                }
            );


        var _fade_mensagem_iniciado =
            iniciar_fade_final(
                _mostrar_mensagem_final,
                0.03,
                45
            );


        transicao_mensagem_iniciada =
            _fade_mensagem_iniciado;
    }


    exit;
}


// ==================================================
// MENSAGEM FINAL
// ==================================================

if (
    estado_final
    == ESTADO_MENSAGEM_FINAL
)
{
    if (fade_ativo())
    {
        parar_som_lapis();
        exit;
    }


    if (
        mensagem_final_concluida
        || transicao_creditos_iniciada
    )
    {
        parar_som_lapis();
        exit;
    }


    var _quantidade_finais =
        array_length(
            frases_finais
        );


    if (_quantidade_finais <= 0)
    {
        parar_som_lapis();

        show_debug_message(
            "ERRO: mensagem final sem frases."
        );

        exit;
    }


    frase_final_atual =
        clamp(
            frase_final_atual,
            0,
            _quantidade_finais - 1
        );


    var _frase_final =
        string(
            frases_finais[
                frase_final_atual
            ]
        );

    var _tamanho_final =
        string_length(
            _frase_final
        );


    // ----------------------------------------------
    // Máquina de escrever
    // ----------------------------------------------

    if (
        caracteres_finais_visiveis
        < _tamanho_final
    )
    {
        iniciar_som_lapis();


        caracteres_finais_visiveis =
            min(
                caracteres_finais_visiveis
                    + velocidade_mensagem_final,

                _tamanho_final
            );


        if (
            caracteres_finais_visiveis
            >= _tamanho_final
        )
        {
            parar_som_lapis();
        }
    }
    else
    {
        parar_som_lapis();
    }


    var _confirmar_mensagem =
        keyboard_check_pressed(
            ord("E")
        )
        || keyboard_check_pressed(
            vk_enter
        );


    if (!_confirmar_mensagem)
    {
        exit;
    }


    // Completa a frase atual
    if (
        caracteres_finais_visiveis
        < _tamanho_final
    )
    {
        caracteres_finais_visiveis =
            _tamanho_final;

        parar_som_lapis();

        exit;
    }


    // Avança para a próxima frase
    if (
        frase_final_atual
        < _quantidade_finais - 1
    )
    {
        frase_final_atual++;
        caracteres_finais_visiveis = 0;

        exit;
    }


    // ----------------------------------------------
    // Mostrar créditos
    // ----------------------------------------------

    var _mostrar_creditos = method(
        id,

        function()
        {
            mensagem_final_concluida =
                true;

            estado_final =
                ESTADO_CREDITOS;

            contador_creditos = 0;

            alpha_titulo_final = 0;
            alpha_creditos = 0;

            final_completo = false;
            retorno_menu_iniciado = false;
        }
    );


    var _fade_creditos_iniciado =
        iniciar_fade_final(
            _mostrar_creditos,
            0.03,
            60
        );


    transicao_creditos_iniciada =
        _fade_creditos_iniciado;


    exit;
}


// ==================================================
// TÍTULO E CRÉDITOS
// ==================================================

if (
    estado_final
    == ESTADO_CREDITOS
)
{
    if (fade_ativo())
    {
        exit;
    }


    contador_creditos++;


    // Título aparece primeiro
    alpha_titulo_final =
        min(
            alpha_titulo_final
                + velocidade_alpha_titulo,

            1
        );


    // Créditos aparecem depois
    if (
        contador_creditos
        >= tempo_antes_creditos
    )
    {
        alpha_creditos =
            min(
                alpha_creditos
                    + velocidade_alpha_creditos,

                1
            );
    }


    // Final completamente visível
    if (
        alpha_titulo_final >= 1
        && alpha_creditos >= 1
        && !final_completo
    )
    {
        final_completo = true;

        global.jogo_concluido = true;
    }


    var _confirmar_creditos =
        keyboard_check_pressed(
            ord("E")
        )
        || keyboard_check_pressed(
            vk_enter
        );


    if (
        final_completo
        && _confirmar_creditos
        && !retorno_menu_iniciado
    )
    {
        var _voltar_ao_menu = method(
            id,

            function()
            {
                parar_som_lapis();

                global.controle_bloqueado =
                    true;

                // O progresso será resetado somente
                // ao selecionar "Jogar novamente"
                room_goto(rm_menu);
            }
        );


        var _fade_menu_iniciado =
            iniciar_fade_final(
                _voltar_ao_menu,
                0.03,
                45
            );


        retorno_menu_iniciado =
            _fade_menu_iniciado;
    }


    exit;
}


// ==================================================
// PROTEÇÃO CONTRA ESTADO INVÁLIDO
// ==================================================

show_debug_message(
    "ERRO: estado inválido no livro final."
);

parar_som_lapis();

estado_final =
    ESTADO_LIVRO_FECHADO_INICIO;

contador = 0;

abertura_iniciada = false;

transicao_consequencia_iniciada = false;
transicao_mensagem_iniciada = false;
transicao_creditos_iniciada = false;

retorno_menu_iniciado = false;