event_inherited();

distancia_interacao = 48;
offset_indicador_y = 12;
prioridade_interacao = 0;

aguardando_final = false;
transicao_iniciada = false;


// A carta já foi entregue
if (global.carta_entregue)
{
    pode_interagir = false;
}


interagir = function()
{
    if (
        global.carta_entregue
        || aguardando_final
        || transicao_iniciada
    )
    {
        exit;
    }


    // Garante que o jogador faça a escolha do brinquedo
    if (global.escolha_brinquedo == -1)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "",
                texto: "Antes de bater à porta, o mensageiro percebe a criança ainda olhando para o brinquedo preso entre os galhos."
            }
        ]);

        exit;
    }


    aguardando_final = true;
    pode_interagir = false;


    global.dialogo_instancia.abrir(
    [
        {
            nome: "Mensageiro",
            texto: "Boa tarde. Trago uma carta destinada a você."
        },

        {
            nome: "Destinatário",
            texto: "Uma carta? Não esperava receber notícias hoje."
        },

        {
            nome: "Mensageiro",
            texto: "É uma mensagem sobre um casamento. Pediram que fosse entregue pessoalmente."
        },

        {
            nome: "Destinatário",
            texto: "Entendo. Agradeço por ter atravessado todo esse caminho."
        },

        {
            nome: "Mensageiro",
            texto: "Era apenas o meu trabalho."
        }
    ]);
};