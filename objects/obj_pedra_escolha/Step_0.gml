// A pedra só se movimenta depois de ser chutada
if (!chutada)
{
    exit;
}

x += velocidade_chute;


// ==================================================
// REMOÇÃO FORA DA TELA
// ==================================================

var _camera = view_camera[0];

// Segurança caso não exista uma câmera ativa
if (_camera == -1)
{
    if (x > room_width + 16)
    {
        instance_destroy();
    }

    exit;
}

var _camera_x = camera_get_view_x(_camera);
var _camera_largura = camera_get_view_width(_camera);
var _limite_direito = _camera_x + _camera_largura;

// Remove a pedra somente depois que ela sair da tela
if (bbox_left > _limite_direito + 16)
{
    instance_destroy();
}