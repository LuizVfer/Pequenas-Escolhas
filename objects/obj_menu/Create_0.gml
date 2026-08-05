event_inherited();

global.controle_bloqueado = true;


#region Estados

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
quantidade_configuracoes = 4;

passo_volume = 0.1;

#endregion


#region Opções do menu

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
};

#endregion


#region Sons

tocar_som_menu_mover = function()
{
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

    audio_sound_pitch(
        _som,
        2
    );
};


tocar_som_menu_confirmar = function()
{
    var _som = audio_play_sound(
        snd_opcao_confirmar,
        1,
        false
    );

    audio_sound_gain(
        _som,
        0.55,
        0
    );

    audio_sound_pitch(
        _som,
        2
    );
};

#endregion


#region Funções de configuração

salvar_configuracoes = function()
{
    if (instance_exists(global.game_instancia))
    {
        global.game_instancia
            .salvar_configuracoes();
    }
};


alterar_volume_musica = function(_direcao)
{
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

    audio_group_set_gain(
        audiogroup_musica,
        global.volume_musica,
        0
    );

    salvar_configuracoes();
};


alterar_volume_efeitos = function(_direcao)
{
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

    salvar_configuracoes();
};


alternar_tela_cheia = function()
{
    global.tela_cheia =
        !global.tela_cheia;

    window_set_fullscreen(
        global.tela_cheia
    );

    salvar_configuracoes();
};


voltar_menu_principal = function(_opcao)
{
    estado_menu = MENU_PRINCIPAL;
    opcao_selecionada = _opcao;
};

#endregion


atualizar_opcoes();