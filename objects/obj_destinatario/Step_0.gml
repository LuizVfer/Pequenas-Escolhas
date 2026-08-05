#region Carta já entregue

if (global.carta_entregue)
{
    pode_interagir = false;

    exit;
}

#endregion


#region Aguardando interação

if (!aguardando_final)
{
    pode_interagir = true;

    exit;
}

#endregion


#region Aguardar final do diálogo

pode_interagir = false;


// Aguarda a conversa da entrega terminar
if (
    global.dialogo_ativo
    || transicao_iniciada
)
{
    exit;
}

#endregion


#region Iniciar final do jogo

transicao_iniciada = true;


var _iniciar_final = method(
    id,

    function()
    {
        // ----------------------------------------------
        // Abaixar a música
        // ----------------------------------------------

        if (
            instance_exists(
                global.game_instancia
            )
        )
        {
            global.game_instancia
                .abaixar_musica_para_efeito(
                    75,
                    0.25
                );
        }


        // ----------------------------------------------
        // Som da porta
        // ----------------------------------------------

        var _som_porta =
            audio_play_sound(
                snd_porta,
                2,
                false
            );


        audio_sound_gain(
            _som_porta,
            0.80,
            0
        );


        audio_sound_pitch(
            _som_porta,
            0.95
        );


        // ----------------------------------------------
        // Salvar conclusão
        // ----------------------------------------------

        global.carta_entregue = true;
        global.usar_spawn = false;


        // ----------------------------------------------
        // Ir para o livro final
        // ----------------------------------------------

        room_goto(
            rm_final_livro
        );
    }
);


global.fade_instancia.iniciar(
    _iniciar_final,
    0.03,
    60
);

#endregion