#region Abrir a pausa

if (!pausa_ativa)
{
    // O Esc pertence ao minigame aberto
    if (puzzle_impede_pausa())
    {
        exit;
    }


    // Impede que o mesmo Esc que fechou
    // um minigame abra a pausa
    if (
        variable_global_exists(
            "bloquear_pause_frames"
        )
        && global.bloquear_pause_frames > 0
    )
    {
        global.bloquear_pause_frames--;

        keyboard_clear(
            vk_escape
        );

        exit;
    }


    var _dialogo_ativo =
        variable_global_exists(
            "dialogo_ativo"
        )
        && global.dialogo_ativo;


    if (
        keyboard_check_pressed(
            vk_escape
        )
        && !fade_pausa_ativo()
        && !_dialogo_ativo
        && !global.controle_bloqueado
    )
    {
        abrir_pausa();
    }


    exit;
}

#endregion


#region Manter gameplay bloqueado

global.controle_bloqueado = true;
global.interacao_ativa = noone;

#endregion


#region Aguardar transição

if (
    transicao_iniciada
    || fade_pausa_ativo()
)
{
    exit;
}

#endregion


#region Animação

anim_entrada =
    min(
        anim_entrada + 0.12,
        1
    );

anim_destaque += 0.08;

#endregion


#region Telas da pausa

switch (estado_pausa)
{
    // ==================================================
    // MENU PRINCIPAL
    // ==================================================

    case PAUSA_PRINCIPAL:
    {
        var _quantidade_opcoes =
            array_length(
                opcoes_pausa
            );


        if (_quantidade_opcoes <= 0)
        {
            show_debug_message(
                "ERRO: obj_pausa não possui opções."
            );

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


        var _voltar =
            keyboard_check_pressed(
                vk_escape
            );


        // ----------------------------------------------
        // Navegação
        // ----------------------------------------------

        if (_cima && !_baixo)
        {
            opcao_selecionada--;


            if (opcao_selecionada < 0)
            {
                opcao_selecionada =
                    _quantidade_opcoes - 1;
            }


            tocar_som_pausa_mover();
        }


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


            tocar_som_pausa_mover();
        }


        // ----------------------------------------------
        // Confirmar
        // ----------------------------------------------

        if (_confirmar)
        {
            switch (opcao_selecionada)
            {
                // Continuar
                case 0:

                    tocar_som_pausa_confirmar();
                    fechar_pausa();

                break;


                // Controles
                case 1:

                    tocar_som_pausa_confirmar();

                    estado_pausa =
                        PAUSA_CONTROLES;

                break;


                // Configurações
                case 2:

                    tocar_som_pausa_confirmar();

                    estado_pausa =
                        PAUSA_CONFIGURACOES;

                    opcao_configuracao =
                        CONFIG_MUSICA;

                break;


                // Voltar ao menu
                case 3:
                {
                    var _voltar_menu =
                        method(
                            id,

                            function()
                            {
                                pausa_ativa = false;

                                restaurar_volume_musica(
                                    0
                                );


                                global.controle_bloqueado =
                                    true;

                                global.interacao_ativa =
                                    noone;


                                room_goto(
                                    rm_menu
                                );
                            }
                        );


                    // Somente bloqueia a pausa se
                    // o fade realmente começar
                    transicao_iniciada =
                        iniciar_fade_pausa(
                            _voltar_menu,
                            0.03,
                            45
                        );


                    if (transicao_iniciada)
                    {
                        tocar_som_pausa_confirmar();
                    }
                }
                break;
            }


            exit;
        }


        // Esc continua o jogo
        if (_voltar)
        {
            tocar_som_pausa_confirmar();
            fechar_pausa();

            exit;
        }
    }
    break;


    // ==================================================
    // CONTROLES
    // ==================================================

    case PAUSA_CONTROLES:
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
            tocar_som_pausa_confirmar();

            estado_pausa =
                PAUSA_PRINCIPAL;

            opcao_selecionada = 1;
        }
    }
    break;


    // ==================================================
    // CONFIGURAÇÕES
    // ==================================================

    case PAUSA_CONFIGURACOES:
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


            tocar_som_pausa_mover();
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


            tocar_som_pausa_mover();
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

                    alterar_volume_musica_pausa(
                        _direcao
                    );

                    tocar_som_pausa_mover();

                break;


                case CONFIG_EFEITOS:

                    alterar_volume_efeitos_pausa(
                        _direcao
                    );

                    tocar_som_pausa_mover();

                break;


                case CONFIG_TELA_CHEIA:

                    alternar_tela_cheia_pausa();
                    tocar_som_pausa_mover();

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
                tocar_som_pausa_confirmar();
                alternar_tela_cheia_pausa();
            }
            else if (
                opcao_configuracao
                == CONFIG_VOLTAR
            )
            {
                tocar_som_pausa_confirmar();

                estado_pausa =
                    PAUSA_PRINCIPAL;

                opcao_selecionada = 2;
            }


            exit;
        }


        // Esc volta ao menu da pausa
        if (_voltar)
        {
            tocar_som_pausa_confirmar();

            estado_pausa =
                PAUSA_PRINCIPAL;

            opcao_selecionada = 2;

            exit;
        }
    }
    break;


    // ==================================================
    // PROTEÇÃO CONTRA ESTADO INVÁLIDO
    // ==================================================

    default:
    {
        show_debug_message(
            "ERRO: estado inválido no obj_pausa."
        );


        estado_pausa =
            PAUSA_PRINCIPAL;

        opcao_selecionada = 0;

        opcao_configuracao =
            CONFIG_MUSICA;

        transicao_iniciada = false;
    }
    break;
}

#endregion