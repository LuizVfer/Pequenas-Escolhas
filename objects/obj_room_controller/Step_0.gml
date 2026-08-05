#region Verificar câmera

var _camera = view_camera[0];

if (_camera == -1)
{
    exit;
}

var _camera_x =
    camera_get_view_x(_camera);

#endregion


#region Parallax intermediário

if (layer_exists(layer_mid))
{
    layer_x(
        layer_mid,
        _camera_x
            * (1 - parallax_mid)
    );
}

#endregion


#region Parallax distante

if (layer_exists(layer_far))
{
    layer_x(
        layer_far,
        _camera_x
            * (1 - parallax_far)
    );
}

#endregion


#region Céu

if (layer_exists(layer_sky))
{
    layer_x(
        layer_sky,
        _camera_x
            * (1 - parallax_sky)
    );
}

#endregion