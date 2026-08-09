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


#region Tremor da câmera

tremor_ativo = false;
tremor_aguardando = false;

tremor_forca = 0;
tremor_duracao = 0;
tremor_frames_restantes = 0;

tremor_deslocamento_x = 0;
tremor_lado = 1;


// Verifica se existe um fade acontecendo
fade_camera_ativo = function()
{
    if (
        !variable_global_exists(
            "fade_instancia"
        )
    )
    {
        return false;
    }


    if (
        !instance_exists(
            global.fade_instancia
        )
    )
    {
        return false;
    }


    return global.fade_instancia.ativo;
};


// Inicia ou agenda um tremor
tremer = function(
    _forca = 1,
    _duracao = 8
)
{
    if (
        !is_real(_forca)
        || !is_real(_duracao)
    )
    {
        return false;
    }


    _forca =
        abs(
            round(_forca)
        );

    _duracao =
        max(
            1,
            round(_duracao)
        );


    if (_forca <= 0)
    {
        return false;
    }


    tremor_forca = _forca;
    tremor_duracao = _duracao;

    tremor_frames_restantes =
        _duracao;

    tremor_deslocamento_x = 0;
    tremor_lado = 1;


    // As alterações dos cenários acontecem
    // durante a tela preta. Nesse caso,
    // aguarda o fade terminar.
    if (fade_camera_ativo())
    {
        tremor_aguardando = true;
        tremor_ativo = false;
    }
    else
    {
        tremor_aguardando = false;
        tremor_ativo = true;
    }


    return true;
};

#endregion