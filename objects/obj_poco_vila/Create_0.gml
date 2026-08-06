event_inherited();


#region Configuração da interação

distancia_interacao = 48;
offset_indicador_y = 12;
prioridade_interacao = 10;

pode_interagir = true;

#endregion


#region Interação

interagir = function()
{
    if (!pode_interagir)
    {
        exit;
    }


    // ==================================================
    // ÁGUA JÁ FOI ENTREGUE
    // ==================================================

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


    // ==================================================
    // MISSÃO DA ÁGUA AINDA NÃO FOI INICIADA
    // ==================================================

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


    // ==================================================
    // JOGADOR AINDA NÃO ENCONTROU O BALDE
    // ==================================================

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


    // ==================================================
    // BALDE JÁ ESTÁ CHEIO
    // ==================================================

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


    // ==================================================
    // ENCHER O BALDE
    // ==================================================

    var _dialogo_aberto =
        global.dialogo_instancia.abrir(
        [
            {
                nome: "",
                texto:
                    "Você encheu o balde com água."
            }
        ]);


    // Só registra o balde cheio quando
    // o diálogo realmente conseguir abrir
    if (_dialogo_aberto)
    {
        global.balde_cheio = true;
    }
};

#endregion