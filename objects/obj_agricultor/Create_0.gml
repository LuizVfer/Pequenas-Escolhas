event_inherited();


#region Configuração da interação

distancia_interacao = 48;
offset_indicador_y = 12;
prioridade_interacao = 0;

pode_interagir = true;

#endregion


#region Controle da abertura

aguardando_abertura = false;
transicao_iniciada = false;

som_portao = snd_portao_abrindo;

#endregion


#region Restaurar estado

image_index = 0;
image_speed = 0;


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

#endregion


#region Interação

interagir = function()
{
    if (
        !pode_interagir
        || aguardando_abertura
        || transicao_iniciada
    )
    {
        exit;
    }


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
            },

            {
                nome: "Mensageiro",
                texto: "Obrigado."
            },

            {
                nome: "Agricultor",
                texto: "Boa viagem, mensageiro. Que encontre o que procura no fim dessa estrada."
            }
        ]);

        exit;
    }


    // ==================================================
    // JOGADOR AINDA NÃO VIU O PORTÃO
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
    // CABO JÁ ENTREGUE
    // ==================================================

    // Segurança para o caso de a entrega já ter sido
    // registrada, mas a abertura ainda não ter começado
    if (global.cabo_enxada_entregue)
    {
        aguardando_abertura = true;
        pode_interagir = false;

        exit;
    }


    // ==================================================
    // JOGADOR AINDA NÃO POSSUI O CABO
    // ==================================================

    if (!global.cabo_enxada_coletado)
    {
        var _dialogo_missao_aberto =
            global.dialogo_instancia.abrir(
            [
                {
                    nome: "Mensageiro",
                    texto: "Preciso atravessar o portão para continuar minha viagem."
                },

                {
                    nome: "Agricultor",
                    texto: "Eu poderia abri-lo, mas o cabo da minha enxada quebrou."
                },

                {
                    nome: "Agricultor",
                    texto: "Sem terminar este trabalho, não posso abandonar a plantação."
                },

                {
                    nome: "Agricultor",
                    texto: "Talvez alguém perto das casas tenha encontrado outro cabo."
                }
            ]);


        // Libera a procura pelo cabo somente se
        // o diálogo realmente conseguir abrir
        if (_dialogo_missao_aberto)
        {
            global.quest_cabo_iniciada = true;
        }

        exit;
    }


    // ==================================================
    // ENTREGAR O CABO DA ENXADA
    // ==================================================

    var _dialogo_entrega_aberto =
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Mensageiro",
                texto: "Encontrei um cabo que pode servir na sua enxada."
            },

            {
                nome: "Agricultor",
                texto: "Sim. Este cabo deve funcionar."
            },

            {
                nome: "",
                texto: "O mensageiro entrega o cabo da enxada."
            },

            {
                nome: "Agricultor",
                texto: "Agora posso terminar o trabalho."
            },

            {
                nome: "Agricultor",
                texto: "Depois disso, abrirei o portão para você."
            }
        ]);


    // O cabo só é consumido quando o diálogo abre
    if (_dialogo_entrega_aberto)
    {
        global.cabo_enxada_coletado = false;
        global.cabo_enxada_entregue = true;

        aguardando_abertura = true;
        pode_interagir = false;
    }
};

#endregion