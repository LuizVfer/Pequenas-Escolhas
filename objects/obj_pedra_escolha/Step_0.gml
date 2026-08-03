if (!chutada)
{
    exit;
}


// Movimento contínuo para a direita
x += velocidade_chute;


// Limites da câmera atual
var _camera = view_camera[0];

if (_camera != -1)
{
    var _camera_x =
        camera_get_view_x(_camera);

    var _camera_largura =
        camera_get_view_width(_camera);

    var _limite_direito =
        _camera_x + _camera_largura;


    // Destrói somente depois de sair completamente da tela
    if (bbox_left > _limite_direito + 16)
    {
        instance_destroy();
    }
}
else
{
    // Segurança caso a câmera não exista
    if (x > room_width + 16)
    {
        instance_destroy();
    }
}