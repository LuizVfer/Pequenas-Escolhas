#region Estados do encerramento

ESTADO_LIVRO_FECHADO_INICIO = 0;
ESTADO_CONSEQUENCIAS = 1;
ESTADO_LIVRO_FECHADO_FINAL = 2;
ESTADO_MENSAGEM_FINAL = 3;
ESTADO_CREDITOS = 4;

estado_final =
    ESTADO_LIVRO_FECHADO_INICIO;


// Controle das transições
abertura_iniciada = false;

transicao_consequencia_iniciada = false;
transicao_mensagem_iniciada = false;
transicao_creditos_iniciada = false;

retorno_menu_iniciado = false;

#endregion


#region Consequências

// 0 = pedra
// 1 = cachorro
// 2 = sementes
// 3 = brinquedo
consequencia_atual = 0;

sprite_consequencia = noone;
titulo_consequencia = "";

frases_consequencia = [];

frase_atual = 0;
caracteres_visiveis = 0;

velocidade_frase = 0.7;

consequencia_concluida = false;

#endregion


#region Tempos do encerramento

contador = 0;

tempo_livro_fechado = 90;
tempo_livro_fechado_final = 60;

#endregion


#region Sons do livro

som_livro_abrindo = snd_livro_abrindo;

// O mesmo som é usado com pitch mais baixo
// durante o fechamento
som_livro_fechando = snd_livro_abrindo;

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


    audio_stop_sound(
        som_lapis_instancia
    );

    som_lapis_instancia = -1;
};

#endregion


#region Funções de segurança

fade_disponivel = function()
{
    return
        variable_global_exists(
            "fade_instancia"
        )
        && instance_exists(
            global.fade_instancia
        );
};


fade_ativo = function()
{
    return
        fade_disponivel()
        && global.fade_instancia.ativo;
};


iniciar_fade_final = function(
    _funcao,
    _velocidade,
    _duracao
)
{
    if (!fade_disponivel())
    {
        show_debug_message(
            "ERRO: obj_fade não encontrado no livro final."
        );

        return false;
    }


    if (!is_method(_funcao))
    {
        show_debug_message(
            "ERRO: callback inválido no livro final."
        );

        return false;
    }


    return global.fade_instancia.iniciar(
        _funcao,
        _velocidade,
        _duracao
    );
};


abaixar_musica_final = function(
    _duracao,
    _volume
)
{
    if (
        !variable_global_exists(
            "game_instancia"
        )
        || !instance_exists(
            global.game_instancia
        )
    )
    {
        return false;
    }


    if (
        !variable_instance_exists(
            global.game_instancia,
            "abaixar_musica_para_efeito"
        )
    )
    {
        return false;
    }


    var _funcao_abaixar =
        global.game_instancia
            .abaixar_musica_para_efeito;


    if (!is_method(_funcao_abaixar))
    {
        return false;
    }


    method_call(
        _funcao_abaixar,
        [
            _duracao,
            _volume
        ]
    );


    return true;
};

#endregion


#region Som de troca de página

tocar_som_pagina = function()
{
    if (som_livro_abrindo == noone)
    {
        return;
    }


    abaixar_musica_final(
        55,
        0.20
    );


    var _som_pagina =
        audio_play_sound(
            som_livro_abrindo,
            2,
            false
        );


    if (_som_pagina == -1)
    {
        return;
    }


    audio_sound_gain(
        _som_pagina,
        0.95,
        0
    );

    audio_sound_pitch(
        _som_pagina,
        1.15
    );
};

#endregion


#region Mensagem final

frases_finais =
[
    "O mensageiro jamais conheceu as histórias que nasceram pelo caminho.",

    "Para ele, aquela havia sido apenas mais uma viagem.",

    "Algumas escolhas duram apenas um instante.",

    "Suas consequências podem atravessar uma vida inteira."
];

frase_final_atual = 0;

caracteres_finais_visiveis = 0;
velocidade_mensagem_final = 0.7;

mensagem_final_concluida = false;

#endregion


#region Título e créditos

titulo_final =
    "Pequenas Escolhas";


creditos =
[
    "Desenvolvimento, Arte, roteiro e direção",
    "Luiz Fernando",

    "",

    "Criado no GameMaker",

    "",

    "Obrigado por jogar."
];


alpha_titulo_final = 0;
alpha_creditos = 0;

contador_creditos = 0;

tempo_antes_creditos = 90;

velocidade_alpha_titulo = 0.015;
velocidade_alpha_creditos = 0.012;

final_completo = false;

#endregion


#region Configurar consequência da pedra

