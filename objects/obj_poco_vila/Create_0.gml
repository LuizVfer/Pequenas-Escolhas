event_inherited();


#region Interação

distancia_interacao = 48;
prioridade_interacao = 10;

pode_interagir = true;

#endregion


#region Função de interação

interagir = function()
{
    if (!pode_interagir)
    {
        exit;
    }


    // O morador já recebeu a água
    if (global.morador_recebeu_agua)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "",
                texto:
                    "A água do poço está fria e limpa."
            }
        ]);

        exit;
    }
    
    // Missão da água ainda não foi descoberta
    if (!global.quest_agua_iniciada)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "",
                texto:
                    "Um poço utilizado pelos moradores da vila."
            }
        ]);
    
        exit;
    }


    // Jogador ainda não encontrou o balde
    if (!global.balde_coletado)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "",
                texto:
                    "O poço é fundo. Você precisaria de um recipiente."
            }
        ]);

        exit;
    }


    // O balde já está cheio
    if (global.balde_cheio)
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "",
                texto:
                    "O balde já está cheio."
            }
        ]);

        exit;
    }


    // Encher o balde
    global.balde_cheio = true;


    global.dialogo_instancia.abrir(
    [
        {
            nome: "",
            texto:
                "Você encheu o balde com água."
        }
    ]);
};

#endregion