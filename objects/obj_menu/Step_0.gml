#region Fade

if (
    instance_exists(global.fade_instancia)
    && global.fade_instancia.ativo
)
{
    exit;
}

#endregion


anim_menu += 0.08;


#region Entrada do menu

if (!menu_pronto)
{
    contador_entrada++;

    alpha_fundo =
        min(alpha_fundo + 0.025, 1);


    if (contador_entrada >= 20)
    {
        alpha_logo =
            min(alpha_logo + 0.025, 1);
    }


    if (contador_entrada >= 50)
    {
        alpha_opcoes =
            min(alpha_opcoes + 0.03, 1);
    }


    if (alpha_opcoes >= 1)
    {
        alpha_opcoes = 1;
        menu_pronto = true;
    }
}

#endregion


#region Telas

switch (estado_menu)
{
    case MENU_PRINCIPAL:
    {
        if (!menu_pronto)
        {
            break;
        }


        var _cima =
            keyboard_check_pressed(vk_up)
            || keyboard_check_pressed(ord("W"));

        var _baixo =
            keyboard_check_pressed(vk_down)
            || keyboard_check_pressed(ord("S"));

        var _confirmar =
            keyboard_check_pressed(ord("E"))
            || keyboard_check_pressed(vk_enter);


        if (_cima)
        {
            opcao_selecionada--;

            if (opcao_selecionada < 0)
            {
                opcao_selecionada =
                    array_length(opcoes_menu) - 1;
            }

            tocar_som_menu_mover();
        }


        if (_baixo)
        {
            opcao_selecionada++;

            if (
                opcao_selecionada
                >= array_length(opcoes_menu)
            )
            {
                opcao_selecionada = 0;
            }

            tocar_som_menu_mover();
        }


        if (_confirmar)
        {
            tocar_som_menu_confirmar();


            switch (opcao_selecionada)
            {
                case 0:
                {
                    if (!transicao_iniciada)
                    {
                        transicao_iniciada = true;


                        var _iniciar_jogo = method(
                            id,

                            function()
                            {
                                global.game_instancia
                                    .resetar_progresso();

                                global.controle_bloqueado =
                                    true;

                                room_goto(rm_intro);
                            }
                        );


                        global.fade_instancia.iniciar(
                            _iniciar_jogo,
                            0.03,
                            45
                        );
                    }
                }
                break;


                case 1:
                {
                    estado_menu =
                        MENU_CONTROLES;
                }
                break;


                case 2:
                {
                    estado_menu =
                        MENU_CONFIGURACOES;

                    opcao_configuracao =
                        CONFIG_MUSICA;
                }
                break;


                case 3:
                {
                    game_end();
                }
                break;
            }
        }
    }
    break;


    case MENU_CONTROLES:
    {
        var _voltar =
            keyboard_check_pressed(vk_escape)
            || keyboard_check_pressed(ord("E"))
            || keyboard_check_pressed(vk_enter);


        if (_voltar)
        {
            tocar_som_menu_confirmar();
            voltar_menu_principal(1);
        }
    }
    break;


    case MENU_CONFIGURACOES:
    {
        var _cima =
            keyboard_check_pressed(vk_up)
            || keyboard_check_pressed(ord("W"));

        var _baixo =
            keyboard_check_pressed(vk_down)
            || keyboard_check_pressed(ord("S"));

        var _esquerda =
            keyboard_check_pressed(vk_left)
            || keyboard_check_pressed(ord("A"));

        var _direita =
            keyboard_check_pressed(vk_right)
            || keyboard_check_pressed(ord("D"));

        var _confirmar =
            keyboard_check_pressed(ord("E"))
            || keyboard_check_pressed(vk_enter);

        var _voltar =
            keyboard_check_pressed(vk_escape);


        // Navegação
        if (_cima)
        {
            opcao_configuracao--;

            if (opcao_configuracao < 0)
            {
                opcao_configuracao =
                    quantidade_configuracoes - 1;
            }

            tocar_som_menu_mover();
        }


        if (_baixo)
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


        // Ajustes laterais
        if (_esquerda || _direita)
        {
            var _direcao =
                _direita ? 1 : -1;


            switch (opcao_configuracao)
            {
                case CONFIG_MUSICA:
                {
                    alterar_volume_musica(
                        _direcao
                    );

                    tocar_som_menu_mover();
                }
                break;


                case CONFIG_EFEITOS:
                {
                    alterar_volume_efeitos(
                        _direcao
                    );

                    tocar_som_menu_mover();
                }
                break;


                case CONFIG_TELA_CHEIA:
                {
                    alternar_tela_cheia();
                    tocar_som_menu_mover();
                }
                break;
            }
        }


        // Confirmação
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
}

#endregion