configurar_consequencia_pedra = function()
{
    consequencia_atual = 0;

    titulo_consequencia =
        "A pedra no caminho";

    frase_atual = 0;
    caracteres_visiveis = 0;

    consequencia_concluida = false;
    transicao_consequencia_iniciada = false;


    var _escolha = 2;


    if (
        variable_global_exists(
            "escolha_pedra"
        )
    )
    {
        _escolha =
            global.escolha_pedra;
    }


    switch (_escolha)
    {
        // ----------------------------------------------
        // Chutar
        // ----------------------------------------------

        case 0:
            sprite_consequencia =
                spr_final_pedra_1;

            frases_consequencia =
            [
                "A pedra rolou pela estrada e assustou o cavalo que aguardava na praça.",

                "Em meio à confusão, o prisioneiro escapou sem ser notado.",

                "Anos mais tarde, ainda foragido, ele cruzou o caminho de uma família que jamais retornou para casa.",

                "Um simples impulso pode alcançar pessoas que você jamais conhecerá."
            ];
        break;


        // ----------------------------------------------
        // Retirar
        // ----------------------------------------------

        case 1:
            sprite_consequencia =
                spr_final_pedra_2;

            frases_consequencia =
            [
                "A pedra foi deixada próxima a uma das casas, onde uma criança a encontrou.",

                "Brincando com ela, atingiu uma colmeia próxima à plantação. O agricultor foi atacado, e parte da colheita se perdeu.",

                "Naquele inverno, sua família conheceu a fome.",

                "Nem toda boa intenção produz o resultado esperado."
            ];
        break;


        // ----------------------------------------------
        // Ignorar ou escolha inválida
        // ----------------------------------------------

        default:
            sprite_consequencia =
                spr_final_pedra_3;

            frases_consequencia =
            [
                "A pedra permaneceu no meio da estrada.",

                "Mais tarde, uma carroça passou por aquele caminho e teve uma de suas rodas quebrada.",

                "O artesão que a conduzia perdeu uma viagem importante e nunca conseguiu reencontrar a família que o esperava.",

                "Até a ausência de uma escolha pode mudar uma história."
            ];
        break;
    }
};

#endregion


#region Configurar consequência do cachorro

configurar_consequencia_cachorro = function()
{
    consequencia_atual = 1;

    titulo_consequencia =
        "O cachorro na armadilha";

    frase_atual = 0;
    caracteres_visiveis = 0;

    consequencia_concluida = false;
    transicao_consequencia_iniciada = false;


    var _escolha = 2;


    if (
        variable_global_exists(
            "escolha_cachorro"
        )
    )
    {
        _escolha =
            global.escolha_cachorro;
    }


    switch (_escolha)
    {
        // ----------------------------------------------
        // Libertar
        // ----------------------------------------------

        case 0:
            sprite_consequencia =
                spr_final_cachorro_1;

            frases_consequencia =
            [
                "Livre da armadilha, o cachorro seguiu o caçador pela floresta.",

                "Com sua ajuda, ele encontrou uma criança que havia se perdido entre as árvores e a levou de volta para casa.",

                "Anos mais tarde, essa criança tornou-se curandeira e salvou centenas de pessoas durante uma epidemia.",

                "Um gesto de bondade pode ecoar por gerações."
            ];
        break;


        // ----------------------------------------------
        // Alimentar e libertar
        // ----------------------------------------------

        case 1:
            sprite_consequencia =
                spr_final_cachorro_2;

            frases_consequencia =
            [
                "Alimentado e livre, o cachorro permaneceu ao lado do caçador.",

                "Naquela noite, percebeu a aproximação de um lobo e o protegeu.",

                "Anos mais tarde, o caçador ensinou ao filho tudo o que sabia sobre a floresta. Esse conhecimento permitiu que ele salvasse diversos viajantes perdidos.",

                "Às vezes, cuidar de alguém muda o destino de muitos outros."
            ];
        break;


        // ----------------------------------------------
        // Ignorar ou escolha inválida
        // ----------------------------------------------

        default:
            sprite_consequencia =
                spr_final_cachorro_3;

            frases_consequencia =
            [
                "O cachorro permaneceu preso na armadilha.",

                "Sem sua companhia, o caçador continuou sozinho pela floresta e desapareceu durante uma de suas viagens.",

                "Anos se passaram, mas sua família jamais descobriu o que aconteceu com ele.",

                "Nem toda perda é vista por quem poderia evitá-la."
            ];
        break;
    }
};

#endregion


#region Configurar consequência das sementes

