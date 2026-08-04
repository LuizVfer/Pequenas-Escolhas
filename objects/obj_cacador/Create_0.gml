event_inherited();

distancia_interacao = 48;
offset_indicador_y = 12;
prioridade_interacao = 0;

// Controla se a conversa principal já aconteceu
conversa_inicial_feita = false;


interagir = function()
{
    // ==========================================
    // PRIMEIRA INTERAÇÃO
    // ==========================================

    if (!conversa_inicial_feita)
    {
        conversa_inicial_feita = true;

        global.dialogo_instancia.abrir(
        [
            {
                nome: "Caçador",
                texto: "Há marcas estranhas por toda esta trilha."
            },

            {
                nome: "Caçador",
                texto: "Alguma coisa passou por aqui há pouco tempo."
            },

            {
                nome: "Mensageiro",
                texto: "Está procurando alguém?"
            },

            {
                nome: "Caçador",
                texto: "Talvez. Ou talvez alguma coisa esteja procurando por mim."
            }
        ]);
    }

    // ==========================================
    // PRÓXIMAS INTERAÇÕES
    // ==========================================

    else
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Caçador",
                texto: "É melhor não permanecer muito tempo no mesmo lugar."
            }
        ]);
    }
};