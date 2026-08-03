event_inherited();

distancia_interacao = 56;

offset_interacao_x = -56;
offset_interacao_y = 0;
offset_indicador_y = 12;
prioridade_interacao = 10;


// Se a ponte já estiver abaixada
if (global.ponte_abaixada)
{
    sprite_index = spr_ponte_abaixada;
    pode_interagir = false;
}
else
{
    sprite_index = spr_ponte_levantada;

    // A ponte só precisa ser examinada uma vez
    pode_interagir = !global.ponte_descoberta;
}


interagir = function()
{
    if (
        global.ponte_descoberta
        || global.ponte_abaixada
    )
    {
        exit;
    }

    global.ponte_descoberta = true;
    pode_interagir = false;

    global.dialogo_instancia.abrir(
    [
        {
            nome: "Mensageiro",
            texto: "A ponte está completamente levantada."
        },

        {
            nome: "Mensageiro",
            texto: "Deve existir algum mecanismo por perto que controle sua passagem."
        }
    ]);

    show_debug_message(
        "Ponte descoberta: "
        + string(global.ponte_descoberta)
    );
};