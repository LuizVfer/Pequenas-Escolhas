event_inherited();

distancia_interacao = 48;
offset_indicador_y = 12;

interagir = function()
{
    global.dialogo_instancia.abrir(
    [
        {
            nome: "Comerciante",
            texto: "Viajante, não é? Faz tempo que não vejo alguém vindo de tão longe."
        },

        {
            nome: "Mensageiro",
            texto: "Estou apenas de passagem."
        },

        {
            nome: "Comerciante",
            texto: "Então siga com cuidado. As ruas parecem tranquilas, mas sempre há alguma coisa no caminho."
        }
    ]);
};