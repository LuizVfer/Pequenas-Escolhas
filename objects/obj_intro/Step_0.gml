#region Bloquear gameplay

// O controle deve permanecer bloqueado
// durante toda a introdução
global.controle_bloqueado = true;

#endregion


#region Aguardar fade

if (fade_intro_ativo())
{
    parar_som_lapis();
    exit;
}

#endregion


#region Entrada do jogador

var _confirmar =
    keyboard_check_pressed(
        ord("E")
    )
    || keyboard_check_pressed(
        vk_enter
    );

#endregion


#region Textos da introdução

if (estado_intro == ESTADO_TEXTOS)
{
    var _quantidade_frases =
        array_length(
            frases_intro
        );


    if (_quantidade_frases <= 0)
    {
        parar_som_lapis();

        show_debug_message(
            "ERRO: introdução sem frases."
        );

        estado_intro = ESTADO_TITULO;
        alpha_titulo = 0;

        exit;
    }


    frase_atual =
        clamp(
            frase_atual,
            0,
            _quantidade_frases - 1
        );


    var _frase =
        string(
            frases_intro[
                frase_atual
            ]
        );


    var _tamanho =
        string_length(
            _frase
        );


    // ----------------------------------------------
    // Máquina de escrever
    // ----------------------------------------------

    if (caracteres_visiveis < _tamanho)
    {
        iniciar_som_lapis();


        caracteres_visiveis =
            min(
                caracteres_visiveis
                    + velocidade_texto,

                _tamanho
            );


        if (
            caracteres_visiveis
            >= _tamanho
        )
        {
            parar_som_lapis();
        }
    }
    else
    {
        parar_som_lapis();
    }


    if (!_confirmar)
    {
        exit;
    }


    // ----------------------------------------------
    // Completar a frase atual
    // ----------------------------------------------

    if (caracteres_visiveis < _tamanho)
    {
        caracteres_visiveis =
            _tamanho;

        parar_som_lapis();

        exit;
    }


    if (transicao_iniciada)
    {
        exit;
    }


    // ----------------------------------------------
    // Próxima frase
    // ----------------------------------------------

    if (
        frase_atual
        < _quantidade_frases - 1
    )
    {
        var _mostrar_proxima_frase =
            method(
                id,

                function()
                {
                    frase_atual++;

                    caracteres_visiveis = 0;

                    transicao_iniciada =
                        false;
                }
            );


        transicao_iniciada =
            iniciar_fade_intro(
                _mostrar_proxima_frase,
                0.05,
                15
            );


        exit;
    }


    // ----------------------------------------------
    // Mostrar o título
    // ----------------------------------------------

    var _mostrar_titulo =
        method(
            id,

            function()
            {
                parar_som_lapis();

                estado_intro =
                    ESTADO_TITULO;

                alpha_titulo = 0;

                transicao_iniciada =
                    false;
            }
        );


    transicao_iniciada =
        iniciar_fade_intro(
            _mostrar_titulo,
            0.04,
            30
        );


    exit;
}

#endregion


#region Título do jogo

if (estado_intro == ESTADO_TITULO)
{
    parar_som_lapis();


    alpha_titulo =
        min(
            alpha_titulo
                + velocidade_alpha_titulo,

            1
        );


    if (
        !_confirmar
        || alpha_titulo < 1
        || transicao_iniciada
    )
    {
        exit;
    }


    var _entrar_na_cidade =
        method(
            id,

            function()
            {
                parar_som_lapis();


                // Entrada inicial do Capítulo 1
                global.usar_spawn = true;

                global.spawn_x = 96;
                global.spawn_y = 304;


                global.controle_bloqueado =
                    false;


                room_goto(
                    rm_cidade
                );
            }
        );


    transicao_iniciada =
        iniciar_fade_intro(
            _entrar_na_cidade,
            0.03,
            45
        );


    exit;
}

#endregion


#region Proteção contra estado inválido

parar_som_lapis();


show_debug_message(
    "ERRO: estado inválido no obj_intro."
);


estado_intro = ESTADO_TEXTOS;

frase_atual = 0;
caracteres_visiveis = 0;

alpha_titulo = 0;

transicao_iniciada = false;

#endregion