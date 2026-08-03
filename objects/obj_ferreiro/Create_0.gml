event_inherited();

distancia_interacao = 48;
offset_indicador_y = 12;


interagir = function()
{
    // Carroça já consertada
    if (global.roda_usada)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Ferreiro",
                texto: "Pronto. A roda está firme novamente."
            },

            {
                nome: "Ferreiro",
                texto: "Uma pequena ajuda pode manter uma longa viagem em movimento."
            }
        ]);

        exit;
    }


    // Primeira conversa
    if (!global.ferreiro_conversado)
    {
        global.ferreiro_conversado = true;
        global.roda_liberada = true;

        global.dialogo_instancia.abrir(
        [
            {
                nome: "Ferreiro",
                texto: "Essa carroça não irá muito longe sem a roda que se soltou."
            },

            {
                nome: "Ferreiro",
                texto: "Se puder empurrá-la até aqui, eu consigo colocá-la de volta."
            },

            {
                nome: "Mensageiro",
                texto: "Vou cuidar disso."
            }
        ]);

        exit;
    }


    // Ainda aguardando a roda
    global.dialogo_instancia.abrir(
    [
        {
            nome: "Ferreiro",
            texto: "A roda está ali. Traga-a até a carroça e eu cuidarei do resto."
        }
    ]);
};