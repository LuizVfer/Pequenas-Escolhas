event_inherited();


#region Interação

distancia_interacao = 40;
prioridade_interacao = 10;

pode_interagir =
    global.quest_agua_iniciada
    && !global.balde_coletado;

#endregion


#region Função de interação

interagir = function()
{
    if (
        !global.quest_agua_iniciada
        || global.balde_coletado
        || !pode_interagir
    )
    {
        exit;
    }


    global.balde_coletado = true;
    pode_interagir = false;


    global.dialogo_instancia.abrir(
    [
        {
            nome: "",
            texto:
                "Você encontrou um balde vazio."
        }
    ]);


    instance_destroy();
};

#endregion