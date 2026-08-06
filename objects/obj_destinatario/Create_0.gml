event_inherited();


#region Configuração da interação

// Ajuste visual exclusivo do destinatário
offset_indicador_y = 12;

pode_interagir = !global.carta_entregue;

#endregion


#region Controle da transição

aguardando_final = false;
transicao_iniciada = false;

#endregion


#region Interação

interagir = function()
{
    // Impede novas interações durante ou depois da entrega
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
    // ESCOLHA DO BRINQUEDO PENDENTE
    // ==================================================

    if (global.escolha_brinquedo == -1)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "",
                texto: "Antes de bater à porta, o mensageiro olha para a criança, que ainda tenta alcançar o brinquedo preso entre os galhos."
            }
        ]);

        exit;
    }


    // ==================================================
    // ENTREGA DA CARTA
    // ==================================================

    var _dialogo_aberto = global.dialogo_instancia.abrir(
    [
        {
            nome: "Mensageiro",
            texto: "Boa tarde. Tenho uma carta para você."
        },

        {
            nome: "Destinatário",
            texto: "Para mim? Não esperava receber notícias hoje."
        },

        {
            nome: "Mensageiro",
            texto: "Ela traz notícias de um casamento. Pediram que fosse entregue pessoalmente."
        },

        {
            nome: "Destinatário",
            texto: "Entendo. Agradeço por tê-la trazido de tão longe."
        },

        {
            nome: "Mensageiro",
            texto: "Era meu dever."
        }
    ]);


    // Somente inicia o final se o diálogo abrir corretamente
    if (_dialogo_aberto)
    {
        aguardando_final = true;
        pode_interagir = false;
    }
};

#endregion