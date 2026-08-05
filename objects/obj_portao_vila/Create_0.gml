event_inherited();


#region Configuração da interação

distancia_interacao = 56;
prioridade_interacao = 10;

offset_indicador_y = 12;

// O jogador chega pela esquerda
offset_interacao_x = -24;
offset_interacao_y = 0;

#endregion


#region Estado inicial do portão

image_index = 0;
image_speed = 0;


if (global.portao_aberto)
{
    sprite_index = spr_portao_aberto;
    pode_interagir = false;
}
else
{
    sprite_index = spr_portao_fechado;

    pode_interagir =
        !global.portao_descoberto;
}

#endregion


#region Função de interação

interagir = function()
{
    if (
        global.portao_descoberto
        || global.portao_aberto
        || !pode_interagir
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
            texto:
                "O portão está fechado."
        },

        {
            nome: "Mensageiro",
            texto:
                "Talvez alguém nesta vila saiba como abri-lo."
        }
    ]);
};

#endregion