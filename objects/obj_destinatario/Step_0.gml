#region Carta já entregue

if (global.carta_entregue)
{
    pode_interagir = false;
    exit;
}

#endregion


#region Aguardando a entrega

if (!aguardando_final)
{
    pode_interagir = true;
    exit;
}

#endregion


#region Aguardar o diálogo terminar

pode_interagir = false;

if (
    global.dialogo_ativo
    || transicao_iniciada
)
{
    exit;
}

#endregion


#region Preparar o final do jogo

var _iniciar_final = method(
    id,

    function()
    {
        // Abaixa a música antes do som da porta
        if (instance_exists(global.game_instancia))
        {
            global.game_instancia.abaixar_musica_para_efeito(
                75,
                0.25
            );
        }


        // Som da porta
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


        // Salva a conclusão da entrega
        global.carta_entregue = true;
        global.usar_spawn = false;


        // Inicia o livro das consequências
        room_goto(rm_final_livro);
    }
);

#endregion


#region Iniciar transição

// Marca a transição somente se o fade começar corretamente
var _fade_iniciado = global.fade_instancia.iniciar(
    _iniciar_final,
    0.03,
    60
);

if (_fade_iniciado)
{
    transicao_iniciada = true;
}

#endregion