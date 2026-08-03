if (!ativo)
{
    exit;
}


// ==================================================
// FASE 0 — ESCURECENDO
// ==================================================

if (fase_fade == 0)
{
    alpha_fade = min(
        alpha_fade + velocidade_fade,
        1
    );

    if (alpha_fade >= 1)
    {
        alpha_fade = 1;

        var _funcao = funcao_meio;
        funcao_meio = noone;

        if (_funcao != noone)
        {
            _funcao();
        }

        // Começa a espera com a tela preta
        contador_preto = duracao_preto;
        fase_fade = 1;
    }
}


// ==================================================
// FASE 1 — TELA TOTALMENTE PRETA
// ==================================================

else if (fase_fade == 1)
{
    contador_preto--;

    if (contador_preto <= 0)
    {
        fase_fade = 2;
    }
}


// ==================================================
// FASE 2 — CLAREANDO
// ==================================================

else
{
    alpha_fade = max(
        alpha_fade - velocidade_fade,
        0
    );

    if (alpha_fade <= 0)
    {
        alpha_fade = 0;
        ativo = false;
        fase_fade = 0;

        if (!global.dialogo_ativo)
        {
            global.controle_bloqueado = false;
        }
    }
}