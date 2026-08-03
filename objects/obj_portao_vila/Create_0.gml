event_inherited();

distancia_interacao = 56;
offset_indicador_y = 12;
prioridade_interacao = 10;

// Como o player chega pela esquerda
offset_interacao_x = -24;
offset_interacao_y = 0;


if (global.portao_aberto)
{
    sprite_index = spr_portao_aberto;
    pode_interagir = false;
}
else
{
    sprite_index = spr_portao_fechado;
    pode_interagir = !global.portao_descoberto;
}


interagir = function()
{
    if (
        global.portao_descoberto
        || global.portao_aberto
    )
    {
        exit;
    }

    global.portao_descoberto = true;
    pode_interagir = false;

    global.dialogo_instancia.abrir(
    [
        {
            nome: "Mensageiro",
            texto: "O portão está fechado."
        },

        {
            nome: "Mensageiro",
            texto: "Talvez alguém nesta vila saiba como abri-lo."
        }
    ]);

    show_debug_message(
        "Portão descoberto: "
        + string(global.portao_descoberto)
    );
};