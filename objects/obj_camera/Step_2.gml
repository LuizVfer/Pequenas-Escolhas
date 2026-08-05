if (!instance_exists(obj_player))
{
    exit;
}


// Posição desejada
var _alvo_x =
    obj_player.x
    - camera_largura * posicao_player_tela;


// Limites da room
_alvo_x = clamp(
    _alvo_x,
    0,
    max(0, room_width - camera_largura)
);


// A posição interna continua suave e decimal
camera_x = lerp(
    camera_x,
    _alvo_x,
    suavidade
);

camera_y = 0;


// Apenas a posição visual é arredondada
var _camera_visual_x =
    round(camera_x);

var _camera_visual_y =
    round(camera_y);


camera_set_view_pos(
    camera_id,
    _camera_visual_x,
    _camera_visual_y
);