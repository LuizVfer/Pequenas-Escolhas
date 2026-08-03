if (instance_exists(obj_player))
{
    // Posição desejada da câmera
    var _alvo_x =
        obj_player.x
        - camera_largura * posicao_player_tela;

    // Impede a câmera de mostrar fora da room
    _alvo_x = clamp(
        _alvo_x,
        0,
        max(0, room_width - camera_largura)
    );

    // Movimento suave
    camera_x = lerp(
        camera_x,
        _alvo_x,
        suavidade
    );

    // Evita pixels tremendo
    camera_x = round(camera_x);

    // Eixo Y permanece fixo
    camera_y = 0;

    camera_set_view_pos(
        camera_id,
        camera_x,
        camera_y
    );
}