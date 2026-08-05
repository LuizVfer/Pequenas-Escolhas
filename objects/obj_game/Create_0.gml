// Pixel art sem borrado
gpu_set_texfilter(false);

global.game_instancia = id;

// Controle geral
global.controle_bloqueado = false;
global.dialogo_ativo = false;
global.interacao_ativa = noone;
global.jogo_concluido = false;

// Escolhas do jogador
global.escolha_pedra = -1;
global.escolha_cachorro = -1;
global.escolha_sementes = -1;
global.escolha_brinquedo = -1;

// Posição do player depois de trocar de room
global.usar_spawn = false;
global.spawn_x = 64;
global.spawn_y = 304;

global.ferreiro_conversado = false;
global.roda_liberada = false;
global.roda_usada = false;

global.ponte_descoberta = false;
global.ponte_abaixada = false;

global.portao_descoberto = false;
global.portao_aberto = false;

global.moradores_conversados = 0;
global.moradores_necessarios = 2;

global.morador_1_conversado = false;
global.moradora_2_conversada = false;

global.bloquear_pause_frames = 0;

global.carta_entregue = false;

display_set_gui_size(640, 360);

// ==================================================
// RESETAR PROGRESSO DA PARTIDA
// ==================================================

resetar_progresso = function()
{
    // ==================================================
    // CONTROLE GERAL
    // ==================================================

    global.controle_bloqueado = false;
    global.dialogo_ativo = false;
    global.interacao_ativa = noone;


    // ==================================================
    // ESCOLHAS
    // ==================================================

    global.escolha_pedra = -1;
    global.escolha_cachorro = -1;
    global.escolha_sementes = -1;
    global.escolha_brinquedo = -1;


    // ==================================================
    // CIDADE
    // ==================================================

    global.ferreiro_conversado = false;
    global.roda_liberada = false;
    global.roda_usada = false;


    // ==================================================
    // FLORESTA
    // ==================================================

    global.ponte_descoberta = false;
    global.ponte_abaixada = false;


    // ==================================================
    // VILA
    // ==================================================

    global.portao_descoberto = false;
    global.portao_aberto = false;

    global.moradores_conversados = 0;
    global.moradores_necessarios = 2;

    global.morador_1_conversado = false;
    global.moradora_2_conversada = false;


    // ==================================================
    // DESTINO
    // ==================================================

    global.carta_entregue = false;


    // ==================================================
    // POSIÇÃO ENTRE ROOMS
    // ==================================================

    global.usar_spawn = false;
    global.spawn_x = 96;
    global.spawn_y = 304;


    // A partida está começando novamente
    global.jogo_concluido = false;


    show_debug_message(
        "Progresso da partida resetado."
    );
};

// ==================================================
// CONFIGURAÇÕES DO JOGADOR
// ==================================================

global.volume_musica = 0.7;
global.volume_efeitos = 1.0;
global.tela_cheia = false;


// ==================================================
// APLICAR CONFIGURAÇÕES
// ==================================================

aplicar_configuracoes = function()
{
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


// ==================================================
// SALVAR CONFIGURAÇÕES
// ==================================================

salvar_configuracoes = function()
{
    ini_open("configuracoes.ini");


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


// ==================================================
// CARREGAR CONFIGURAÇÕES
// ==================================================

carregar_configuracoes = function()
{
    ini_open("configuracoes.ini");


    global.volume_musica = clamp(
        ini_read_real(
            "audio",
            "volume_musica",
            0.7
        ),
        0,
        1
    );


    global.volume_efeitos = clamp(
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

// ==================================================
// SISTEMA DE MÚSICA
// ==================================================

musica_atual = noone;
musica_instancia = -1;
// Música que começará depois do atraso
musica_pendente = noone;

// Aproximadamente 0,5 segundo em 60 FPS
atraso_musica = 75;


// Toca uma música sem criar duplicatas
tocar_musica = function(_musica)
{
    if (_musica == noone)
    {
        exit;
    }


    // A música correta já está tocando
    if (
        musica_atual == _musica
        && musica_instancia != -1
        && audio_is_playing(musica_instancia)
    )
    {
        exit;
    }


    // Interrompe a música anterior
    if (
        musica_instancia != -1
        && audio_is_playing(musica_instancia)
    )
    {
        audio_stop_sound(musica_instancia);
    }


    musica_atual = _musica;

    musica_instancia = audio_play_sound(
        _musica,
        10,
        true
    );
};

// Agenda uma música para começar depois de alguns frames
agendar_musica = function(
    _musica,
    _atraso = 30
)
{
    if (_musica == noone)
    {
        exit;
    }


    // A mesma música já está tocando.
    // Exemplo: Menu → Introdução.
    if (
        musica_atual == _musica
        && musica_instancia != -1
        && audio_is_playing(musica_instancia)
    )
    {
        musica_pendente = noone;
        alarm[0] = -1;
        exit;
    }


    // Cancela qualquer música que estava aguardando
    alarm[0] = -1;
    musica_pendente = _musica;


    // Para a música da room anterior
    if (
        musica_instancia != -1
        && audio_is_playing(musica_instancia)
    )
    {
        audio_stop_sound(musica_instancia);
    }


    musica_atual = noone;
    musica_instancia = -1;


    // Inicia a contagem do atraso
    alarm[0] = max(1, _atraso);
};


// Para completamente a música atual
parar_musica = function()
{
    if (
        musica_instancia != -1
        && audio_is_playing(musica_instancia)
    )
    {
        audio_stop_sound(musica_instancia);
    }

    musica_atual = noone;
    musica_instancia = -1;
};

// ==================================================
// DUCKING DA MÚSICA
// ==================================================

ducking_musica_ativo = false;


// Abaixa temporariamente a música para destacar um efeito
abaixar_musica_para_efeito = function(
    _duracao_frames = 45,
    _fator = 0.35
)
{
    if (
        musica_instancia == -1
        || !audio_is_playing(musica_instancia)
    )
    {
        exit;
    }

    _duracao_frames =
        max(1, round(_duracao_frames));

    _fator =
        clamp(_fator, 0, 1);


    // Abaixa suavemente em 100 milissegundos
    audio_sound_gain(
        musica_instancia,
        _fator,
        100
    );


    // Um novo efeito prolonga o tempo de música baixa
    alarm[1] = max(
        alarm[1],
        _duracao_frames
    );

    ducking_musica_ativo = true;
};


// Volta a música ao volume normal da instância
restaurar_musica_apos_efeito = function()
{
    if (
        musica_instancia != -1
        && audio_is_playing(musica_instancia)
    )
    {
        // Retorna suavemente em 250 milissegundos
        audio_sound_gain(
            musica_instancia,
            1,
            250
        );
    }

    ducking_musica_ativo = false;
};


// ==================================================
// CARREGAR GRUPOS DE ÁUDIO
// ==================================================

if (!audio_group_is_loaded(audiogroup_efeitos))
{
    audio_group_load(audiogroup_efeitos);
}

if (!audio_group_is_loaded(audiogroup_musica))
{
    audio_group_load(audiogroup_musica);
}


// Carrega volumes e tela cheia
carregar_configuracoes();

