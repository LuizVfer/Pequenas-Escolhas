// ==================================================
// LIBERAR CONTROLE APÓS FECHAR
// ==================================================

if (desbloqueio_atrasado > 0)
{
    desbloqueio_atrasado--;


    if (desbloqueio_atrasado <= 0)
    {
        var _fade_ativo = false;


        if (
            variable_global_exists(
                "fade_instancia"
            )
            && instance_exists(
                global.fade_instancia
            )
        )
        {
            _fade_ativo =
                global.fade_instancia.ativo;
        }


        // Um diálogo pode ter sido aberto novamente
        // durante o callback anterior
        if (
            ativo
            || global.dialogo_ativo
            || _fade_ativo
        )
        {
            global.controle_bloqueado = true;
        }
        else
        {
            global.controle_bloqueado = false;
        }
    }


    exit;
}


// ==================================================
// DIÁLOGO FECHADO
// ==================================================

if (!ativo)
{
    exit;
}


// Impede o E que abriu o diálogo
// de avançá-lo no mesmo frame
if (bloqueio_entrada > 0)
{
    bloqueio_entrada--;

    exit;
}


// ==================================================
// ESCOLHAS
// ==================================================

if (modo_escolha)
{
    var _quantidade =
        array_length(opcoes);


    // Proteção contra uma escolha inválida
    if (_quantidade <= 0)
    {
        show_debug_message(
            "ERRO: diálogo de escolha sem opções."
        );

        fechar();

        exit;
    }


    var _cima =
        keyboard_check_pressed(vk_up)
        || keyboard_check_pressed(ord("W"));

    var _baixo =
        keyboard_check_pressed(vk_down)
        || keyboard_check_pressed(ord("S"));

    var _confirmar =
        keyboard_check_pressed(ord("E"))
        || keyboard_check_pressed(vk_enter);


    var _opcao_antes =
        opcao_atual;


    // Mover para cima
    if (_cima)
    {
        opcao_atual =
            (
                opcao_atual
                - 1
                + _quantidade
            )
            mod _quantidade;
    }


    // Mover para baixo
    if (_baixo)
    {
        opcao_atual =
            (
                opcao_atual
                + 1
            )
            mod _quantidade;
    }


    // Som de navegação
    if (opcao_atual != _opcao_antes)
    {
        var _som_mover =
            audio_play_sound(
                snd_opcao_mover,
                0,
                false
            );


        audio_sound_gain(
            _som_mover,
            0.35,
            0
        );

        audio_sound_pitch(
            _som_mover,
            0.90
        );
    }


    // Confirmar opção
    if (_confirmar)
    {
        var _som_confirmar =
            audio_play_sound(
                snd_opcao_confirmar,
                1,
                false
            );


        audio_sound_gain(
            _som_confirmar,
            0.55,
            0
        );


        var _resultado =
            opcao_atual;

        var _funcao =
            funcao_escolha;


        // Fecha antes do callback para permitir
        // que ele abra o diálogo de resultado
        fechar();


        if (is_method(_funcao))
        {
            method_call(
                _funcao,
                [_resultado]
            );
        }
        else
        {
            show_debug_message(
                "ERRO: callback da escolha inválido."
            );
        }
    }


    exit;
}


// ==================================================
// VERIFICAR PÁGINA ATUAL
// ==================================================

var _quantidade_paginas =
    array_length(paginas);


if (_quantidade_paginas <= 0)
{
    fechar();

    exit;
}


pagina_atual =
    clamp(
        pagina_atual,
        0,
        _quantidade_paginas - 1
    );


var _texto_atual =
    string(
        paginas[pagina_atual].texto
    );

var _tamanho_texto =
    string_length(_texto_atual);


// ==================================================
// MÁQUINA DE ESCREVER
// ==================================================

if (texto_visivel < _tamanho_texto)
{
    var _caracteres_antes =
        floor(texto_visivel);


    texto_visivel =
        min(
            texto_visivel
            + velocidade_texto,

            _tamanho_texto
        );


    var _caracteres_agora =
        floor(texto_visivel);


    if (_caracteres_agora > _caracteres_antes)
    {
        if (
            _caracteres_agora
            >= ultimo_caractere_som
            + intervalo_som_texto
        )
        {
            ultimo_caractere_som =
                _caracteres_agora;


            // Evita muitos sons sobrepostos
            if (!audio_is_playing(snd_texto))
            {
                var _som_texto =
                    audio_play_sound(
                        snd_texto,
                        0,
                        false
                    );


                var _pitch_texto = 1.30;


                if (pitch_texto_alternado)
                {
                    _pitch_texto = 1.50;
                }


                pitch_texto_alternado =
                    !pitch_texto_alternado;


                audio_sound_pitch(
                    _som_texto,
                    _pitch_texto
                );
            }
        }
    }
}


// ==================================================
// AVANÇAR TEXTO
// ==================================================

var _confirmar =
    keyboard_check_pressed(ord("E"))
    || keyboard_check_pressed(vk_enter);


if (_confirmar)
{
    // Completa imediatamente a máquina de escrever
    if (texto_visivel < _tamanho_texto)
    {
        texto_visivel =
            _tamanho_texto;

        ultimo_caractere_som =
            _tamanho_texto;
    }

    // Avança para a próxima página
    else
    {
        pagina_atual++;


        if (
            pagina_atual
            >= array_length(paginas)
        )
        {
            fechar();
        }
        else
        {
            texto_visivel = 0;
            ultimo_caractere_som = 0;
            pitch_texto_alternado = false;
        }
    }
}