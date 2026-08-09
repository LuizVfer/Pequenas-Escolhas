#region Segurança

if (global.ponte_abaixada)
{
    estado_mecanismo = MECANISMO_CONCLUIDO;
    pode_interagir = false;

    exit;
}

#endregion


// Movimento visual da interface
anim_puzzle += 0.08;


#region Estados

switch (estado_mecanismo)
{
    // ==================================================
    // MECANISMO DISPONÍVEL
    // ==================================================

    case MECANISMO_PARADO:
    {
        pode_interagir =
            global.ponte_descoberta
            && !global.ponte_abaixada
            && !transicao_iniciada;
    }
    break;


    // ==================================================
    // AGUARDAR O DIÁLOGO INICIAL
    // ==================================================

    case MECANISMO_DIALOGO:
    {
        pode_interagir = false;

        // Abre o puzzle depois que o diálogo terminar
        if (!global.controle_bloqueado)
        {
            abrir_puzzle();
        }
    }
    break;


    // ==================================================
    // PUZZLE DAS RODAS
    // ==================================================

    case MECANISMO_PUZZLE:
    {
        global.controle_bloqueado = true;
        pode_interagir = false;


        var _esquerda =
            keyboard_check_pressed(vk_left)
            || keyboard_check_pressed(ord("A"));

        var _direita =
            keyboard_check_pressed(vk_right)
            || keyboard_check_pressed(ord("D"));

        var _girar =
            keyboard_check_pressed(ord("E"))
            || keyboard_check_pressed(vk_enter);

        var _sair =
            keyboard_check_pressed(vk_escape);


        // Sair possui prioridade sobre os outros comandos
        if (_sair)
        {
            var _som_sair = audio_play_sound(
                snd_opcao_confirmar,
                1,
                false
            );

            audio_sound_gain(
                _som_sair,
                0.40,
                0
            );

            fechar_puzzle();
        }
        else
        {
            // ------------------------------------------
            // SELECIONAR A RODA ANTERIOR
            // ------------------------------------------

            if (_esquerda)
            {
                roda_selecionada--;

                if (roda_selecionada < 0)
                {
                    roda_selecionada =
                        quantidade_rodas - 1;
                }

                var _som_esquerda =
                    audio_play_sound(
                        snd_opcao_mover,
                        0,
                        false
                    );

                audio_sound_gain(
                    _som_esquerda,
                    0.35,
                    0
                );
            }


            // ------------------------------------------
            // SELECIONAR A PRÓXIMA RODA
            // ------------------------------------------

            else if (_direita)
            {
                roda_selecionada++;

                if (
                    roda_selecionada
                    >= quantidade_rodas
                )
                {
                    roda_selecionada = 0;
                }

                var _som_direita =
                    audio_play_sound(
                        snd_opcao_mover,
                        0,
                        false
                    );

                audio_sound_gain(
                    _som_direita,
                    0.35,
                    0
                );
            }


            // ------------------------------------------
            // GIRAR A RODA SELECIONADA
            // ------------------------------------------

            if (_girar)
            {
                girar_roda(roda_selecionada);

                var _som_girar =
                    audio_play_sound(
                        snd_opcao_confirmar,
                        1,
                        false
                    );

                audio_sound_gain(
                    _som_girar,
                    0.50,
                    0
                );


                if (puzzle_resolvido())
                {
                    estado_mecanismo =
                        MECANISMO_CONCLUIDO;

                    contador_conclusao =
                        espera_conclusao;

                    transicao_iniciada = false;
                }
            }
        }
    }
    break;


    // ==================================================
    // MOSTRAR A SOLUÇÃO ANTES DO FADE
    // ==================================================

    case MECANISMO_CONCLUIDO:
    {
        global.controle_bloqueado = true;
        pode_interagir = false;

        contador_conclusao =
            max(0, contador_conclusao - 1);


        if (
            contador_conclusao <= 0
            && !transicao_iniciada
        )
        {
            var _abaixar_ponte = method(
                id,

                function()
                {
                    global.ponte_abaixada = true;


                    // Troca a ponte durante a tela preta
                    with (obj_ponte)
                    {
                        sprite_index =
                            spr_ponte_abaixada;

                        image_index = 0;
                        image_speed = 0;

                        pode_interagir = false;
                    }


                    // Libera a passagem
                    with (obj_bloqueio_ponte)
                    {
                        instance_destroy();
                    }


                    // Abaixa a música para destacar o efeito
                    if (
                        instance_exists(
                            global.game_instancia
                        )
                    )
                    {
                        global.game_instancia
                            .abaixar_musica_para_efeito(
                                90,
                                0.30
                            );
                    }


                    var _som_ponte =
                        audio_play_sound(
                            som_ponte,
                            2,
                            false
                        );

                    audio_sound_gain(
                        _som_ponte,
                        1,
                        0
                    );
                    
                    // Impacto da ponte ao abaixar
                    with (obj_camera)
                    {
                        tremer(2, 18);
                    }
                    

                    estado_mecanismo =
                        MECANISMO_CONCLUIDO;

                    transicao_iniciada = false;
                    pode_interagir = false;

                    // O obj_fade devolverá o controle
                    // quando a transição terminar
                }
            );


            var _fade_iniciado =
                global.fade_instancia.iniciar(
                    _abaixar_ponte,
                    0.04,
                    45
                );


            // Só muda de estado se o fade começar
            if (_fade_iniciado)
            {
                transicao_iniciada = true;
                estado_mecanismo = MECANISMO_FADE;
            }
        }
    }
    break;


    // ==================================================
    // AGUARDAR O FADE
    // ==================================================

    case MECANISMO_FADE:
    {
        global.controle_bloqueado = true;
        pode_interagir = false;
    }
    break;
}

#endregion