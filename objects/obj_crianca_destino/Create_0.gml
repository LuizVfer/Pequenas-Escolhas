event_inherited();


#region Configuração visual

image_speed = 0;


// Restaura o resultado ao entrar novamente na room
switch (global.escolha_brinquedo)
{
    // Ajudou a criança
    case 0:
    {
        sprite_index =
            spr_crianca_brinquedo;
    }
    break;


    // Derrubou o brinquedo e ele quebrou
    case 1:
    {
        sprite_index =
            spr_crianca_brinquedo_quebrado;
    }
    break;


    // Ignorou ou ainda não escolheu
    default:
    {
        sprite_index =
            spr_crianca_alcancando;
    }
    break;
}


image_index = 0;

#endregion


#region Configuração da interação

distancia_interacao = 44;
offset_indicador_y = 12;
prioridade_interacao = 5;

pode_interagir = true;

#endregion


#region Função de interação

interagir = function()
{
    if (!pode_interagir)
    {
        exit;
    }


    // ==================================================
    // AJUDOU A CRIANÇA
    // ==================================================

    if (global.escolha_brinquedo == 0)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Criança",
                texto:
                    "Obrigado por recuperar meu brinquedo."
            }
        ]);

        exit;
    }


    // ==================================================
    // BRINQUEDO FOI QUEBRADO
    // ==================================================

    if (global.escolha_brinquedo == 1)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Criança",
                texto:
                    "Ele caiu... mas acabou quebrando."
            }
        ]);

        exit;
    }


    // ==================================================
    // JOGADOR IGNOROU
    // ==================================================

    if (global.escolha_brinquedo == 2)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "",
                texto:
                    "A criança continua tentando alcançar o brinquedo."
            }
        ]);

        exit;
    }


    // ==================================================
    // PRIMEIRA CONVERSA
    // ==================================================

    if (!global.crianca_destino_conversada)
    {
        global.crianca_destino_conversada = true;


        global.dialogo_instancia.abrir(
        [
            {
                nome: "Criança",
                texto:
                    "Meu brinquedo ficou preso nos galhos."
            },

            {
                nome: "Criança",
                texto:
                    "Eu tentei alcançar, mas ele está muito alto."
            }
        ]);

        exit;
    }


    // ==================================================
    // CONVERSA REPETIDA
    // ==================================================

    global.dialogo_instancia.abrir(
    [
        {
            nome: "Criança",
            texto:
                "Meu brinquedo ainda está preso na árvore."
        }
    ]);
};

#endregion