// Evita mais de uma instância do sistema
if (instance_number(obj_dialogo) > 1)
{
    instance_destroy();
    exit;
}

// Referência global para abrir o diálogo
global.dialogo_instancia = id;

// Estado geral
ativo = false;

// Array contendo as páginas atuais
paginas = [];

// Página exibida
pagina_atual = 0;

// Impede o mesmo E que abriu o diálogo
// de avançar imediatamente
bloqueio_entrada = 0;

// Aguarda um frame antes de devolver
// o controle ao jogador
desbloqueio_atrasado = 0;

// Máquina de escrever
texto_visivel = 0;

// Caracteres adicionados por frame
velocidade_texto = 0.7;

// Controle do som da máquina de escrever
ultimo_caractere_som = 0;

// Toca um som a cada 2 caracteres
intervalo_som_texto = 2;

// Sistema de escolhas
modo_escolha = false;

nome_escolha = "";
texto_escolha = "";

opcoes = [];
opcao_atual = 0;

funcao_escolha = noone;

// ==================================================
// CONFIGURAÇÃO VISUAL DO DIÁLOGO
// ==================================================

caixa_x = 64;
caixa_y = 16;
caixa_largura = 512;
caixa_altura = 108;

// Espaço lateral, incluindo o indicador E
texto_largura = caixa_largura - 56;

// Espaço disponível quando existe nome
texto_altura_com_nome = 52;

// Espaço disponível para mensagens sem nome
texto_altura_sem_nome = 76;

paginar_dialogo = function(_paginas_originais)
{
    var _paginas_novas = [];

    // A medição precisa usar a mesma fonte do Draw GUI
    draw_set_font(fnt_dialogo);

    for (
        var _i = 0;
        _i < array_length(_paginas_originais);
        _i++
    )
    {
        var _pagina_original = _paginas_originais[_i];

        var _nome = _pagina_original.nome;
        var _texto = string(_pagina_original.texto);

        var _tem_nome = string_length(_nome) > 0;

        var _altura_maxima;

        if (_tem_nome)
        {
            _altura_maxima = texto_altura_com_nome;
        }
        else
        {
            _altura_maxima = texto_altura_sem_nome;
        }


        // Separa a mensagem em palavras
        var _palavras = string_split(
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
            var _palavra = _palavras[_j];
            var _texto_teste;


            if (_texto_pagina == "")
            {
                _texto_teste = _palavra;
            }
            else
            {
                _texto_teste =
                    _texto_pagina
                    + " "
                    + _palavra;
            }


            // Mede como o texto ficaria com quebra de linha
            var _altura_teste = string_height_ext(
                _texto_teste,
                -1,
                texto_largura
            );


            if (_altura_teste <= _altura_maxima)
            {
                _texto_pagina = _texto_teste;
            }
            else
            {
                // Salva a parte que já cabe
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

                // Começa uma nova página
                _texto_pagina = _palavra;
            }
        }


        // Salva o texto restante
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


// Abre um novo diálogo
abrir = function(_paginas)
{
    if (ativo)
    {
        exit;
    }

    paginas = paginar_dialogo(_paginas);

    pagina_atual = 0;
    texto_visivel = 0;
    
    ultimo_caractere_som = 0;

    modo_escolha = false;

    ativo = true;
    bloqueio_entrada = 1;
    desbloqueio_atrasado = 0;

    global.dialogo_ativo = true;
    global.controle_bloqueado = true;
};

abrir_escolha = function(
    _nome,
    _texto,
    _opcoes,
    _funcao
)
{
    if (ativo)
    {
        exit;
    }

    nome_escolha = _nome;
    texto_escolha = _texto;

    opcoes = _opcoes;
    opcao_atual = 0;

    funcao_escolha = _funcao;

    modo_escolha = true;
    ativo = true;

    bloqueio_entrada = 1;
    desbloqueio_atrasado = 0;

    global.dialogo_ativo = true;
    global.controle_bloqueado = true;
};


// Fecha o diálogo
fechar = function()
{
    ativo = false;
    modo_escolha = false;

    paginas = [];
    pagina_atual = 0;
    texto_visivel = 0;

    opcoes = [];
    opcao_atual = 0;
    funcao_escolha = noone;

    global.dialogo_ativo = false;

    desbloqueio_atrasado = 1;
};