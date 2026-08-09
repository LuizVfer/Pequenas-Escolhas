event_inherited();


#region Configuração da interação

distancia_interacao = 56;
prioridade_interacao = 10;

offset_indicador_y = 12;
indicador_usar_ponto_interacao = true;

// Ponto de interação na frente do portão
offset_interacao_x = -24;
offset_interacao_y = 0;

#endregion


#region Controle da saída

// Impede que a transição seja iniciada
// mais de uma vez
transicao_saida_iniciada = false;

#endregion


#region Restaurar estado do portão

image_index = 0;
image_speed = 0;


if (global.portao_aberto)
{
    sprite_index = spr_portao_aberto;

    // Quando aberto, permite entrar
    pode_interagir = true;
}
else
{
    sprite_index = spr_portao_fechado;

    // O portão fechado só precisa
    // ser examinado uma vez
    pode_interagir =
        !global.portao_descoberto;
}

#endregion


#region Interação

interagir = function()
{
    if (
        !pode_interagir
        || transicao_saida_iniciada
    )
    {
        exit;
    }


    // ==================================================
    // PORTÃO ABERTO: ENTRAR
    // ==================================================

    if (global.portao_aberto)
    {
        // Segurança: sistema de fade não existe
        if (
            !instance_exists(
                global.fade_instancia
            )
        )
        {
            show_debug_message(
                "ERRO: obj_fade não encontrado."
            );

            exit;
        }


        // Executado quando a tela estiver preta
        var _entrar_portao = method(
            id,

            function()
            {
                global.spawn_x = 96;
                global.spawn_y = 304;
                global.usar_spawn = true;

                room_goto(rm_destino);
            }
        );


        var _fade_iniciado =
            global.fade_instancia.iniciar(
                _entrar_portao,
                0.05,
                45
            );


        if (_fade_iniciado)
        {
            transicao_saida_iniciada = true;
            pode_interagir = false;
        }


        exit;
    }


    // ==================================================
    // PORTÃO FECHADO: DESCOBRIR OBJETIVO
    // ==================================================

    if (global.portao_descoberto)
    {
        pode_interagir = false;
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