#region Evitar duplicação

if (instance_number(obj_fade) > 1)
{
    instance_destroy();
    exit;
}

#endregion


#region Referência global

global.fade_instancia = id;

#endregion


#region Estados do fade

FASE_ESCURECENDO = 0;
FASE_PRETO = 1;
FASE_CLAREANDO = 2;


ativo = false;

alpha_fade = 0;
fase_fade = FASE_ESCURECENDO;

velocidade_fade = 0.05;

duracao_preto = 45;
contador_preto = 0;

funcao_meio = noone;

#endregion


#region Iniciar fade

iniciar = function(
    _funcao = noone,
    _velocidade = 0.05,
    _duracao_preto = 45
)
{
    // Impede dois fades simultâneos
    if (ativo)
    {
        global.controle_bloqueado = true;

        return false;
    }


    // O callback é opcional, mas precisa ser um método
    if (
        _funcao != noone
        && !is_method(_funcao)
    )
    {
        show_debug_message(
            "ERRO: callback inválido no obj_fade."
        );

        return false;
    }


    // Evita uma velocidade inválida ou igual a zero
    if (
        !is_real(_velocidade)
        || _velocidade <= 0
    )
    {
        show_debug_message(
            "ERRO: velocidade inválida no obj_fade."
        );

        return false;
    }


    if (!is_real(_duracao_preto))
    {
        show_debug_message(
            "ERRO: duração inválida no obj_fade."
        );

        return false;
    }


    ativo = true;

    alpha_fade = 0;
    fase_fade = FASE_ESCURECENDO;

    velocidade_fade =
        clamp(
            _velocidade,
            0.001,
            1
        );

    duracao_preto =
        max(
            0,
            round(_duracao_preto)
        );

    contador_preto = 0;

    funcao_meio = _funcao;


    global.controle_bloqueado = true;


    return true;
};

#endregion