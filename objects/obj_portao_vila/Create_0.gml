event_inherited();


#region Configuração da interação

distancia_interacao = 56;
prioridade_interacao = 10;

offset_indicador_y = 12;
indicador_usar_ponto_interacao = true;

// O jogador chega pela esquerda
offset_interacao_x = -24;
offset_interacao_y = 0;


#endregion


#region Restaurar estado do portão

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

    // O portão só precisa ser examinado uma vez
    pode_interagir = !global.portao_descoberto;
}

#endregion


#region Interação

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


    var _dialogo_aberto =
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


    // Libera os diálogos e a missão do agricultor
    // somente se a conversa realmente abrir
    if (_dialogo_aberto)
    {
        global.portao_descoberto = true;
        pode_interagir = false;
    }
};

#endregion