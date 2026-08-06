#region Bloquear gameplay

// O menu nunca deve liberar o controle do jogador
global.controle_bloqueado = true;

#endregion


#region Aguardar fade

if (fade_menu_ativo())
{
    exit;
}

#endregion


#region Animação geral

anim_menu += 0.08;

#endregion


#region Entrada do menu

if (!menu_pronto)
{
    contador_entrada++;


    alpha_fundo =
        min(
            alpha_fundo + 0.025,
            1
        );


    if (contador_entrada >= 20)
    {
        alpha_logo =
            min(
                alpha_logo + 0.025,
                1
            );
    }


    if (contador_entrada >= 50)
    {
        alpha_opcoes =
            min(
                alpha_opcoes + 0.03,
                1
            );
    }


    if (alpha_opcoes >= 1)
    {
        alpha_opcoes = 1;
        menu_pronto = true;
    }
}

#endregion


#region Telas do menu

switch (estado_menu)
{
    // ==================================================
    // MENU PRINCIPAL
    // ==================================================

    case MENU_PRINCIPAL:
    {
        if (!menu_pronto)
        {
            break;
        }


        var _quantidade_opcoes =
            array_length(
                opcoes_menu
            );


        if (_quantidade_opcoes <= 0)
        {
            atualizar_opcoes();

            break;
        }


        opcao_selecionada =
            clamp(
                opcao_selecionada,
                0,
                _quantidade_opcoes - 1
            );


        var _cima =
            keyboard_check_pressed(
                vk_up
            )
            || keyboard_check_pressed(
                ord("W")
            );


        var _baixo =
            keyboard_check_pressed(
                vk_down
            )
            || keyboard_check_pressed(
                ord("S")
            );


        var _confirmar =
            keyboard_check_pressed(
                ord("E")
            )
            || keyboard_check_pressed(
                vk_enter
            );


        // ----------------------------------------------
        // Navegar para cima
        // ----------------------------------------------

        if (_cima && !_baixo)
        {
            opcao_selecionada--;


            if (opcao_selecionada < 0)
            {
                opcao_selecionada =
                    _quantidade_opcoes - 1;
            }


            tocar_som_menu_mover();
        }


        // ----------------------------------------------
        // Navegar para baixo
        // ----------------------------------------------

        if (_baixo && !_cima)
        {
            opcao_selecionada++;


            if (
                opcao_selecionada
                >= _quantidade_opcoes
            )
            {
                opcao_selecionada = 0;
            }


            tocar_som_menu_mover();
        }


        if (!_confirmar)
        {
            break;
        }


        // ----------------------------------------------
        // Jogar
        // ----------------------------------------------

        if (opcao_selecionada == 0)
        {
            if (transicao_iniciada)
            {
                break;
            }


            var _iniciar_jogo =
                method(
                    id,

                    function()
                    {
                        if (!game_menu_valido())
                        {
                            show_debug_message(
                                "ERRO: obj_game não encontrado ao iniciar a partida."
                            );

                            transicao_iniciada =
                                false;

                            return;
                        }


                        global.game_instancia
                            .resetar_progresso();


                        global.controle_bloqueado =
                            true;


                        room_goto(
                            rm_intro
                        );
                    }
                );


            // Somente bloqueia novas confirmações
            // se o fade realmente começar
            transicao_iniciada =
                iniciar_fade_menu(
                    _iniciar_jogo,
                    0.03,
                    45
                );


            if (transicao_iniciada)
            {
                tocar_som_menu_confirmar();
            }


            break;
        }


        // ----------------------------------------------
        // Controles
        // ----------------------------------------------

        if (opcao_selecionada == 1)
        {
            tocar_som_menu_confirmar();

            estado_menu =
                MENU_CONTROLES;

            break;
        }


        // ----------------------------------------------
        // Configurações
        // ----------------------------------------------

        if (opcao_selecionada == 2)
        {
            tocar_som_menu_confirmar();

            estado_menu =
                MENU_CONFIGURACOES;

            opcao_configuracao =
                CONFIG_MUSICA;

            break;
        }


        // ----------------------------------------------
        // Sair
        // ----------------------------------------------

        if (opcao_selecionada == 3)
        {
            tocar_som_menu_confirmar();

            game_end();

            break;
        }
    }
    break;


    // ==================================================
    // CONTROLES
    // ==================================================

    case MENU_CONTROLES:
    {
        var _voltar =
            keyboard_check_pressed(
                vk_escape
            )
            || keyboard_check_pressed(
                ord("E")
            )
            || keyboard_check_pressed(
                vk_enter
            );


        if (_voltar)
        {
            tocar_som_menu_confirmar();

            voltar_menu_principal(1);
        }
    }
    break;


    // ==================================================
    // CONFIGURAÇÕES
    // ==================================================

    case MENU_CONFIGURACOES:
    {
        opcao_configuracao =
            clamp(
                opcao_configuracao,
                0,
                quantidade_configuracoes - 1
            );


        var _cima =
            keyboard_check_pressed(
                vk_up
            )
            || keyboard_check_pressed(
                ord("W")
            );


        var _baixo =
            keyboard_check_pressed(
                vk_down
            )
            || keyboard_check_pressed(
                ord("S")
            );


        var _esquerda =
            keyboard_check_pressed(
                vk_left
            )
            || keyboard_check_pressed(
                ord("A")
            );


        var _direita =
            keyboard_check_pressed(
                vk_right
            )
            || keyboard_check_pressed(
                ord("D")
            );


        var _confirmar =
            keyboard_check_pressed(
                ord("E")
            )
            || keyboard_check_pressed(
                vk_enter
            );


        var _voltar =
            keyboard_check_pressed(
                vk_escape
            );


        // ----------------------------------------------
        // Navegação
        // ----------------------------------------------

        if (_cima && !_baixo)
        {
            opcao_configuracao--;


            if (opcao_configuracao < 0)
            {
                opcao_configuracao =
                    quantidade_configuracoes - 1;
            }


            tocar_som_menu_mover();
        }


        if (_baixo && !_cima)
        {
            opcao_configuracao++;


            if (
                opcao_configuracao
                >= quantidade_configuracoes
            )
            {
                opcao_configuracao = 0;
            }


            tocar_som_menu_mover();
        }


        // ----------------------------------------------
        // Ajustes laterais
        // ----------------------------------------------

        if (_esquerda != _direita)
        {
            var _direcao =
                _direita ? 1 : -1;


            switch (opcao_configuracao)
            {
                case CONFIG_MUSICA:

                    alterar_volume_musica(
                        _direcao
                    );

                    tocar_som_menu_mover();

                break;


                case CONFIG_EFEITOS:

                    alterar_volume_efeitos(
                        _direcao
                    );

                    tocar_som_menu_mover();

                break;


                case CONFIG_TELA_CHEIA:

                    alternar_tela_cheia();

                    tocar_som_menu_mover();

                break;
            }
        }


        // ----------------------------------------------
        // Confirmar
        // ----------------------------------------------

        if (_confirmar)
        {
            if (
                opcao_configuracao
                == CONFIG_TELA_CHEIA
            )
            {
                tocar_som_menu_confirmar();

                alternar_tela_cheia();
            }
            else if (
                opcao_configuracao
                == CONFIG_VOLTAR
            )
            {
                tocar_som_menu_confirmar();

                voltar_menu_principal(2);
            }
        }
        else if (_voltar)
        {
            tocar_som_menu_confirmar();

            voltar_menu_principal(2);
        }
    }
    break;


    // ==================================================
    // PROTEÇÃO CONTRA ESTADO INVÁLIDO
    // ==================================================

    default:
    {
        show_debug_message(
            "ERRO: estado inválido no obj_menu."
        );


        estado_menu =
            MENU_PRINCIPAL;

        opcao_selecionada = 0;
        opcao_configuracao =
            CONFIG_MUSICA;

        transicao_iniciada = false;


        atualizar_opcoes();
    }
    break;
}

#endregion