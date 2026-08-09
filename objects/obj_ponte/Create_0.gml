event_inherited();


#region Configuração da interação

distancia_interacao = 56;
prioridade_interacao = 10;

// Aproxima o ponto de interação da extremidade
// acessível da ponte levantada
offset_interacao_x = -120;
offset_interacao_y = -48;

offset_indicador_y = 12;

#endregion


#region Restaurar estado visual

image_index = 0;
image_speed = 0;


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

#endregion


#region Interação

interagir = function()
{
    if (
        global.ponte_descoberta
        || global.ponte_abaixada
        || !pode_interagir
    )
    {
        exit;
    }


    var _dialogo_aberto =
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Mensageiro",
                texto: "A ponte está completamente levantada."
            },

            {
                nome: "Mensageiro",
                texto: "Deve existir algum mecanismo por perto capaz de baixá-la."
            }
        ]);


    // Libera o mecanismo somente se o diálogo
    // realmente conseguir abrir
    if (_dialogo_aberto)
    {
        global.ponte_descoberta = true;
        pode_interagir = false;

        show_debug_message(
            "Ponte descoberta: "
            + string(global.ponte_descoberta)
        );
    }
};

#endregion