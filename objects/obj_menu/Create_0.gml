event_inherited();


#region Bloquear gameplay

global.controle_bloqueado = true;
global.dialogo_ativo = false;

#endregion


#region Estados do menu

MENU_PRINCIPAL = 0;
MENU_CONTROLES = 1;
MENU_CONFIGURACOES = 2;


CONFIG_MUSICA = 0;
CONFIG_EFEITOS = 1;
CONFIG_TELA_CHEIA = 2;
CONFIG_VOLTAR = 3;


estado_menu = MENU_PRINCIPAL;

#endregion


#region Menu principal

opcao_selecionada = 0;
opcoes_menu = [];

transicao_iniciada = false;

anim_menu = 0;

#endregion


#region Animação de entrada

alpha_fundo = 0;
alpha_logo = 0;
alpha_opcoes = 0;

contador_entrada = 0;
menu_pronto = false;

#endregion


#region Configurações

opcao_configuracao = CONFIG_MUSICA;

quantidade_configuracoes =
    CONFIG_VOLTAR + 1;

passo_volume = 0.1;

#endregion


#region Atualizar opções

atualizar_opcoes = function()
{
    var _texto_jogar =
        global.jogo_concluido
        ? "Jogar novamente"
        : "Jogar";


    opcoes_menu =
    [
        _texto_jogar,
        "Controles",
        "Configurações",
        "Sair"
    ];


    opcao_selecionada =
        clamp(
            opcao_selecionada,
            0,
            array_length(opcoes_menu) - 1
        );
};

#endregion


#region Sons do menu

tocar_som_menu_mover = function()
{
    var _som =
        audio_play_sound(
            snd_opcao_mover,
            0,
            false
        );


    if (_som == -1)
    {
        return false;
    }


    audio_sound_gain(
        _som,
        0.35,
        0
    );


    audio_sound_pitch(
        _som,
        2
    );


    return true;
};


tocar_som_menu_confirmar = function()
{
    var _som =
        audio_play_sound(
            snd_opcao_confirmar,
            1,
            false
        );


    if (_som == -1)
    {
        return false;
    }


    audio_sound_gain(
        _som,
        0.55,
        0
    );


    audio_sound_pitch(
        _som,
        2
    );


    return true;
};

#endregion


#region Acesso ao obj_game

game_menu_valido = function()
{
    if (
        !variable_global_exists(
            "game_instancia"
        )
    )
    {
        return false;
    }


    return instance_exists(
        global.game_instancia
    );
};


salvar_configuracoes_menu = function()
{
    if (!game_menu_valido())
    {
        show_debug_message(
            "ERRO: obj_game não encontrado ao salvar configurações."
        );

        return false;
    }


    global.game_instancia
        .salvar_configuracoes();


    return true;
};

#endregion


#region Alterar configurações

alterar_volume_musica = function(
    _direcao
)
{
    global.volume_musica =
        clamp(
            round(
                (
                    global.volume_musica
                    + passo_volume
                    * sign(_direcao)
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


    salvar_configuracoes_menu();
};


alterar_volume_efeitos = function(
    _direcao
)
{
    global.volume_efeitos =
        clamp(
            round(
                (
                    global.volume_efeitos
                    + passo_volume
                    * sign(_direcao)
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


    salvar_configuracoes_menu();
};


alternar_tela_cheia = function()
{
    global.tela_cheia =
        !global.tela_cheia;


    window_set_fullscreen(
        global.tela_cheia
    );


    salvar_configuracoes_menu();
};

#endregion


#region Voltar ao menu principal

voltar_menu_principal = function(
    _opcao
)
{
    estado_menu = MENU_PRINCIPAL;


    opcao_selecionada =
        clamp(
            _opcao,
            0,
            array_length(opcoes_menu) - 1
        );
};

#endregion


#region Controle do fade

fade_menu_ativo = function()
{
    if (
        !variable_global_exists(
            "fade_instancia"
        )
    )
    {
        return false;
    }


    if (
        !instance_exists(
            global.fade_instancia
        )
    )
    {
        return false;
    }


    return global.fade_instancia.ativo;
};


iniciar_fade_menu = function(
    _funcao,
    _velocidade,
    _duracao_preto
)
{
    if (
        !variable_global_exists(
            "fade_instancia"
        )
    )
    {
        show_debug_message(
            "ERRO: global.fade_instancia não existe no menu."
        );

        return false;
    }


    if (
        !instance_exists(
            global.fade_instancia
        )
    )
    {
        show_debug_message(
            "ERRO: obj_fade não encontrado no menu."
        );

        return false;
    }


    return global.fade_instancia.iniciar(
        _funcao,
        _velocidade,
        _duracao_preto
    );
};

#endregion


#region Inicialização

atualizar_opcoes();

#endregion