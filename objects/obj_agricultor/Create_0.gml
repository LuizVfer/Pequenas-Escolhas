event_inherited();

distancia_interacao = 48;
offset_indicador_y = 12;
prioridade_interacao = 0;

// Controle da abertura
aguardando_abertura = false;
transicao_iniciada = false;

// Futuro efeito sonoro
som_portao = snd_portao_abrindo;

// Caso o portão já esteja aberto,
// posiciona o agricultor próximo dele
if (global.portao_aberto)
{
    var _ponto = instance_find(
        obj_ponto_agricultor_portao,
        0
    );

    if (_ponto != noone)
    {
        x = _ponto.x;
        y = _ponto.y;
    }
}


interagir = function()
{
    // ==================================================
    // PORTÃO JÁ ABERTO
    // ==================================================

    if (global.portao_aberto)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Agricultor",
                texto: "Pronto. O caminho está livre novamente."
            }
        ]);

        exit;
    }


    // ==================================================
    // PLAYER AINDA NÃO VIU O PORTÃO
    // ==================================================

    if (!global.portao_descoberto)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Agricultor",
                texto: "O trabalho na plantação parece nunca terminar."
            }
        ]);

        exit;
    }


    // ==================================================
    // AINDA NÃO CONSEGUIU AS DUAS PISTAS
    // ==================================================

    if (
        global.moradores_conversados
        < global.moradores_necessarios
    )
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Agricultor",
                texto: "Estou descansando um pouco antes de voltar ao trabalho."
            }
        ]);

        exit;
    }


    // Evita repetir o acionamento
    if (
        aguardando_abertura
        || transicao_iniciada
    )
    {
        exit;
    }


    // ==================================================
    // DESCOBRIU QUEM CUIDOU DO PORTÃO
    // ==================================================

    aguardando_abertura = true;
    pode_interagir = false;

    global.dialogo_instancia.abrir(
    [
        {
            nome: "Mensageiro",
            texto: "Disseram que alguém com ferramentas veio das plantações depois de trabalhar no portão."
        },

        {
            nome: "Agricultor",
            texto: "Fui eu. Aquele mecanismo costuma emperrar quando fica muito tempo parado."
        },

        {
            nome: "Mensageiro",
            texto: "Preciso atravessá-lo para continuar minha viagem."
        },

        {
            nome: "Agricultor",
            texto: "Venha comigo. Eu consigo abri-lo."
        }
    ]);
};