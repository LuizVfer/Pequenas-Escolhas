if (global.carta_entregue)
{
    pode_interagir = false;
    exit;
}


if (!aguardando_final)
{
    pode_interagir = true;
    exit;
}


pode_interagir = false;


// Aguarda o diálogo terminar
if (
    global.dialogo_ativo
    || transicao_iniciada
)
{
    exit;
}


// ==================================================
// IR PARA O FINAL
// ==================================================

transicao_iniciada = true;


var _iniciar_final = method(
    id,
    function()
    {
        // Abaixa a música para destacar a porta
        if (instance_exists(global.game_instancia))
        {
            global.game_instancia
                .abaixar_musica_para_efeito(
                    75,
                    0.25
                );
        }


        // Destinatário entra na casa
        var _som_porta = audio_play_sound(
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


        global.carta_entregue = true;
        global.usar_spawn = false;

        room_goto(rm_final_livro);
    }
);


global.fade_instancia.iniciar(
    _iniciar_final,
    0.03,
    60
);