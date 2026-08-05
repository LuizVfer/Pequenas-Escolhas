
#region Segurança

if (global.ponte_abaixada)
{
    estado_mecanismo =
        MECANISMO_CONCLUIDO;

    pode_interagir = false;
    exit;
}

#endregion


anim_puzzle += 0.08;


#region Estados

switch (estado_mecanismo)
{
    // --------------------------------------------------
    // Mecanismo disponível
    // --------------------------------------------------

    case MECANISMO_PARADO:
    {
        pode_interagir =
            global.ponte_descoberta
            && !global.ponte_abaixada;
    }
    break;


    // --------------------------------------------------
    // Aguarda o diálogo terminar
    // --------------------------------------------------

    case MECANISMO_DIALOGO:
    {
        pode_interagir = false;


        if (!global.controle_bloqueado)
        {
            abrir_puzzle();
        }
    }
    break;


    // --------------------------------------------------
    // Puzzle das rodas
    // --------------------------------------------------

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


        // Selecionar roda
        if (_esquerda)
        {
            roda_selecionada--;

            if (roda_selecionada < 0)
            {
                roda_selecionada =
                    quantidade_rodas - 1;
            }


            var _som = audio_play_sound(
                snd_opcao_mover,
                0,
                false
            );

            audio_sound_gain(
                _som,
                0.35,
                0
            );
        }
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


            var _som = audio_play_sound(
                snd_opcao_mover,
                0,
                false
            );

            audio_sound_gain(
                _som,
                0.35,
                0
            );
        }


        // Girar a roda selecionada
        if (_girar)
        {
            girar_roda(
                roda_selecionada
            );


            var _som_girar = audio_play_sound(
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


        // Sair sem perder o progresso
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
    }
    break;


    // --------------------------------------------------
    // Mostra o resultado antes do fade
    // --------------------------------------------------

    case MECANISMO_CONCLUIDO:
    {
        global.controle_bloqueado = true;
        pode_interagir = false;


        contador_conclusao--;


        if (
            contador_conclusao <= 0
            && !transicao_iniciada
        )
        {
            transicao_iniciada = true;

            estado_mecanismo =
                MECANISMO_FADE;


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
                    }


                    // Libera a passagem
                    with (obj_bloqueio_ponte)
                    {
                        instance_destroy();
                    }


                    // Destaca o som da ponte
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


                    estado_mecanismo =
                        MECANISMO_CONCLUIDO;

                    pode_interagir = false;
                    global.controle_bloqueado = false;
                }
            );


            global.fade_instancia.iniciar(
                _abaixar_ponte,
                0.04,
                45
            );
        }
    }
    break;


    // --------------------------------------------------
    // Aguarda o fade
    // --------------------------------------------------

    case MECANISMO_FADE:
    {
        global.controle_bloqueado = true;
        pode_interagir = false;
    }
    break;
}

#endregion