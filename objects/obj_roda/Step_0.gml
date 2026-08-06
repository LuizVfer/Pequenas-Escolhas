#region Segurança

if (global.roda_usada)
{
    instance_destroy();
    exit;
}


if (reparo_iniciado)
{
    parar_roda();
    exit;
}


if (estado_puzzle_roda == ESTADO_PARADO)
{
    sendo_empurrada = false;
    minigame_ativo = false;

    pode_interagir =
        global.roda_liberada;

    parar_roda();
    exit;
}


var _player =
    instance_find(obj_player, 0);


if (!instance_exists(_player))
{
    estado_puzzle_roda =
        ESTADO_PARADO;

    sendo_empurrada = false;
    minigame_ativo = false;

    global.controle_bloqueado = false;

    exit;
}

#endregion


#region Estados do puzzle

switch (estado_puzzle_roda)
{
    // --------------------------------------------------
    // Aguarda o diálogo inicial terminar
    // --------------------------------------------------

    case ESTADO_DIALOGO_RODA:
    {
        if (!global.controle_bloqueado)
        {
            global.controle_bloqueado = true;

            posicionar_player_empurrando(
                _player,
                false
            );

            preparar_minigame_roda();
        }
    }
    break;


    // --------------------------------------------------
    // Minigame para empurrar
    // --------------------------------------------------

    case ESTADO_MINIGAME_RODA:
    {
        global.controle_bloqueado = true;

        parar_roda();

        posicionar_player_empurrando(
            _player,
            false
        );

        anim_minigame_roda += 0.10;


        if (feedback_erro > 0)
        {
            feedback_erro--;
        }


        if (bloqueio_entrada_minigame > 0)
        {
            bloqueio_entrada_minigame--;
            break;
        }


        atualizar_marcador();


        if (keyboard_check_pressed(ord("E")))
        {
            if (marcador_acertou_zona())
            {
                minigame_ativo = false;

                x_inicio_impulso = x;

                x_fim_impulso =
                    calcular_destino_impulso(
                        impulso_atual + 1
                    );

                contador_impulso = 0;

                estado_puzzle_roda =
                    ESTADO_IMPULSO;


                var _som = audio_play_sound(
                    snd_opcao_confirmar,
                    1,
                    false
                );

                audio_sound_gain(
                    _som,
                    0.45,
                    0
                );
            }
            else
            {
                feedback_erro = 30;

                marcador_posicao = 0;
                marcador_direcao = 1;

                bloqueio_entrada_minigame = 10;

                sortear_zona(0.27, 0.73);
                tocar_som_erro();
            }
        }
    }
    break;


    // --------------------------------------------------
    // Executa o movimento da roda
    // --------------------------------------------------

    case ESTADO_IMPULSO:
    {
        global.controle_bloqueado = true;

        contador_impulso++;


        var _progresso =
            clamp(
                contador_impulso
                    / duracao_impulso,
                0,
                1
            );


        var _progresso_suave =
            _progresso
            * _progresso
            * (3 - 2 * _progresso);


        x = lerp(
            x_inicio_impulso,
            x_fim_impulso,
            _progresso_suave
        );


        posicionar_player_empurrando(
            _player,
            true
        );
        
        
        // Animação da roda durante o movimento
        image_speed = 0;
        
        image_index +=
            velocidade_animacao;
        
        if (image_index >= image_number)
        {
            image_index -= image_number;
        }


        if (_progresso >= 1)
        {
            x = x_fim_impulso;

            parar_roda();

            posicionar_player_empurrando(
                _player,
                false
            );

            impulso_atual++;


            if (
                impulso_atual
                >= quantidade_impulsos
            )
            {
                x = x_destino_sequencia;

                sendo_empurrada = false;
                minigame_ativo = false;

                estado_puzzle_roda =
                    ESTADO_DIALOGO_MARTELO;

                global.controle_bloqueado =
                    false;

                posicionar_player_idle(_player);


                global.dialogo_instancia.abrir(
                [
                    {
                        nome: "Mensageiro",
                        texto: "A roda está no lugar. Falta apenas fixá-la ao eixo."
                    }
                ]);
            }
            else
            {
                contador_espera =
                    espera_proximo_impulso;

                estado_puzzle_roda =
                    ESTADO_ESPERA;
            }
        }
    }
    break;


    // --------------------------------------------------
    // Pequena espera entre os impulsos
    // --------------------------------------------------

    case ESTADO_ESPERA:
    {
        global.controle_bloqueado = true;

        parar_roda();

        posicionar_player_empurrando(
            _player,
            false
        );


        contador_espera--;


        if (contador_espera <= 0)
        {
            preparar_minigame_roda();
        }
    }
    break;


    // --------------------------------------------------
    // Aguarda o diálogo do martelo terminar
    // --------------------------------------------------

    case ESTADO_DIALOGO_MARTELO:
    {
        sendo_empurrada = false;
        minigame_ativo = false;
        pode_interagir = false;

        parar_roda();


        if (!global.controle_bloqueado)
        {
            global.controle_bloqueado = true;

            posicionar_player_idle(_player);

            marteladas_corretas = 0;

            preparar_minigame_martelo();
        }
    }
    break;


    // --------------------------------------------------
    // Minigame do martelo
    // --------------------------------------------------

    case ESTADO_MINIGAME_MARTELO:
    {
        global.controle_bloqueado = true;

        sendo_empurrada = false;
        pode_interagir = false;

        parar_roda();
        posicionar_player_idle(_player);

        anim_minigame_roda += 0.10;


        if (feedback_erro > 0)
        {
            feedback_erro--;
        }


        if (bloqueio_entrada_minigame > 0)
        {
            bloqueio_entrada_minigame--;
            break;
        }


        atualizar_marcador();


        if (keyboard_check_pressed(ord("E")))
        {
            if (marcador_acertou_zona())
            {
                marteladas_corretas++;


                if (
                    instance_exists(
                        global.game_instancia
                    )
                )
                {
                    global.game_instancia
                        .abaixar_musica_para_efeito(
                            35,
                            0.25
                        );
                }


                var _som_martelo =
                    audio_play_sound(
                        snd_martelo,
                        2,
                        false
                    );

                audio_sound_gain(
                    _som_martelo,
                    1,
                    0
                );
                
                _player.iniciar_animacao_martelo();


                if (
                    marteladas_corretas
                    >= quantidade_marteladas
                )
                {
                    minigame_ativo = false;

                    posicionar_player_idle(_player);

                    concluir_reparo_carroca();
                }
                else
                {
                    preparar_minigame_martelo();
                }
            }
            else
            {
                marteladas_corretas = 0;

                feedback_erro = 30;

                marcador_posicao = 0;
                marcador_direcao = 1;

                velocidade_marcador =
                    velocidade_martelo_base;

                bloqueio_entrada_minigame = 12;

                sortear_zona(0.24, 0.76);
                tocar_som_erro();
            }
        }
    }
    break;


    // --------------------------------------------------
    // O fade está concluindo o reparo
    // --------------------------------------------------

    case ESTADO_FINALIZANDO:
    {
        parar_roda();
    }
    break;
}

#endregion