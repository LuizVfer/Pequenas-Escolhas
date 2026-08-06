event_inherited();


#region Configuração visual

image_speed = 0;
image_index = 0;


// Restaura o resultado da escolha ao entrar na room
switch (global.escolha_brinquedo)
{
    // Brinquedo recuperado
    case 0:
        sprite_index = spr_crianca_brinquedo;
    break;


    // Brinquedo quebrado
    case 1:
        sprite_index = spr_crianca_brinquedo_quebrado;
    break;


    // Escolha ainda não realizada ou ignorada
    default:
        sprite_index = spr_crianca_alcancando;
    break;
}

#endregion


#region Configuração da interação

distancia_interacao = 44;
prioridade_interacao = 5;

offset_indicador_y = 12;

#endregion


#region Interação

interagir = function()
{
    if (!pode_interagir)
    {
        exit;
    }


    // ==================================================
    // RESULTADO DA ESCOLHA
    // ==================================================

    switch (global.escolha_brinquedo)
    {
        // Ajudou a criança
        case 0:
            global.dialogo_instancia.abrir(
            [
                {
                    nome: "Criança",
                    texto: "Você conseguiu! Meu brinquedo está inteiro. Agora vou tomar mais cuidado com ele."
                }
            ]);

            exit;
        break;


        // Derrubou o brinquedo com uma pedra
        case 1:
            global.dialogo_instancia.abrir(
            [
                {
                    nome: "Criança",
                    texto: "Ele caiu... mas se quebrou. Talvez alguém consiga consertá-lo."
                }
            ]);

            exit;
        break;


        // Não fez nada
        case 2:
            global.dialogo_instancia.abrir(
            [
                {
                    nome: "",
                    texto: "A criança continua estendendo os braços, mas o brinquedo permanece fora de seu alcance."
                }
            ]);

            exit;
        break;
    }


    // ==================================================
    // PRIMEIRA CONVERSA
    // ==================================================

    if (!global.crianca_destino_conversada)
    {
        var _dialogo_aberto = global.dialogo_instancia.abrir(
        [
            {
                nome: "Criança",
                texto: "O vento levou meu brinquedo, e ele ficou preso nos galhos."
            },

            {
                nome: "Criança",
                texto: "Já tentei alcançar, mas está alto demais para mim."
            }
        ]);


        // Libera a interação com o brinquedo somente
        // se o diálogo realmente conseguir abrir
        if (_dialogo_aberto)
        {
            global.crianca_destino_conversada = true;
        }

        exit;
    }


    // ==================================================
    // CONVERSA REPETIDA
    // ==================================================

    global.dialogo_instancia.abrir(
    [
        {
            nome: "Criança",
            texto: "Meu brinquedo ainda está preso nos galhos. Não consigo alcançá-lo."
        }
    ]);
};

#endregion