// ==================================================
// INTRODUÇÃO
// ==================================================

global.controle_bloqueado = true;


// 0 = textos da introdução
// 1 = título do jogo
estado_intro = 0;


// Texto definitivo
frases_intro =
[
    "Em uma época em que notícias atravessavam reinos nas mãos de viajantes, um mensageiro recebeu uma tarefa simples.",

    "Ele deveria cruzar aquelas terras e entregar uma carta de casamento a uma pessoa que nunca havia conhecido.",

    "Não havia segredos, riquezas ou ordens importantes naquela mensagem. Eram apenas palavras destinadas a alguém comum.",

    "Para o mensageiro, seria apenas mais uma viagem.",

    "Mas algumas jornadas deixam marcas muito além de seu destino."
];


// Máquina de escrever
frase_atual = 0;
caracteres_visiveis = 0;
velocidade_texto = 0.7;

// ==================================================
// SOM DO LÁPIS
// ==================================================

som_lapis_instancia = -1;


iniciar_som_lapis = function()
{
    if (
        som_lapis_instancia == -1
        || !audio_is_playing(som_lapis_instancia)
    )
    {
        som_lapis_instancia = audio_play_sound(
            snd_lapis_escrevendo,
            0,
            true
        );

        audio_sound_gain(
            som_lapis_instancia,
            0.30,
            0
        );

        audio_sound_pitch(
            som_lapis_instancia,
            1
        );
    }
};


parar_som_lapis = function()
{
    if (som_lapis_instancia != -1)
    {
        audio_stop_sound(
            som_lapis_instancia
        );

        som_lapis_instancia = -1;
    }
};


// Título
titulo_intro = "Pequenas Escolhas";
alpha_titulo = 0;
velocidade_alpha_titulo = 0.015;


// Controle das transições
transicao_iniciada = false;