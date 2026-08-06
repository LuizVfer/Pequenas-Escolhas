event_inherited();

// Ajuste visual exclusivo do guarda
offset_indicador_y = 12;

// Interação com o guarda
interagir = function()
{
    global.dialogo_instancia.abrir(
    [
        {
            nome: "Guarda",
            texto: "Continue andando. A praça não está aberta para curiosos."
        },

        {
            nome: "Mensageiro",
            texto: "Não pretendo causar problemas."
        },

        {
            nome: "Guarda",
            texto: "Então não permaneça aqui por muito tempo."
        }
    ]);
};