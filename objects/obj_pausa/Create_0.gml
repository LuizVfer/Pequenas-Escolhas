// ==================================================
// MENU DE PAUSA
// ==================================================

pausa_ativa = false;

// 0 = menu principal
// 1 = controles
// 2 = configurações
estado_pausa = 0;

opcao_selecionada = 0;
opcao_configuracao = 0;

quantidade_configuracoes = 4;

transicao_iniciada = false;


// Música fica reduzida enquanto o jogo está pausado
fator_volume_pausa = 0.25;

// Configurações mudam de 10% em 10%
passo_volume = 0.1;

// ==================================================
// ANIMAÇÃO VISUAL
// ==================================================

anim_entrada = 0;
anim_destaque = 0;


opcoes_pausa =
[
    "Continuar",
    "Controles",
    "Configurações",
    "Voltar ao menu"
];


// ==================================================
// SONS
// ==================================================

tocar_som_pausa_mover = function()
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


tocar_som_pausa_confirmar = function()
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


// ==================================================
// APLICAR VOLUME DURANTE A PAUSA
// ==================================================

aplicar_volume_musica_pausa = function()
{
    audio_group_set_gain(
        audiogroup_musica,

        global.volume_musica
            * fator_volume_pausa,

        100
    );
};


// ==================================================
// ABRIR PAUSA
// ==================================================

abrir_pausa = function()
{
    if (pausa_ativa)
    {
        exit;
    }

    pausa_ativa = true;

    estado_pausa = 0;
    opcao_selecionada = 0;
    opcao_configuracao = 0;

    transicao_iniciada = false;
    
    anim_entrada = 0;

    global.controle_bloqueado = true;
    global.interacao_ativa = noone;

    aplicar_volume_musica_pausa();
};


// ==================================================
// FECHAR PAUSA
// ==================================================

fechar_pausa = function()
{
    if (!pausa_ativa)
    {
        exit;
    }

    pausa_ativa = false;
    estado_pausa = 0;

    global.controle_bloqueado = false;


    // Restaura o volume configurado
    audio_group_set_gain(
        audiogroup_musica,
        global.volume_musica,
        250
    );
};