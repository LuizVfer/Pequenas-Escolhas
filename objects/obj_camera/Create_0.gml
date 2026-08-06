#region Configuração da câmera

// Câmera utilizada pela Viewport 0
camera_id = view_camera[0];

// Tamanho padrão da área interna
camera_largura = 640;
camera_altura = 360;

// Mantém o jogador em 40% da largura da tela
posicao_player_tela = 0.40;

// Posição interna da câmera
camera_x = 0;
camera_y = 0;

#endregion


#region Ler configuração da View 0

// Sincroniza os valores com a câmera configurada
// nas propriedades da room
if (camera_id != -1)
{
    camera_largura =
        camera_get_view_width(camera_id);

    camera_altura =
        camera_get_view_height(camera_id);

    camera_x =
        camera_get_view_x(camera_id);

    camera_y =
        camera_get_view_y(camera_id);
}

#endregion