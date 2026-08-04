// ==================================================
// MENU PRINCIPAL
// ==================================================

global.controle_bloqueado = true;


// 0 = menu principal
// 1 = controles
// 2 = configurações
estado_menu = 0;
anim_menu = 0;


// Opção selecionada
opcao_selecionada = 0;


// Controle de transição
transicao_iniciada = false;


// Título
titulo_menu = "Pequenas Escolhas";


// Atualiza o texto Jogar/Jogar novamente
atualizar_opcoes = function()
{
    var _texto_jogar = "Jogar";

    if (global.jogo_concluido)
    {
        _texto_jogar = "Jogar novamente";
    }


    opcoes_menu =
    [
        _texto_jogar,
        "Controles",
        "Configurações",
        "Sair"
    ];
};

// ==================================================
// ANIMAÇÃO DE ENTRADA
// ==================================================

alpha_fundo = 0;
alpha_logo = 0;
alpha_opcoes = 0;

contador_entrada = 0;

menu_pronto = false;


// ==================================================
// CONFIGURAÇÕES
// ==================================================

opcao_configuracao = 0;

quantidade_configuracoes = 4;

// O volume muda de 10% em 10%
passo_volume = 0.1;

// ==================================================
// SONS DO MENU
// ==================================================

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

    // Mais grave somente no menu
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

    // Confirmação mais grave somente no menu
    audio_sound_pitch(
        _som,
        2
    );
};

atualizar_opcoes();