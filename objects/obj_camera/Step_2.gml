if (!instance_exists(obj_player))
{
    exit;
}


var _player =
    instance_find(obj_player, 0);


// Posição desejada da câmera
var _alvo_x =
    _player.x
    - camera_largura
    * posicao_player_tela;


// Limite horizontal da room
var _limite_x =
    max(
        0,
        room_width - camera_largura
    );


// Movimento direto e alinhado aos pixels
camera_x =
    clamp(
        round(_alvo_x),
        0,
        _limite_x
    );

camera_y = 0;


camera_set_view_pos(
    camera_id,
    camera_x,
    camera_y
);