event_inherited();


#region Configuração da interação

distancia_interacao = 48;
offset_indicador_y = 12;
prioridade_interacao = 0;

pode_interagir = true;

#endregion


#region Interação

interagir = function()
{
    if (!pode_interagir)
    {
        exit;
    }


    // ==================================================
    // JOGADOR AINDA NÃO DESCOBRIU O PROBLEMA DO CABO
    // ==================================================

    if (!global.quest_cabo_iniciada)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Morador",
                texto:
                    "O trabalho anda pesado por aqui."
            }
        ]);

        exit;
    }


    // ==================================================
    // AJUDA JÁ CONCLUÍDA
    // ==================================================

    if (global.morador_recebeu_agua)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Morador",
                texto:
                    "Espero que aquele cabo seja útil ao agricultor."
            }
        ]);

        exit;
    }


    // ==================================================
    // INICIAR MISSÃO DA ÁGUA
    // ==================================================

    if (!global.quest_agua_iniciada)
    {
        var _dialogo_missao_aberto =
            global.dialogo_instancia.abrir(
            [
                {
                    nome: "Morador",
                    texto:
                        "Encontrei um cabo de enxada perto das casas."
                },

                {
                    nome: "Morador",
                    texto:
                        "Posso entregá-lo, mas antes preciso de água."
                },

                {
                    nome: "Morador",
                    texto:
                        "Há um balde vazio por aqui. Encha-o no poço."
                }
            ]);


        // Libera a procura pelo balde somente
        // quando o diálogo realmente abrir
        if (_dialogo_missao_aberto)
        {
            global.quest_agua_iniciada = true;
        }

        exit;
    }


    // ==================================================
    // JOGADOR AINDA NÃO ENCONTROU O BALDE
    // ==================================================

    if (!global.balde_coletado)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Morador",
                texto:
                    "Procure o balde vazio perto das casas."
            },

            {
                nome: "Morador",
                texto:
                    "Depois, encha-o no poço e traga a água para mim."
            }
        ]);

        exit;
    }


    // ==================================================
    // JOGADOR ESTÁ COM O BALDE VAZIO
    // ==================================================

    if (!global.balde_cheio)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Morador",
                texto:
                    "Você encontrou o balde."
            },

            {
                nome: "Morador",
                texto:
                    "Encha-o no poço e traga a água para mim."
            }
        ]);

        exit;
    }


    // ==================================================
    // ENTREGAR A ÁGUA E RECEBER O CABO
    // ==================================================

    var _dialogo_entrega_aberto =
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Morador",
                texto:
                    "Obrigado. Eu precisava muito dessa água."
            },

            {
                nome: "Morador",
                texto:
                    "Como prometido, fique com este cabo de enxada."
            },

            {
                nome: "",
                texto:
                    "Você recebeu o cabo da enxada."
            }
        ]);


    // A água só é entregue e o cabo só é recebido
    // quando o diálogo realmente conseguir abrir
    if (_dialogo_entrega_aberto)
    {
        global.balde_cheio = false;
        global.morador_recebeu_agua = true;
        global.cabo_enxada_coletado = true;
    }
};

#endregion