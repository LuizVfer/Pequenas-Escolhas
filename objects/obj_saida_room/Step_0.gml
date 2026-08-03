if (usada)
{
    exit;
}

if (global.controle_bloqueado)
{
    exit;
}

if (!place_meeting(x, y, obj_player))
{
    exit;
}

if (room_destino == noone)
{
    show_debug_message(
        "ERRO: obj_saida_room sem room_destino."
    );

    exit;
}

usada = true;

var _trocar_room = method(
    id,

    function()
    {
        global.spawn_x = spawn_x_destino;
        global.spawn_y = spawn_y_destino;
        global.usar_spawn = true;

        room_goto(room_destino);
    }
);

global.fade_instancia.iniciar(
    _trocar_room,
    0.05,
    45
);