event_inherited();

// Ajuste visual exclusivo do cavalo
offset_indicador_y = 12;

// Interação com o cavalo
interagir = function()
{
    global.dialogo_instancia.abrir(
    [
        {
            nome: "",
            texto: "O cavalo bate os cascos contra o chão, inquieto com a agitação da praça."
        }
    ]);
};