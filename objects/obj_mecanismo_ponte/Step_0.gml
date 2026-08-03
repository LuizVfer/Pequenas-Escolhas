// Ponte já foi abaixada
if (global.ponte_abaixada)
{
    pode_interagir = false;
    exit;
}


// Ainda não acionou o mecanismo
if (!aguardando_acionamento)
{
    pode_interagir =
        global.ponte_descoberta
        && !global.ponte_abaixada;

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
// INICIAR O FADE
// ==================================================

transicao_iniciada = true;

var _abaixar_ponte = method(
    id,

    function()
    {
        global.ponte_abaixada = true;

        // Troca o visual da ponte
        with (obj_ponte)
        {
            sprite_index = spr_ponte_abaixada;
            image_index = 0;
            image_speed = 0;

            pode_interagir = false;
        }

        // Remove somente o bloqueio da ponte
        with (obj_bloqueio_ponte)
        {
            instance_destroy();
        }

        // Toca o som, caso tenha sido configurado
        if (som_ponte != noone)
        {
            audio_play_sound(
                som_ponte,
                2,
                false
            );
        }

        aguardando_acionamento = false;
    }
);


global.fade_instancia.iniciar(
    _abaixar_ponte,
    0.05,
    100
);