configurar_consequencia_sementes = function()
{
    consequencia_atual = 2;

    titulo_consequencia =
        "As sementes no caminho";

    frase_atual = 0;
    caracteres_visiveis = 0;

    consequencia_concluida = false;
    transicao_consequencia_iniciada = false;


    var _escolha = 1;


    if (
        variable_global_exists(
            "escolha_sementes"
        )
    )
    {
        _escolha =
            global.escolha_sementes;
    }


    switch (_escolha)
    {
        // ----------------------------------------------
        // Amarrar
        // ----------------------------------------------

        case 0:
            sprite_consequencia =
                spr_final_sementes_1;

            frases_consequencia =
            [
                "O rasgo foi fechado antes que mais sementes se perdessem.",

                "A plantação cresceu, e a família pôde permanecer na vila.",

                "Anos mais tarde, uma de suas crianças tornou-se professora, levando conhecimento a dezenas de moradores que nunca haviam aprendido a ler.",

                "Às vezes, um pequeno cuidado cultiva um grande futuro."
            ];
        break;


        // ----------------------------------------------
        // Deixar como está
        // ----------------------------------------------

        case 1:
            sprite_consequencia =
                spr_final_sementes_2;

            frases_consequencia =
            [
                "As sementes continuaram caindo pelo caminho.",

                "Quando chegou o tempo do plantio, não havia o suficiente para cultivar a terra.",

                "A colheita fracassou, e a família abandonou a vila. Com o passar dos anos, o lugar nunca voltou a prosperar como antes.",

                "Algumas ausências crescem lentamente, até mudarem uma comunidade inteira."
            ];
        break;


        // ----------------------------------------------
        // Abrir mais
        // ----------------------------------------------

        case 2:
            sprite_consequencia =
                spr_final_sementes_3;

            frases_consequencia =
            [
                "Mais sementes caíram e foram espalhadas pelos pássaros para além da estrada.",

                "Durante anos, ninguém percebeu o que havia começado ali.",

                "Com o tempo, um pequeno bosque cresceu naquele lugar e passou a proteger viajantes durante fortes tempestades.",

                "Até um erro pode dar origem a algo que ninguém esperava."
            ];
        break;


        // ----------------------------------------------
        // Escolha inválida
        // ----------------------------------------------

        default:
            sprite_consequencia =
                spr_final_sementes_2;

            frases_consequencia =
            [
                "As sementes continuaram caindo pelo caminho.",

                "Quando chegou o tempo do plantio, não havia o suficiente para cultivar a terra.",

                "A colheita fracassou, e a família abandonou a vila. Com o passar dos anos, o lugar nunca voltou a prosperar como antes.",

                "Algumas ausências crescem lentamente, até mudarem uma comunidade inteira."
            ];
        break;
    }
};

#endregion


#region Configurar consequência do brinquedo

configurar_consequencia_brinquedo = function()
{
    consequencia_atual = 3;

    titulo_consequencia =
        "O brinquedo na árvore";

    frase_atual = 0;
    caracteres_visiveis = 0;

    consequencia_concluida = false;
    transicao_consequencia_iniciada = false;


    var _escolha = 2;


    if (
        variable_global_exists(
            "escolha_brinquedo"
        )
    )
    {
        _escolha =
            global.escolha_brinquedo;
    }


    switch (_escolha)
    {
        // ----------------------------------------------
        // Ajudar
        // ----------------------------------------------

        case 0:
            sprite_consequencia =
                spr_final_brinquedo_1;

            frases_consequencia =
            [
                "A criança recuperou o brinquedo e guardou para sempre a lembrança daquele gesto.",

                "Anos mais tarde, ao encontrar crianças que não possuíam família ou abrigo, decidiu ajudá-las da mesma forma que um viajante desconhecido a havia ajudado.",

                "Alguns gestos nunca são esquecidos por quem os recebeu."
            ];
        break;


        // ----------------------------------------------
        // Derrubar com uma pedra
        // ----------------------------------------------

        case 1:
            sprite_consequencia =
                spr_final_brinquedo_2;

            frases_consequencia =
            [
                "O brinquedo caiu da árvore e se quebrou.",

                "A família o levou até um artesão, que conseguiu consertá-lo. Aquele pequeno trabalho despertou nele uma nova vocação.",

                "Anos mais tarde, tornou-se conhecido por fabricar brinquedos para crianças que não podiam comprá-los.",

                "Até aquilo que se quebra pode dar origem a algo bonito."
            ];
        break;


        // ----------------------------------------------
        // Ignorar ou escolha inválida
        // ----------------------------------------------

        default:
            sprite_consequencia =
                spr_final_brinquedo_3;

            frases_consequencia =
            [
                "O mensageiro continuou seu caminho, e a criança permaneceu diante da árvore.",

                "Pouco depois, outro viajante parou para ajudá-la. Aquele encontro deu início a uma amizade que durou muitos anos.",

                "Com o tempo, sua família passou a acolher todos os viajantes que atravessavam aquela estrada.",

                "Quando escolhemos não agir, alguém pode escrever essa história por nós."
            ];
        break;
    }
};

#endregion


#region Bloquear gameplay

global.controle_bloqueado = true;
global.dialogo_ativo = false;

#endregion