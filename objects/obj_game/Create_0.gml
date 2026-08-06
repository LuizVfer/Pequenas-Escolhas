#region Evitar duplicação

if (instance_number(obj_game) > 1)
{
    instance_destroy();
    exit;
}

#endregion


#region Configuração inicial

// Sincronização e pixel art
display_reset(0, true);
gpu_set_texfilter(false);

display_set_gui_size(
    640,
    360
);


// Referência global do controlador
global.game_instancia = id;

#endregion


#region Progresso inicial

// Controle geral
global.controle_bloqueado = false;
global.dialogo_ativo = false;
global.interacao_ativa = noone;

global.jogo_concluido = false;

global.bloquear_pause_frames = 0;


// Escolhas do jogador
global.escolha_pedra = -1;
global.escolha_cachorro = -1;
global.escolha_sementes = -1;
global.escolha_brinquedo = -1;


// Posição após trocar de room
global.usar_spawn = false;
global.spawn_x = 64;
global.spawn_y = 304;


// Cidade
global.ferreiro_conversado = false;
global.roda_liberada = false;
global.roda_usada = false;


// Floresta
global.ponte_descoberta = false;
global.ponte_abaixada = false;

global.caminho_cacador_liberado = false;


// Vila
global.portao_descoberto = false;
global.portao_aberto = false;

global.balde_coletado = false;
global.balde_cheio = false;

global.cabo_enxada_coletado = false;
global.cabo_enxada_entregue = false;

global.morador_recebeu_agua = false;

global.quest_cabo_iniciada = false;
global.quest_agua_iniciada = false;


// Destino
global.carta_entregue = false;

global.crianca_destino_conversada = false;

#endregion


#region Resetar progresso da partida

resetar_progresso = function()
{
    // ----------------------------------------------
    // Controle geral
    // ----------------------------------------------

    global.controle_bloqueado = false;
    global.dialogo_ativo = false;
    global.interacao_ativa = noone;

    global.bloquear_pause_frames = 0;


    // ----------------------------------------------
    // Escolhas
    // ----------------------------------------------

    global.escolha_pedra = -1;
    global.escolha_cachorro = -1;
    global.escolha_sementes = -1;
    global.escolha_brinquedo = -1;


    // ----------------------------------------------
    // Cidade
    // ----------------------------------------------

    global.ferreiro_conversado = false;

    global.roda_liberada = false;
    global.roda_usada = false;


    // ----------------------------------------------
    // Floresta
    // ----------------------------------------------

    global.ponte_descoberta = false;
    global.ponte_abaixada = false;

    global.caminho_cacador_liberado = false;


    // ----------------------------------------------
    // Vila
    // ----------------------------------------------

    global.portao_descoberto = false;
    global.portao_aberto = false;

    global.balde_coletado = false;
    global.balde_cheio = false;

    global.cabo_enxada_coletado = false;
    global.cabo_enxada_entregue = false;

    global.morador_recebeu_agua = false;

    global.quest_cabo_iniciada = false;
    global.quest_agua_iniciada = false;


    // ----------------------------------------------
    // Destino
    // ----------------------------------------------

    global.carta_entregue = false;

    global.crianca_destino_conversada = false;


    // ----------------------------------------------
    // Posição entre rooms
    // ----------------------------------------------

    global.usar_spawn = false;

    global.spawn_x = 96;
    global.spawn_y = 304;


    // A nova partida ainda não foi concluída
    global.jogo_concluido = false;


    show_debug_message(
        "Progresso da partida resetado."
    );
};

#endregion


#region Configurações do jogador

global.volume_musica = 0.7;
global.volume_efeitos = 1;

global.tela_cheia = false;

#endregion


#region Aplicar configurações

aplicar_configuracoes = function()
{
    global.volume_musica =
        clamp(
            global.volume_musica,
            0,
            1
        );

    global.volume_efeitos =
        clamp(
            global.volume_efeitos,
            0,
            1
        );


    audio_group_set_gain(
        audiogroup_musica,
        global.volume_musica,
        0
    );

    audio_group_set_gain(
        audiogroup_efeitos,
        global.volume_efeitos,
        0
    );


    if (
        window_get_fullscreen()
        != global.tela_cheia
    )
    {
        window_set_fullscreen(
            global.tela_cheia
        );
    }
};

#endregion


#region Salvar configurações

salvar_configuracoes = function()
{
    ini_open(
        "configuracoes.ini"
    );


    ini_write_real(
        "audio",
        "volume_musica",
        global.volume_musica
    );

    ini_write_real(
        "audio",
        "volume_efeitos",
        global.volume_efeitos
    );

    ini_write_real(
        "video",
        "tela_cheia",
        global.tela_cheia ? 1 : 0
    );


    ini_close();
};

#endregion


#region Carregar configurações

