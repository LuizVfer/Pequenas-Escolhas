// Libera o controle após fechar
if (desbloqueio_atrasado > 0)
{
    desbloqueio_atrasado--;

    if (desbloqueio_atrasado <= 0)
    {
        global.controle_bloqueado = false;
    }

    exit;
}


// Diálogo fechado
if (!ativo)
{
    exit;
}


// Evita que o mesmo E usado para abrir avance
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
    var _quantidade = array_length(opcoes);

    var _cima =
        keyboard_check_pressed(vk_up)
        || keyboard_check_pressed(ord("W"));

    var _baixo =
        keyboard_check_pressed(vk_down)
        || keyboard_check_pressed(ord("S"));

    var _confirmar =
        keyboard_check_pressed(ord("E"))
        || keyboard_check_pressed(vk_enter);


    if (_cima)
    {
        opcao_atual =
            (opcao_atual - 1 + _quantidade)
            mod _quantidade;
    }


    if (_baixo)
    {
        opcao_atual =
            (opcao_atual + 1)
            mod _quantidade;
    }


    if (_confirmar)
    {
        var _resultado = opcao_atual;
        var _funcao = funcao_escolha;

        fechar();

        if (_funcao != noone)
        {
            _funcao(_resultado);
        }
    }

    exit;
}


// Texto da página atual
var _texto_atual = paginas[pagina_atual].texto;
var _tamanho_texto = string_length(_texto_atual);




// Máquina de escrever
if (texto_visivel < _tamanho_texto)
{
    texto_visivel = min(
        texto_visivel + velocidade_texto,
        _tamanho_texto
    );
}


var _confirmar =
    keyboard_check_pressed(ord("E"))
    || keyboard_check_pressed(vk_enter);


if (_confirmar)
{
    if (texto_visivel < _tamanho_texto)
    {
        texto_visivel = _tamanho_texto;
    }
    else
    {
        pagina_atual++;

        if (pagina_atual >= array_length(paginas))
        {
            fechar();
        }
        else
        {
            texto_visivel = 0;
        }
    }
}

