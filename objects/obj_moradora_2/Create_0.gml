event_inherited();

distancia_interacao = 48;
offset_indicador_y = 12;
prioridade_interacao = 0;


interagir = function()
{
    if (!pode_interagir)
    {
        exit;
    }


    // O cabo já foi entregue ao agricultor
    if (global.cabo_enxada_entregue)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Morador",
                texto:
                    "Parece que o agricultor finalmente terminou o trabalho."
            }
        ]);

        exit;
    }


    // Jogador já recebeu o cabo
    if (global.cabo_enxada_coletado)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Morador",
                texto:
                    "Esse cabo deve pertencer ao agricultor."
            },
            {
                nome: "Morador",
                texto:
                    "Ele está trabalhando perto da plantação."
            }
        ]);

        exit;
    }


    // Jogador está carregando água
    if (global.balde_cheio)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Morador",
                texto:
                    "Aquele morador estava procurando água."
            }
        ]);

        exit;
    }


    // Jogador encontrou o balde
    if (global.balde_coletado)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Morador",
                texto:
                    "Você pode encher esse balde no poço."
            }
        ]);

        exit;
    }


    // Primeira pista
    global.dialogo_instancia.abrir(
    [
        {
            nome: "Morador",
            texto:
                "O agricultor parece preocupado com alguma coisa."
        },
        {
            nome: "Morador",
            texto:
                "Talvez alguém perto das casas saiba ajudá-lo."
        }
    ]);
};