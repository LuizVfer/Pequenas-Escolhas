event_inherited();

distancia_interacao = 44;
offset_indicador_y = 12;
prioridade_interacao = 10;

// Estado do mecanismo
aguardando_acionamento = false;
transicao_iniciada = false;

// Quando tiver o áudio, troque por:
// som_ponte = snd_ponte_abaixando;
som_ponte = snd_ponte_abaixando;

pode_interagir =
    global.ponte_descoberta
    && !global.ponte_abaixada;


interagir = function()
{
    if (
        !global.ponte_descoberta
        || global.ponte_abaixada
        || aguardando_acionamento
        || transicao_iniciada
    )
    {
        exit;
    }

    aguardando_acionamento = true;
    pode_interagir = false;

    global.dialogo_instancia.abrir(
    [
        {
            nome: "Mensageiro",
            texto: "Este mecanismo parece controlar a ponte."
        },

        {
            nome: "Mensageiro",
            texto: "Com algum esforço, talvez eu consiga fazê-lo funcionar."
        }
    ]);
};