carregar_configuracoes = function()
{
    ini_open(
        "configuracoes.ini"
    );


    global.volume_musica =
        clamp(
            ini_read_real(
                "audio",
                "volume_musica",
                0.7
            ),
            0,
            1
        );


    global.volume_efeitos =
        clamp(
            ini_read_real(
                "audio",
                "volume_efeitos",
                1
            ),
            0,
            1
        );


    global.tela_cheia =
        ini_read_real(
            "video",
            "tela_cheia",
            0
        ) == 1;


    ini_close();


    aplicar_configuracoes();
};

#endregion


#region Estado da música

musica_atual = noone;
musica_instancia = -1;

musica_pendente = noone;


// Atraso antes de começar uma nova música
atraso_musica = 75;


// Controle do ducking
ducking_musica_ativo = false;

#endregion


#region Tocar música

tocar_musica = function(_musica)
{
    if (_musica == noone)
    {
        return false;
    }


    // A música correta já está tocando
    if (
        musica_atual == _musica
        && musica_instancia != -1
        && audio_is_playing(
            musica_instancia
        )
    )
    {
        musica_pendente = noone;
        alarm[0] = -1;

        return true;
    }


    // Interrompe a música anterior
    if (
        musica_instancia != -1
        && audio_is_playing(
            musica_instancia
        )
    )
    {
        audio_stop_sound(
            musica_instancia
        );
    }


    // Impede que o ducking anterior
    // alcance a nova música
    alarm[1] = -1;
    ducking_musica_ativo = false;


    musica_atual = noone;
    musica_instancia = -1;


    var _nova_instancia =
        audio_play_sound(
            _musica,
            10,
            true
        );


    if (_nova_instancia == -1)
    {
        show_debug_message(
            "ERRO: não foi possível iniciar a música."
        );

        return false;
    }


    musica_atual = _musica;
    musica_instancia = _nova_instancia;


    return true;
};

#endregion


#region Agendar música

agendar_musica = function(
    _musica,
    _atraso = 30
)
{
    if (_musica == noone)
    {
        return false;
    }


    // A música correta já está tocando.
    // Exemplo: Menu → Introdução.
    if (
        musica_atual == _musica
        && musica_instancia != -1
        && audio_is_playing(
            musica_instancia
        )
    )
    {
        musica_pendente = noone;
        alarm[0] = -1;

        return true;
    }


    // A mesma música já está aguardando.
    // Mantém a contagem que já começou.
    if (
        musica_pendente == _musica
        && alarm[0] > 0
    )
    {
        return true;
    }


    // Cancela qualquer música que aguardava
    alarm[0] = -1;

    musica_pendente = _musica;


    // Interrompe a música da room anterior
    if (
        musica_instancia != -1
        && audio_is_playing(
            musica_instancia
        )
    )
    {
        audio_stop_sound(
            musica_instancia
        );
    }


    musica_atual = noone;
    musica_instancia = -1;


    // Cancela o ducking da música anterior
    alarm[1] = -1;
    ducking_musica_ativo = false;


    // Inicia a contagem do atraso
    alarm[0] =
        max(
            1,
            round(_atraso)
        );


    return true;
};

#endregion


#region Parar música

parar_musica = function()
{
    // Cancela músicas que ainda aguardam
    alarm[0] = -1;
    musica_pendente = noone;


    // Cancela o ducking
    alarm[1] = -1;
    ducking_musica_ativo = false;


    if (
        musica_instancia != -1
        && audio_is_playing(
            musica_instancia
        )
    )
    {
        audio_stop_sound(
            musica_instancia
        );
    }


    musica_atual = noone;
    musica_instancia = -1;
};

#endregion


#region Ducking da música

abaixar_musica_para_efeito = function(
    _duracao_frames = 45,
    _fator = 0.35
)
{
    if (
        musica_instancia == -1
        || !audio_is_playing(
            musica_instancia
        )
    )
    {
        return false;
    }


    _duracao_frames =
        max(
            1,
            round(_duracao_frames)
        );

    _fator =
        clamp(
            _fator,
            0,
            1
        );


    // Abaixa suavemente em 100 milissegundos
    audio_sound_gain(
        musica_instancia,
        _fator,
        100
    );


    // Um novo efeito prolonga
    // o tempo da música baixa
    alarm[1] =
        max(
            alarm[1],
            _duracao_frames
        );


    ducking_musica_ativo = true;


    return true;
};


restaurar_musica_apos_efeito = function()
{
    if (
        musica_instancia != -1
        && audio_is_playing(
            musica_instancia
        )
    )
    {
        // Retorna suavemente
        // em 250 milissegundos
        audio_sound_gain(
            musica_instancia,
            1,
            250
        );
    }


    ducking_musica_ativo = false;
};

#endregion


#region Carregar grupos de áudio

if (
    !audio_group_is_loaded(
        audiogroup_efeitos
    )
)
{
    audio_group_load(
        audiogroup_efeitos
    );
}


if (
    !audio_group_is_loaded(
        audiogroup_musica
    )
)
{
    audio_group_load(
        audiogroup_musica
    );
}

#endregion


#region Inicializar configurações

carregar_configuracoes();

#endregion