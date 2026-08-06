event_inherited();


// A interação é liberada somente depois da conversa
// com a criança e antes da escolha
pode_interagir =
    global.crianca_destino_conversada
    && global.escolha_brinquedo == -1;