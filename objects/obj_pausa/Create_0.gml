#region Estados

PAUSA_PRINCIPAL = 0;
PAUSA_CONTROLES = 1;
PAUSA_CONFIGURACOES = 2;

CONFIG_MUSICA = 0;
CONFIG_EFEITOS = 1;
CONFIG_TELA_CHEIA = 2;
CONFIG_VOLTAR = 3;

pausa_ativa = false;
estado_pausa = PAUSA_PRINCIPAL;

opcao_selecionada = 0;
opcao_configuracao = CONFIG_MUSICA;

quantidade_configuracoes =
    CONFIG_VOLTAR + 1;

transicao_iniciada = false;

#endregion


#region Opções

opcoes_pausa =
[
    "Continuar",
    "Controles",
    "Configurações",
    "Voltar ao menu"
];

#endregion


#region Configurações

// A música fica reduzida durante a pausa
fator_volume_pausa = 0.25;

// Alteração de 10% em 10%
passo_volume = 0.1;

#endregion


#region Animação

anim_entrada = 0;
anim_destaque = 0;

#endregion


#region Sons

tocar_som_pausa_mover = function()
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


tocar_som_pausa_confirmar = function()
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

game_pausa_valido = function()
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


salvar_configuracoes_pausa = function()
{
    if (!game_pausa_valido())
    {
        show_debug_message(
            "ERRO: obj_game não encontrado ao salvar configurações pela pausa."
        );

        return false;
    }


    global.game_instancia
        .salvar_configuracoes();


    return true;
};

#endregion


#region Controle do fade

fade_pausa_ativo = function()
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


iniciar_fade_pausa = function(
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
            "ERRO: global.fade_instancia não existe na pausa."
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
            "ERRO: obj_fade não encontrado na pausa."
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


#region Bloqueio dos minigames

puzzle_impede_pausa = function()
{
    var _mecanismo =
        instance_find(
            obj_mecanismo_ponte,
            0
        );


    if (
        instance_exists(_mecanismo)
        && _mecanismo.estado_mecanismo
            == _mecanismo.MECANISMO_PUZZLE
    )
    {
        return true;
    }


    var _cacador =
        instance_find(
            obj_cacador,
            0
        );


    if (
        instance_exists(_cacador)
        && _cacador.estado_cacador
            == _cacador.CACADOR_PUZZLE
    )
    {
        return true;
    }


    return false;
};

#endregion


#region Volume da música

aplicar_volume_musica_pausa = function()
{
    audio_group_set_gain(
        audiogroup_musica,

        global.volume_musica
            * fator_volume_pausa,

        100
    );
};


restaurar_volume_musica = function(
    _tempo = 250
)
{
    audio_group_set_gain(
        audiogroup_musica,
        global.volume_musica,
        _tempo
    );
};

#endregion


#region Alterar configurações

alterar_volume_musica_pausa = function(
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


    aplicar_volume_musica_pausa();
    salvar_configuracoes_pausa();
};


alterar_volume_efeitos_pausa = function(
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


    salvar_configuracoes_pausa();
};


alternar_tela_cheia_pausa = function()
{
    global.tela_cheia =
        !global.tela_cheia;


    window_set_fullscreen(
        global.tela_cheia
    );


    salvar_configuracoes_pausa();
};

#endregion


#region Abrir pausa

abrir_pausa = function()
{
    if (pausa_ativa)
    {
        return false;
    }


    pausa_ativa = true;

    estado_pausa =
        PAUSA_PRINCIPAL;

    opcao_selecionada = 0;

    opcao_configuracao =
        CONFIG_MUSICA;

    transicao_iniciada = false;

    anim_entrada = 0;
    anim_destaque = 0;


    global.controle_bloqueado = true;
    global.interacao_ativa = noone;


    aplicar_volume_musica_pausa();


    return true;
};

#endregion


#region Fechar pausa

fechar_pausa = function()
{
    if (!pausa_ativa)
    {
        return false;
    }


    pausa_ativa = false;

    estado_pausa =
        PAUSA_PRINCIPAL;

    transicao_iniciada = false;


    restaurar_volume_musica();


    var _dialogo_ativo =
        variable_global_exists(
            "dialogo_ativo"
        )
        && global.dialogo_ativo;


    // Não libera o jogador caso outro
    // sistema ainda esteja bloqueando o controle
    global.controle_bloqueado =
        _dialogo_ativo
        || fade_pausa_ativo();


    return true;
};

#endregion