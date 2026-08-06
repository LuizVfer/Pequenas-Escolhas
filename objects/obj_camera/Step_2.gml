#region Verificar jogador

var _player =
    instance_find(obj_player, 0);


if (_player == noone)
{
    exit;
}

#endregion


#region Verificar câmera

// Atualiza a referência caso a View 0 tenha sido recriada
camera_id = view_camera[0];


if (camera_id == -1)
{
    exit;
}


// Mantém as dimensões sincronizadas com a View 0
camera_largura =
    camera_get_view_width(camera_id);

camera_altura =
    camera_get_view_height(camera_id);


if (
    camera_largura <= 0
    || camera_altura <= 0
)
{
    exit;
}

#endregion


#region Calcular posição desejada

// Coloca o jogador em 40% da largura da tela
var _alvo_x =
    _player.x
    - camera_largura
    * posicao_player_tela;

#endregion


#region Limites da room

var _limite_x =
    max(
        0,
        room_width - camera_largura
    );

#endregion


#region Atualizar câmera

// Movimento direto e alinhado aos pixels,
// adequado para o estilo pixel art
camera_x =
    clamp(
        round(_alvo_x),
        0,
        _limite_x
    );


// O jogo não possui movimentação vertical
camera_y = 0;


camera_set_view_pos(
    camera_id,
    camera_x,
    camera_y
);

#endregion