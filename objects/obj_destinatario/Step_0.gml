if (global.carta_entregue)
{
    pode_interagir = false;
    exit;
}


if (!aguardando_final)
{
    pode_interagir = true;
    exit;
}


pode_interagir = false;


// Aguarda o diálogo terminar
if (
    global.dialogo_ativo
    || transicao_iniciada
)
{
    exit;
}


// ==================================================
// IR PARA O FINAL
// ==================================================

transicao_iniciada = true;


var _iniciar_final = method(
    id,

    function()
    {
        global.carta_entregue = true;
        global.usar_spawn = false;

        room_goto(rm_final_livro);
    }
);


global.fade_instancia.iniciar(
    _iniciar_final,
    0.03,
    60
);