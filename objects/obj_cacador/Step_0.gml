#region Bloqueio da interação

if (bloqueio_interacao > 0)
{
    bloqueio_interacao--;
}

#endregion


// Movimento visual da interface
anim_puzzle += 0.08;


#region Estados do caçador

switch (estado_cacador)
{
    // ==================================================
    // AGUARDANDO INTERAÇÃO
    // ==================================================

    case CACADOR_PARADO:
    {
        pode_interagir =
            bloqueio_interacao <= 0
            && !transicao_iniciada;
    }
    break;


    // ==================================================
    // AGUARDAR O DIÁLOGO INICIAL
    // ==================================================

    case CACADOR_DIALOGO:
    {
        pode_interagir = false;

        // Abre o puzzle depois que o diálogo terminar
        if (!global.controle_bloqueado)
        {
            abrir_puzzle_corda();
        }
    }
    break;


    // ==================================================
    // AGUARDAR O DIÁLOGO FINAL
    // ==================================================

    case CACADOR_DIALOGO_FINAL:
    {
        pode_interagir = false;

        if (!global.controle_bloqueado)
        {
            estado_cacador = CACADOR_PARADO;

            // Impede que o mesmo E reabra a conversa
            bloqueio_interacao = 10;
        }
    }
    break;


    // ==================================================
    // PUZZLE DAS CORDAS
    // ==================================================

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


        // Sair possui prioridade sobre os outros comandos
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
        else
        {
            // ------------------------------------------
            // SELECIONAR A PEÇA ANTERIOR
            // ------------------------------------------

            if (_esquerda)
            {
                peca_selecionada--;

                if (peca_selecionada < 0)
                {
                    peca_selecionada =
                        quantidade_pecas - 1;
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
            // SELECIONAR A PRÓXIMA PEÇA
            // ------------------------------------------

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
            // GIRAR A PEÇA SELECIONADA
            // ------------------------------------------

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


                // Verifica se todas as peças estão alinhadas
                if (puzzle_corda_resolvido())
                {
                    estado_cacador =
                        CACADOR_CONCLUIDO;

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

    case CACADOR_CONCLUIDO:
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
            var _liberar_caminho = method(
                id,

                function()
                {
                    global.caminho_cacador_liberado =
                        true;

                    // Remove o bloqueio da passagem
                    with (obj_bloqueio_cacador)
                    {
                        instance_destroy();
                    }

                    estado_cacador = CACADOR_PARADO;
                    transicao_iniciada = false;

                    // Evita uma interação imediata
                    bloqueio_interacao = 10;
                    pode_interagir = false;

                    // O próprio obj_fade devolverá o
                    // controle quando a transição terminar
                }
            );


            var _fade_iniciado =
                global.fade_instancia.iniciar(
                    _liberar_caminho,
                    0.04,
                    45
                );


            // Só muda de estado se o fade realmente começar
            if (_fade_iniciado)
            {
                transicao_iniciada = true;
                estado_cacador = CACADOR_FADE;
            }
        }
    }
    break;


    // ==================================================
    // AGUARDAR O FADE
    // ==================================================

    case CACADOR_FADE:
    {
        global.controle_bloqueado = true;
        pode_interagir = false;
    }
    break;
}

#endregion