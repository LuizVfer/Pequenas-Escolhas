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
    // PORTÃO JÁ ESTÁ ABERTO
    // ==================================================

    if (global.portao_aberto)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Moradora",
                texto:
                    "O agricultor conseguiu abrir o portão."
            },

            {
                nome: "Moradora",
                texto:
                    "Boa viagem, mensageiro."
            }
        ]);

        exit;
    }


    // ==================================================
    // JOGADOR AINDA NÃO DESCOBRIU O PORTÃO
    // ==================================================

    if (!global.portao_descoberto)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Moradora",
                texto:
                    "A colheita tem exigido muito trabalho este ano."
            }
        ]);

        exit;
    }


    // ==================================================
    // JOGADOR AINDA NÃO FALOU COM O AGRICULTOR
    // ==================================================

    if (!global.quest_cabo_iniciada)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Moradora",
                texto:
                    "O agricultor trabalha perto da plantação."
            },

            {
                nome: "Moradora",
                texto:
                    "Talvez ele saiba como abrir o portão."
            }
        ]);

        exit;
    }


    // ==================================================
    // CABO JÁ FOI ENTREGUE
    // ==================================================

    if (global.cabo_enxada_entregue)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Moradora",
                texto:
                    "O agricultor já recebeu o cabo da enxada."
            },

            {
                nome: "Moradora",
                texto:
                    "Ele deve abrir o portão assim que terminar o trabalho."
            }
        ]);

        exit;
    }


    // ==================================================
    // JOGADOR ESTÁ COM O CABO
    // ==================================================

    if (global.cabo_enxada_coletado)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Moradora",
                texto:
                    "Esse cabo deve servir na enxada do agricultor."
            },

            {
                nome: "Moradora",
                texto:
                    "Ele está trabalhando perto da plantação."
            }
        ]);

        exit;
    }


    // ==================================================
    // JOGADOR ESTÁ COM O BALDE CHEIO
    // ==================================================

    if (global.balde_cheio)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Moradora",
                texto:
                    "Aquele morador perto das casas estava procurando água."
            }
        ]);

        exit;
    }


    // ==================================================
    // JOGADOR ESTÁ COM O BALDE VAZIO
    // ==================================================

    if (global.balde_coletado)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Moradora",
                texto:
                    "Você pode encher esse balde no poço."
            }
        ]);

        exit;
    }


    // ==================================================
    // MISSÃO DA ÁGUA JÁ FOI INICIADA
    // ==================================================

    if (global.quest_agua_iniciada)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Moradora",
                texto:
                    "Acho que vi um balde vazio perto das casas."
            },

            {
                nome: "Moradora",
                texto:
                    "Talvez ainda esteja por lá."
            }
        ]);

        exit;
    }


    // ==================================================
    // DIRECIONAR PARA O MORADOR PERTO DAS CASAS
    // ==================================================

    global.dialogo_instancia.abrir(
    [
        {
            nome: "Moradora",
            texto:
                "Ouvi dizer que alguém perto das casas encontrou um cabo de enxada."
        },

        {
            nome: "Moradora",
            texto:
                "Talvez possa ajudá-lo."
        }
    ]);
};

#endregion