// ==================================================
// AGUARDA O FADE
// ==================================================

if (
    instance_exists(global.fade_instancia)
    && global.fade_instancia.ativo
)
{
    exit;
}

anim_menu += 0.08;


// ==================================================
// ANIMAÇÃO DE ENTRADA DO MENU
// ==================================================

if (!menu_pronto)
{
    contador_entrada++;


    alpha_fundo = min(
        alpha_fundo + 0.025,
        1
    );


    if (contador_entrada >= 20)
    {
        alpha_logo = min(
            alpha_logo + 0.025,
            1
        );
    }


    if (contador_entrada >= 50)
    {
        alpha_opcoes = min(
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


// ==================================================
// MENU PRINCIPAL
// ==================================================

if (estado_menu == 0)
{
    // Não permite navegar durante a animação
    if (!menu_pronto)
    {
        exit;
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


    // Navegar para cima
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


    // Navegar para baixo
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


    // Confirmar
    if (_confirmar)
    {
        tocar_som_menu_confirmar();
        
        switch (opcao_selecionada)
        {
            
            // ==========================================
            // JOGAR
            // ==========================================

            case 0:
                if (!transicao_iniciada)
                {
                    transicao_iniciada = true;


                    var _iniciar_jogo = method(
                        id,

                        function()
                        {
                            global.game_instancia
                                .resetar_progresso();

                            global.controle_bloqueado = true;

                            room_goto(rm_intro);
                        }
                    );


                    global.fade_instancia.iniciar(
                        _iniciar_jogo,
                        0.03,
                        45
                    );
                }
            break;


            // ==========================================
            // CONTROLES
            // ==========================================

            case 1:
                estado_menu = 1;
            break;


            // ==========================================
            // CONFIGURAÇÕES
            // ==========================================

            case 2:
                estado_menu = 2;
                opcao_configuracao = 0;
            break;


            // ==========================================
            // SAIR
            // ==========================================

            case 3:
                game_end();
            break;
        }
    }

    exit;
}


// ==================================================
// CONTROLES
// ==================================================

if (estado_menu == 1)
{
    var _voltar_controles =
        keyboard_check_pressed(vk_escape)
        || keyboard_check_pressed(ord("E"))
        || keyboard_check_pressed(vk_enter);


    if (_voltar_controles)
    {
        tocar_som_menu_confirmar();
    
        estado_menu = 0;
        opcao_selecionada = 1;
    }

    exit;
}


// ==================================================
// CONFIGURAÇÕES
// ==================================================

if (estado_menu == 2)
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
    // NAVEGAR
    // ==============================================

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


    // ==============================================
    // ALTERAR PARA A ESQUERDA
    // ==============================================

    if (_esquerda)
    {
        switch (opcao_configuracao)
        {
            // Volume da música
            case 0:
                global.volume_musica =
                    clamp(
                        round(
                            (
                                global.volume_musica
                                - passo_volume
                            ) * 10
                        ) / 10,
                        0,
                        1
                    );

                audio_group_set_gain(
                    audiogroup_musica,
                    global.volume_musica,
                    0
                );

                global.game_instancia
                    .salvar_configuracoes();
            break;


            // Volume dos efeitos
            case 1:
                global.volume_efeitos =
                    clamp(
                        round(
                            (
                                global.volume_efeitos
                                - passo_volume
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
            break;
        }
        
        if (opcao_configuracao <= 2)
        {
            tocar_som_menu_mover();
        }
    }


    // ==============================================
    // ALTERAR PARA A DIREITA
    // ==============================================

    if (_direita)
    {
        switch (opcao_configuracao)
        {
            // Volume da música
            case 0:
                global.volume_musica =
                    clamp(
                        round(
                            (
                                global.volume_musica
                                + passo_volume
                            ) * 10
                        ) / 10,
                        0,
                        1
                    );

                audio_group_set_gain(
                    audiogroup_musica,
                    global.volume_musica,
                    0
                );

                global.game_instancia
                    .salvar_configuracoes();
            break;


            // Volume dos efeitos
            case 1:
                global.volume_efeitos =
                    clamp(
                        round(
                            (
                                global.volume_efeitos
                                + passo_volume
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
            break;
        }
        
        if (opcao_configuracao <= 2)
        {
            tocar_som_menu_mover();
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
            tocar_som_menu_confirmar();
    
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
            tocar_som_menu_confirmar();
    
            estado_menu = 0;
            opcao_selecionada = 2;
        }
    }


    // Esc também volta
    if (_voltar)
    {
        tocar_som_menu_confirmar();
    
        estado_menu = 0;
        opcao_selecionada = 2;
    }

    exit;
}