if (!ativo)
{
    exit;
}


// ==================================================
// ESCURECENDO
// ==================================================

if (fase_fade == FASE_ESCURECENDO)
{
    alpha_fade =
        min(
            alpha_fade
                + velocidade_fade,

            1
        );


    if (alpha_fade >= 1)
    {
        alpha_fade = 1;

        fase_fade = FASE_PRETO;
        contador_preto = duracao_preto;


        // Limpa antes de executar para garantir
        // que o callback aconteça somente uma vez
        var _funcao =
            funcao_meio;

        funcao_meio = noone;


        if (_funcao != noone)
        {
            if (is_method(_funcao))
            {
                method_call(
                    _funcao,
                    []
                );
            }
            else
            {
                show_debug_message(
                    "ERRO: callback perdido durante o fade."
                );
            }
        }
    }


    exit;
}


// ==================================================
// TELA TOTALMENTE PRETA
// ==================================================

if (fase_fade == FASE_PRETO)
{
    contador_preto =
        max(
            contador_preto - 1,
            0
        );


    if (contador_preto <= 0)
    {
        fase_fade =
            FASE_CLAREANDO;
    }


    exit;
}


// ==================================================
// CLAREANDO
// ==================================================

if (fase_fade == FASE_CLAREANDO)
{
    alpha_fade =
        max(
            alpha_fade
                - velocidade_fade,

            0
        );


    if (alpha_fade <= 0)
    {
        alpha_fade = 0;

        ativo = false;
        fase_fade = FASE_ESCURECENDO;

        contador_preto = 0;
        funcao_meio = noone;


        // ----------------------------------------------
        // Verificar se um diálogo continua ativo
        // ----------------------------------------------

        var _dialogo_ativo = false;


        if (
            variable_global_exists(
                "dialogo_ativo"
            )
        )
        {
            _dialogo_ativo =
                global.dialogo_ativo;
        }


        if (
            variable_global_exists(
                "dialogo_instancia"
            )
            && instance_exists(
                global.dialogo_instancia
            )
        )
        {
            _dialogo_ativo =
                _dialogo_ativo
                || global.dialogo_instancia.ativo;
        }


        // ----------------------------------------------
        // Verificar se a pausa continua aberta
        // ----------------------------------------------

        var _pausa_ativa = false;

        var _pausa =
            instance_find(
                obj_pausa,
                0
            );


        if (_pausa != noone)
        {
            _pausa_ativa =
                _pausa.pausa_ativa;
        }


        // O fade libera o jogador somente quando
        // nenhum outro sistema precisa do bloqueio
        global.controle_bloqueado =
            _dialogo_ativo
            || _pausa_ativa;
    }


    exit;
}


// ==================================================
// PROTEÇÃO CONTRA FASE INVÁLIDA
// ==================================================

show_debug_message(
    "ERRO: fase inválida no obj_fade."
);

alpha_fade = 0;
ativo = false;

fase_fade = FASE_ESCURECENDO;
contador_preto = 0;
funcao_meio = noone;