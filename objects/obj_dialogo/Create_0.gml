// Evita mais de uma instância do sistema
if (instance_number(obj_dialogo) > 1)
{
    instance_destroy();
    exit;
}


// Referência global
global.dialogo_instancia = id;


// ==================================================
// ESTADO GERAL
// ==================================================

ativo = false;

paginas = [];
pagina_atual = 0;

bloqueio_entrada = 0;
desbloqueio_atrasado = 0;


// ==================================================
// MÁQUINA DE ESCREVER
// ==================================================

texto_visivel = 0;
velocidade_texto = 0.7;

ultimo_caractere_som = 0;
intervalo_som_texto = 2;

pitch_texto_alternado = false;


// ==================================================
// SISTEMA DE ESCOLHAS
// ==================================================

modo_escolha = false;

nome_escolha = "";
texto_escolha = "";

opcoes = [];
opcao_atual = 0;

funcao_escolha = noone;


// ==================================================
// CONFIGURAÇÃO VISUAL
// ==================================================

caixa_x = 64;
caixa_y = 16;

caixa_largura = 512;
caixa_altura = 108;

texto_largura =
    caixa_largura - 56;

texto_altura_com_nome = 52;
texto_altura_sem_nome = 76;


// ==================================================
// PAGINAR DIÁLOGOS
// ==================================================

paginar_dialogo = function(_paginas_originais)
{
    var _paginas_novas = [];


    if (!is_array(_paginas_originais))
    {
        return _paginas_novas;
    }


    // Usa a mesma fonte do Draw GUI
    draw_set_font(fnt_dialogo);


    for (
        var _i = 0;
        _i < array_length(_paginas_originais);
        _i++
    )
    {
        var _pagina_original =
            _paginas_originais[_i];


        if (!is_struct(_pagina_original))
        {
            continue;
        }


        var _nome =
            string(_pagina_original.nome);

        var _texto =
            string(_pagina_original.texto);

        var _tem_nome =
            string_length(_nome) > 0;

        var _altura_maxima;


        if (_tem_nome)
        {
            _altura_maxima =
                texto_altura_com_nome;
        }
        else
        {
            _altura_maxima =
                texto_altura_sem_nome;
        }


        var _palavras =
            string_split(
                _texto,
                " ",
                true
            );

        var _texto_pagina = "";


        for (
            var _j = 0;
            _j < array_length(_palavras);
            _j++
        )
        {
            var _palavra =
                _palavras[_j];

            var _texto_teste;


            if (_texto_pagina == "")
            {
                _texto_teste =
                    _palavra;
            }
            else
            {
                _texto_teste =
                    _texto_pagina
                    + " "
                    + _palavra;
            }


            var _altura_teste =
                string_height_ext(
                    _texto_teste,
                    -1,
                    texto_largura
                );


            if (_altura_teste <= _altura_maxima)
            {
                _texto_pagina =
                    _texto_teste;
            }
            else
            {
                if (_texto_pagina != "")
                {
                    array_push(
                        _paginas_novas,
                        {
                            nome: _nome,
                            texto: _texto_pagina
                        }
                    );
                }


                _texto_pagina =
                    _palavra;
            }
        }


        if (_texto_pagina != "")
        {
            array_push(
                _paginas_novas,
                {
                    nome: _nome,
                    texto: _texto_pagina
                }
            );
        }
    }


    return _paginas_novas;
};


// ==================================================
// ABRIR DIÁLOGO NORMAL
// ==================================================

abrir = function(_paginas)
{
    if (
        ativo
        || !is_array(_paginas)
    )
    {
        return false;
    }


    var _paginas_processadas =
        paginar_dialogo(_paginas);


    if (array_length(_paginas_processadas) <= 0)
    {
        return false;
    }


    paginas =
        _paginas_processadas;

    pagina_atual = 0;
    texto_visivel = 0;

    ultimo_caractere_som = 0;
    pitch_texto_alternado = false;


    modo_escolha = false;

    nome_escolha = "";
    texto_escolha = "";

    opcoes = [];
    opcao_atual = 0;

    funcao_escolha = noone;


    ativo = true;

    bloqueio_entrada = 1;
    desbloqueio_atrasado = 0;

    global.dialogo_ativo = true;
    global.controle_bloqueado = true;


    return true;
};


// ==================================================
// ABRIR ESCOLHA
// ==================================================

abrir_escolha = function(
    _nome,
    _texto,
    _opcoes,
    _funcao
)
{
    if (ativo)
    {
        return false;
    }


    if (
        !is_array(_opcoes)
        || array_length(_opcoes) <= 0
    )
    {
        show_debug_message(
            "ERRO: diálogo de escolha sem opções."
        );

        return false;
    }


    if (!is_method(_funcao))
    {
        show_debug_message(
            "ERRO: callback da escolha inválido."
        );

        return false;
    }


    paginas = [];
    pagina_atual = 0;
    texto_visivel = 0;

    ultimo_caractere_som = 0;


    nome_escolha =
        string(_nome);

    texto_escolha =
        string(_texto);

    opcoes = _opcoes;
    opcao_atual = 0;

    funcao_escolha = _funcao;


    modo_escolha = true;
    ativo = true;

    bloqueio_entrada = 1;
    desbloqueio_atrasado = 0;

    global.dialogo_ativo = true;
    global.controle_bloqueado = true;


    return true;
};


// ==================================================
// FECHAR DIÁLOGO
// ==================================================

fechar = function()
{
    ativo = false;
    modo_escolha = false;

    paginas = [];
    pagina_atual = 0;
    texto_visivel = 0;

    ultimo_caractere_som = 0;

    nome_escolha = "";
    texto_escolha = "";

    opcoes = [];
    opcao_atual = 0;

    funcao_escolha = noone;

    bloqueio_entrada = 0;

    global.dialogo_ativo = false;


    // Aguarda um frame para permitir que o callback
    // abra outro diálogo ou inicie um fade
    desbloqueio_atrasado = 1;
};