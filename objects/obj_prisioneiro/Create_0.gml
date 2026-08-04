event_inherited();

prioridade_interacao = 0;
distancia_interacao = 48;
offset_indicador_y = 12;

interagir = function()
{
    global.dialogo_instancia.abrir(
    [
        {
            nome: "",
            texto: "O prisioneiro permanece sentado, com a cabeça baixa."
        }
    ]);
};