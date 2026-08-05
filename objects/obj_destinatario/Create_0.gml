event_inherited();


#region Configuração da interação

distancia_interacao = 48;
offset_indicador_y = 12;
prioridade_interacao = 0;

pode_interagir =
    !global.carta_entregue;

#endregion


#region Controle da transição

aguardando_final = false;
transicao_iniciada = false;

#endregion


#region Função de interação

interagir = function()
{
    if (
        global.carta_entregue
        || aguardando_final
        || transicao_iniciada
        || !pode_interagir
    )
    {
        exit;
    }


    // ==================================================
    // ESCOLHA DO BRINQUEDO AINDA NÃO FOI FEITA
    // ==================================================

    if (global.escolha_brinquedo == -1)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "",
                texto:
                    "Antes de bater à porta, o mensageiro percebe a criança ainda olhando para o brinquedo preso entre os galhos."
            }
        ]);

        exit;
    }


    // ==================================================
    // ENTREGAR A CARTA
    // ==================================================

    aguardando_final = true;
    pode_interagir = false;


    global.dialogo_instancia.abrir(
    [
        {
            nome: "Mensageiro",
            texto:
                "Boa tarde. Trago uma carta destinada a você."
        },

        {
            nome: "Destinatário",
            texto:
                "Uma carta? Não esperava receber notícias hoje."
        },

        {
            nome: "Mensageiro",
            texto:
                "É uma mensagem sobre um casamento. Pediram que fosse entregue pessoalmente."
        },

        {
            nome: "Destinatário",
            texto:
                "Entendo. Agradeço por ter atravessado todo esse caminho."
        },

        {
            nome: "Mensageiro",
            texto:
                "Era apenas o meu trabalho."
        }
    ]);
};

#endregion