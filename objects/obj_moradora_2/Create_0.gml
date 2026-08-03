event_inherited();

distancia_interacao = 48;
offset_indicador_y = 12;
prioridade_interacao = 0;


interagir = function()
{
    // Ainda não descobriu o portão
    if (!global.portao_descoberto)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Moradora",
                texto: "A colheita tem exigido muito trabalho este ano."
            }
        ]);

        exit;
    }


    // Primeira conversa depois de descobrir o portão
    if (!global.moradora_2_conversada)
    {
        global.moradora_2_conversada = true;

        global.moradores_conversados =
            (global.morador_1_conversado ? 1 : 0)
            + (global.moradora_2_conversada ? 1 : 0);

        global.dialogo_instancia.abrir(
        [
            {
                nome: "Mensageiro",
                texto: "Sabe quem poderia ajudar com o portão?"
            },
        
            {
                nome: "Moradora",
                texto: "Vi alguém carregando ferramentas perto dele esta manhã."
            },
        
            {
                nome: "Moradora",
                texto: "Depois, ele seguiu em direção às plantações."
            }
        ]);

        show_debug_message(
            "Moradores conversados: "
            + string(global.moradores_conversados)
        );

        exit;
    }


    // Conversa repetida
    global.dialogo_instancia.abrir(
    [
        {
            nome: "Moradora",
            texto: "Procure perto das plantações. Talvez ele ainda esteja por lá."
        }
    ]);
};