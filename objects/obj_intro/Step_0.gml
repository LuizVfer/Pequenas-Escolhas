// ==================================================
// AGUARDA O FADE TERMINAR
// ==================================================

if (
    instance_exists(global.fade_instancia)
    && global.fade_instancia.ativo
)
{
    exit;
}


var _confirmar =
    keyboard_check_pressed(ord("E"))
    || keyboard_check_pressed(vk_enter);


// ==================================================
// ESTADO 0 — TEXTOS DA INTRODUÇÃO
// ==================================================

if (estado_intro == 0)
{
    var _frase =
        frases_intro[frase_atual];

    var _tamanho =
        string_length(_frase);


    // Máquina de escrever
    if (caracteres_visiveis < _tamanho)
    {
        caracteres_visiveis = min(
            caracteres_visiveis + velocidade_texto,
            _tamanho
        );
    }


    if (_confirmar)
    {
        // Completa imediatamente a frase
        if (caracteres_visiveis < _tamanho)
        {
            caracteres_visiveis = _tamanho;
        }

        // Próxima frase
        else if (
            frase_atual
            < array_length(frases_intro) - 1
        )
        {
            if (!transicao_iniciada)
            {
                transicao_iniciada = true;


                var _proxima_frase = method(
                    id,

                    function()
                    {
                        frase_atual++;
                        caracteres_visiveis = 0;
                        transicao_iniciada = false;
                    }
                );


                global.fade_instancia.iniciar(
                    _proxima_frase,
                    0.05,
                    15
                );
            }
        }

        // Terminou a introdução: mostra o título
        else
        {
            if (!transicao_iniciada)
            {
                transicao_iniciada = true;


                var _mostrar_titulo = method(
                    id,

                    function()
                    {
                        estado_intro = 1;
                        alpha_titulo = 0;
                        transicao_iniciada = false;
                    }
                );


                global.fade_instancia.iniciar(
                    _mostrar_titulo,
                    0.04,
                    30
                );
            }
        }
    }

    exit;
}


// ==================================================
// ESTADO 1 — TÍTULO DO JOGO
// ==================================================

if (estado_intro == 1)
{
    alpha_titulo = min(
        alpha_titulo + velocidade_alpha_titulo,
        1
    );


    if (
        _confirmar
        && alpha_titulo >= 1
        && !transicao_iniciada
    )
    {
        transicao_iniciada = true;


        var _entrar_na_cidade = method(
            id,

            function()
            {
                // Entrada inicial do Capítulo 1
                global.usar_spawn = true;
                global.spawn_x = 96;
                global.spawn_y = 304;

                global.controle_bloqueado = false;

                room_goto(rm_destino);
            }
        );


        global.fade_instancia.iniciar(
            _entrar_na_cidade,
            0.03,
            45
        );
    }

    exit;
}