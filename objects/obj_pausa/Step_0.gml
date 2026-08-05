// ==================================================
// VERIFICA O FADE
// ==================================================

var _fade_ativo = false;

if (instance_exists(global.fade_instancia))
{
    _fade_ativo =
        global.fade_instancia.ativo;
}


// ==================================================
// ABRIR A PAUSA
// ==================================================

if (!pausa_ativa)
{
    if (
        keyboard_check_pressed(vk_escape)
        && !_fade_ativo
        && !global.controle_bloqueado
    )
    {
        abrir_pausa();
    }

    exit;
}

// ==================================================
// ANIMAÇÃO DA PAUSA
// ==================================================

anim_entrada = min(
    anim_entrada + 0.12,
    1
);

anim_destaque += 0.08;


// ==================================================
// MENU PRINCIPAL DA PAUSA
// ==================================================

if (estado_pausa == 0)
{
    var _cima =
        keyboard_check_pressed(vk_up)
        || keyboard_check_pressed(ord("W"));

    var _baixo =
        keyboard_check_pressed(vk_down)
        || keyboard_check_pressed(ord("S"));

    var _confirmar =
        keyboard_check_pressed(ord("E"))
        || keyboard_check_pressed(vk_enter);

    var _voltar =
        keyboard_check_pressed(vk_escape);


    // ==============================================
    // NAVEGAÇÃO
    // ==============================================

    if (_cima)
    {
        opcao_selecionada--;

        if (opcao_selecionada < 0)
        {
            opcao_selecionada =
                array_length(opcoes_pausa) - 1;
        }

        tocar_som_pausa_mover();
    }


    if (_baixo)
    {
        opcao_selecionada++;

        if (
            opcao_selecionada
            >= array_length(opcoes_pausa)
        )
        {
            opcao_selecionada = 0;
        }

        tocar_som_pausa_mover();
    }


    // ==============================================
    // CONFIRMAR
    // ==============================================

    if (_confirmar)
    {
        tocar_som_pausa_confirmar();

        switch (opcao_selecionada)
        {
            // Continuar
            case 0:
                fechar_pausa();
            break;


            // Controles
            case 1:
                estado_pausa = 1;
            break;


            // Configurações
            case 2:
                estado_pausa = 2;
                opcao_configuracao = 0;
            break;


            // Voltar ao menu
            case 3:
                if (!transicao_iniciada)
                {
                    transicao_iniciada = true;


                    var _voltar_menu = method(
                        id,

                        function()
                        {
                            pausa_ativa = false;

                            audio_group_set_gain(
                                audiogroup_musica,
                                global.volume_musica,
                                0
                            );

                            global.controle_bloqueado =
                                true;

                            room_goto(rm_menu);
                        }
                    );


                    global.fade_instancia.iniciar(
                        _voltar_menu,
                        0.03,
                        45
                    );
                }
            break;
        }
    }


    // Esc continua o jogo
    if (_voltar)
    {
        tocar_som_pausa_confirmar();
        fechar_pausa();
    }

    exit;
}


// ==================================================
// TELA DE CONTROLES
// ==================================================

if (estado_pausa == 1)
{
    var _voltar_controles =
        keyboard_check_pressed(vk_escape)
        || keyboard_check_pressed(ord("E"))
        || keyboard_check_pressed(vk_enter);


    if (_voltar_controles)
    {
        tocar_som_pausa_confirmar();

        estado_pausa = 0;
        opcao_selecionada = 1;
    }

    exit;
}


// ==================================================
// TELA DE CONFIGURAÇÕES
// ==================================================

if (estado_pausa == 2)
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


    // ==============================================
    // NAVEGAÇÃO
    // ==============================================

    if (_cima)
    {
        opcao_configuracao--;

        if (opcao_configuracao < 0)
        {
            opcao_configuracao =
                quantidade_configuracoes - 1;
        }

        tocar_som_pausa_mover();
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

        tocar_som_pausa_mover();
    }


    // ==============================================
    // ALTERAR CONFIGURAÇÃO
    // ==============================================

    if (_esquerda || _direita)
    {
        var _direcao = 1;

        if (_esquerda)
        {
            _direcao = -1;
        }


        switch (opcao_configuracao)
        {
            // Volume da música
            case 0:
                global.volume_musica =
                    clamp(
                        round(
                            (
                                global.volume_musica
                                + passo_volume * _direcao
                            ) * 10
                        ) / 10,

                        0,
                        1
                    );


                aplicar_volume_musica_pausa();


                global.game_instancia
                    .salvar_configuracoes();


                tocar_som_pausa_mover();
            break;


            // Volume dos efeitos
            case 1:
                global.volume_efeitos =
                    clamp(
                        round(
                            (
                                global.volume_efeitos
                                + passo_volume * _direcao
                            ) * 10
                        ) / 10,

                        0,
                        1
                    );


                audio_group_set_gain(
                    audiogroup_efeitos,
                    global.volume_efeitos,
                    0
                );


                global.game_instancia
                    .salvar_configuracoes();


                tocar_som_pausa_mover();
            break;


            // Tela cheia
            case 2:
                global.tela_cheia =
                    !global.tela_cheia;


                window_set_fullscreen(
                    global.tela_cheia
                );


                global.game_instancia
                    .salvar_configuracoes();


                tocar_som_pausa_mover();
            break;
        }
    }


    // ==============================================
    // CONFIRMAR
    // ==============================================

    if (_confirmar)
    {
        // Tela cheia
        if (opcao_configuracao == 2)
        {
            tocar_som_pausa_confirmar();


            global.tela_cheia =
                !global.tela_cheia;


            window_set_fullscreen(
                global.tela_cheia
            );


            global.game_instancia
                .salvar_configuracoes();
        }


        // Voltar
        else if (opcao_configuracao == 3)
        {
            tocar_som_pausa_confirmar();

            estado_pausa = 0;
            opcao_selecionada = 2;
        }
    }


    // Esc volta ao menu da pausa
    if (_voltar)
    {
        tocar_som_pausa_confirmar();

        estado_pausa = 0;
        opcao_selecionada = 2;
    }

    exit;
}