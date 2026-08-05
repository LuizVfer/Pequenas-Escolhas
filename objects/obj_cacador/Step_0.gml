#region Bloqueio de interação

if (bloqueio_interacao > 0)
{
    bloqueio_interacao--;
}

#endregion


anim_puzzle += 0.08;


#region Estados do caçador

switch (estado_cacador)
{
    // --------------------------------------------------
    // Aguardando interação
    // --------------------------------------------------

   case CACADOR_PARADO:
    {
        pode_interagir =
            bloqueio_interacao <= 0;
    }
    break;

    // --------------------------------------------------
    // Aguarda o diálogo inicial terminar
    // --------------------------------------------------

    case CACADOR_DIALOGO:
    {
        pode_interagir = false;


        if (!global.controle_bloqueado)
        {
            abrir_puzzle_corda();
        }
    }
    break;

// --------------------------------------------------
// Conversa depois que o caminho foi liberado
// --------------------------------------------------

    case CACADOR_DIALOGO_FINAL:
    {
        pode_interagir = false;
    
    
        // Aguarda o diálogo fechar
        if (!global.controle_bloqueado)
        {
            estado_cacador =
                CACADOR_PARADO;
    
            // Evita que o mesmo E reabra a conversa
            bloqueio_interacao = 10;
            pode_interagir = false;
        }
    }
    break;


    // --------------------------------------------------
    // Puzzle das cordas
    // --------------------------------------------------

    case CACADOR_PUZZLE:
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


        // Selecionar a peça anterior
        if (_esquerda)
        {
            peca_selecionada--;

            if (peca_selecionada < 0)
            {
                peca_selecionada =
                    quantidade_pecas - 1;
            }


            var _som_mover =
                audio_play_sound(
                    snd_opcao_mover,
                    0,
                    false
                );

            audio_sound_gain(
                _som_mover,
                0.35,
                0
            );
        }


        // Selecionar a próxima peça
        else if (_direita)
        {
            peca_selecionada++;

            if (
                peca_selecionada
                >= quantidade_pecas
            )
            {
                peca_selecionada = 0;
            }


            var _som_mover =
                audio_play_sound(
                    snd_opcao_mover,
                    0,
                    false
                );

            audio_sound_gain(
                _som_mover,
                0.35,
                0
            );
        }


        // Girar a peça selecionada
        if (_girar)
        {
            girar_peca(peca_selecionada);


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


            // Verifica a solução
            if (puzzle_corda_resolvido())
            {
                estado_cacador =
                    CACADOR_CONCLUIDO;

                contador_conclusao =
                    espera_conclusao;

                transicao_iniciada = false;
            }
        }


        // Fecha sem perder as rotações
        if (_sair)
        {
            var _som_sair =
                audio_play_sound(
                    snd_opcao_confirmar,
                    1,
                    false
                );

            audio_sound_gain(
                _som_sair,
                0.40,
                0
            );

            fechar_puzzle_corda();
        }
    }
    break;


    // --------------------------------------------------
    // Mostra a corda resolvida antes do fade
    // --------------------------------------------------

    case CACADOR_CONCLUIDO:
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
            estado_cacador = CACADOR_FADE;


            var _liberar_caminho = method(
                id,

                function()
                {
                    global.caminho_cacador_liberado =
                        true;


                    // Remove o bloqueio da saída
                    with (obj_bloqueio_cacador)
                    {
                        instance_destroy();
                    }


                    estado_cacador =
                        CACADOR_PARADO;
                    
                    pode_interagir = true;
                    
                    global.controle_bloqueado =
                        false;
                }
            );


            global.fade_instancia.iniciar(
                _liberar_caminho,
                0.04,
                45
            );
        }
    }
    break;


    // --------------------------------------------------
    // Aguarda o fade terminar
    // --------------------------------------------------

    case CACADOR_FADE:
    {
        global.controle_bloqueado = true;
        pode_interagir = false;
    }
    break;
}

#endregion