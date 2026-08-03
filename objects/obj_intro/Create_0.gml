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


// Título
titulo_intro = "Pequenas Escolhas";
alpha_titulo = 0;
velocidade_alpha_titulo = 0.015;


// Controle das transições
transicao_iniciada = false;