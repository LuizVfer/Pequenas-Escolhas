// A saída já iniciou a transição
if (usada)
{
    exit;
}


// O jogador está em diálogo, fade ou outra ação bloqueada
if (global.controle_bloqueado)
{
    exit;
}


// O jogador ainda não encostou na saída
if (!place_meeting(x, y, obj_player))
{
    exit;
}


// Segurança: destino não configurado
if (room_destino == noone)
{
    show_debug_message(
        "ERRO: obj_saida_room sem room_destino."
    );

    exit;
}


// Segurança: sistema de fade não existe
if (!instance_exists(global.fade_instancia))
{
    show_debug_message(
        "ERRO: obj_fade não encontrado."
    );

    exit;
}


// Função executada quando a tela estiver preta
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


// Tenta iniciar o fade
var _fade_iniciado =
    global.fade_instancia.iniciar(
        _trocar_room,
        0.05,
        45
    );


// Só bloqueia permanentemente esta saída
// quando o fade realmente começou
if (_fade_iniciado)
{
    usada = true;
}