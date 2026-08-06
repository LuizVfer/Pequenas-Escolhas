event_inherited();

// Ajuste visual exclusivo do comerciante
offset_indicador_y = 12;

// Interação com o comerciante
interagir = function()
{
    global.dialogo_instancia.abrir(
    [
        {
            nome: "Comerciante",
            texto: "Um viajante, não é? Faz tempo que não vejo um rosto novo por estas ruas."
        },

        {
            nome: "Mensageiro",
            texto: "Estou apenas de passagem."
        },

        {
            nome: "Comerciante",
            texto: "Então siga em frente, mas vá com cuidado. Há uma agitação incomum na praça hoje."
        }
    ]);
};