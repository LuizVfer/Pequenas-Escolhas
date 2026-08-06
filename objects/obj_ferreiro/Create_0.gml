event_inherited();

// Ajuste visual exclusivo do ferreiro
offset_indicador_y = 12;

// Interação com o ferreiro
interagir = function()
{
    // Carroça já consertada
    if (global.roda_usada)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Ferreiro",
                texto: "Pronto. A roda está firme de novo."
            },

            {
                nome: "Ferreiro",
                texto: "Obrigado pela ajuda. Agora posso tirar a carroça do caminho."
            }
        ]);

        exit;
    }

    // Primeira conversa
    if (!global.ferreiro_conversado)
    {
        var _dialogo_aberto = global.dialogo_instancia.abrir(
        [
            {
                nome: "Ferreiro",
                texto: "Uma das rodas se soltou e foi parar ali. Sem ela, não consigo mover a carroça."
            },

            {
                nome: "Ferreiro",
                texto: "Você poderia empurrá-la até aqui e fixá-la ao eixo? O martelo está junto à carroça."
            },

            {
                nome: "Mensageiro",
                texto: "Posso fazer isso."
            }
        ]);

        // Libera a roda somente se o diálogo abrir
        if (_dialogo_aberto)
        {
            global.ferreiro_conversado = true;
            global.roda_liberada = true;
        }

        exit;
    }

    // Ainda aguardando a roda
    global.dialogo_instancia.abrir(
    [
        {
            nome: "Ferreiro",
            texto: "A roda está logo ali. Traga-a até a carroça e use o martelo para fixá-la."
        }
    ]);
};