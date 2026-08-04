event_inherited();

prioridade_interacao = 0;
distancia_interacao = 48;
offset_indicador_y = 12;

interagir = function()
{
    global.dialogo_instancia.abrir(
    [
        {
            nome: "Guarda",
            texto: "Continue andando. Não há nada para ver aqui."
        }
    ]);
};