event_inherited();

// Ajuste visual exclusivo do prisioneiro
offset_indicador_y = 12;

// Interação com o prisioneiro
interagir = function()
{
    global.dialogo_instancia.abrir(
    [
        {
            nome: "",
            texto: "O prisioneiro permanece sentado, com a cabeça baixa. Apesar da agitação na praça, não diz uma palavra."
        }
    ]);
};