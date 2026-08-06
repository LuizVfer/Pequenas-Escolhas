event_inherited();

// Ajuste visual exclusivo deste personagem
offset_indicador_y = 12;

// Interação com o carrasco
interagir = function()
{
    global.dialogo_instancia.abrir(
    [
        {
            nome: "",
            texto: "O carrasco permanece imóvel, em silêncio. Seu olhar não abandona a praça."
        }
    ]);
};