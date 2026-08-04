// Evita objetos duplicados
if (instance_number(obj_fade) > 1)
{
    instance_destroy();
    exit;
}


// Referência global
global.fade_instancia = id;


// Estado do fade
ativo = false;
alpha_fade = 0;

// 0 = escurecendo
// 1 = clareando
fase_fade = 0;

duracao_preto = 45;
contador_preto = 0;
velocidade_fade = 0.03;
funcao_meio = noone;


// Inicia um fade completo
iniciar = function(
    _funcao = noone,
    _velocidade = 0.05,
    _duracao_preto = 45
)
{
    // Já existe outro fade acontecendo
    if (ativo)
    {
        // Garante que o jogador continue bloqueado
        global.controle_bloqueado = true;

        return false;
    }


    ativo = true;
    alpha_fade = 0;
    fase_fade = 0;

    velocidade_fade = _velocidade;
    duracao_preto = _duracao_preto;
    contador_preto = 0;

    funcao_meio = _funcao;

    global.controle_bloqueado = true;

    // Informa que o fade começou corretamente
    return true;
};