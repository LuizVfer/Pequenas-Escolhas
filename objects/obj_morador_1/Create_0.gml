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
                nome: "Morador",
                texto: "Poucos viajantes passam por esta vila ultimamente."
            }
        ]);

        exit;
    }


    // Primeira conversa depois de descobrir o portão
    if (!global.morador_1_conversado)
    {
        global.morador_1_conversado = true;

        global.moradores_conversados =
            (global.morador_1_conversado ? 1 : 0)
            + (global.moradora_2_conversada ? 1 : 0);

        global.dialogo_instancia.abrir(
        [
            {
                nome: "Mensageiro",
                texto: "Preciso atravessar o portão, mas ele está fechado."
            },
        
            {
                nome: "Morador",
                texto: "Ele costuma emperrar quando passa muito tempo sem uso."
            },
        
            {
                nome: "Morador",
                texto: "Não sei quem cuidou dele por último. Talvez outra pessoa da vila saiba."
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
            nome: "Morador",
            texto: "Pergunte aos outros moradores. Alguém deve saber quem mexeu no portão."
        }
    ]);
};