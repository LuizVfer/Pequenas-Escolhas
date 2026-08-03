var _camera = view_camera[0];
var _camera_x = camera_get_view_x(_camera);

// Fundo intermediário: move a 50% da câmera
layer_x(layer_mid, _camera_x * (1 - parallax_mid));

// Fundo distante: move a 20% da câmera
layer_x(layer_far, _camera_x * (1 - parallax_far));

// Céu: fica visualmente parado na tela
layer_x(layer_sky, _camera_x * (1 - parallax_sky));