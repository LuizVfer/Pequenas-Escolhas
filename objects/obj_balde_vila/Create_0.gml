event_inherited();


#region Configuração da interação

distancia_interacao = 40;
prioridade_interacao = 10;

pode_interagir =
    global.quest_agua_iniciada
    && !global.balde_coletado;

#endregion


#region Restaurar estado

// O balde não deve reaparecer caso a room
// seja recriada depois da coleta
if (global.balde_coletado)
{
    pode_interagir = false;
    instance_destroy();

    exit;
}

#endregion


#region Interação

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


    var _dialogo_aberto =
        global.dialogo_instancia.abrir(
        [
            {
                nome: "",
                texto: "Você encontrou um balde vazio."
            }
        ]);


    // Só coleta e remove o balde quando
    // o diálogo realmente conseguir abrir
    if (_dialogo_aberto)
    {
        global.balde_coletado = true;
        pode_interagir = false;

        instance_destroy();
    }
};

#endregion