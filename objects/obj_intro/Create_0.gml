#region Bloquear gameplay

global.controle_bloqueado = true;
global.dialogo_ativo = false;

#endregion


#region Estados

ESTADO_TEXTOS = 0;
ESTADO_TITULO = 1;

estado_intro = ESTADO_TEXTOS;

#endregion


#region Textos da introdução

frases_intro =
[
    "Em uma época em que notícias atravessavam reinos nas mãos de viajantes, um mensageiro recebeu uma tarefa simples.",

    "Ele deveria cruzar aquelas terras e entregar uma carta de casamento a uma pessoa que nunca havia conhecido.",

    "Não havia segredos, riquezas ou ordens importantes naquela mensagem. Eram apenas palavras destinadas a alguém comum.",

    "Para o mensageiro, seria apenas mais uma viagem.",

    "Mas algumas jornadas deixam marcas muito além de seu destino."
];

#endregion


#region Máquina de escrever

frase_atual = 0;

caracteres_visiveis = 0;
velocidade_texto = 0.7;

#endregion


#region Som do lápis

som_lapis_instancia = -1;


iniciar_som_lapis = function()
{
    if (
        som_lapis_instancia != -1
        && audio_is_playing(
            som_lapis_instancia
        )
    )
    {
        return;
    }


    som_lapis_instancia =
        audio_play_sound(
            snd_lapis_escrevendo,
            0,
            true
        );


    if (som_lapis_instancia == -1)
    {
        return;
    }


    audio_sound_gain(
        som_lapis_instancia,
        0.30,
        0
    );


    audio_sound_pitch(
        som_lapis_instancia,
        1
    );
};


parar_som_lapis = function()
{
    if (som_lapis_instancia == -1)
    {
        return;
    }


    if (
        audio_is_playing(
            som_lapis_instancia
        )
    )
    {
        audio_stop_sound(
            som_lapis_instancia
        );
    }


    som_lapis_instancia = -1;
};

#endregion


#region Título

titulo_intro = "Pequenas Escolhas";

alpha_titulo = 0;
velocidade_alpha_titulo = 0.015;

#endregion


#region Controle das transições

transicao_iniciada = false;


fade_intro_ativo = function()
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


iniciar_fade_intro = function(
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
            "ERRO: global.fade_instancia não existe."
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
            "ERRO: obj_fade não encontrado na introdução."
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