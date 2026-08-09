#region Verificar jogador

var _player =
    instance_find(obj_player, 0);


if (_player == noone)
{
    exit;
}

#endregion


#region Verificar câmera

// Atualiza a referência caso a View 0
// tenha sido recriada
camera_id = view_camera[0];


if (camera_id == -1)
{
    exit;
}


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

// Coloca o jogador em 40%
// da largura da tela
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


#region Atualizar tremor

var _fade_ativo =
    fade_camera_ativo();


// Começa quando o fade tiver terminado
if (
    tremor_aguardando
    && !_fade_ativo
)
{
    tremor_aguardando = false;
    tremor_ativo = true;

    tremor_frames_restantes =
        tremor_duracao;
}


// Atualiza apenas quando a cena está visível
if (
    tremor_ativo
    && !_fade_ativo
)
{
    var _proporcao =
        tremor_frames_restantes
        / max(1, tremor_duracao);


    // O tremor perde força gradualmente
    var _forca_atual =
        max(
            1,
            ceil(
                tremor_forca
                * _proporcao
            )
        );


    tremor_lado =
        -tremor_lado;


    tremor_deslocamento_x =
        tremor_lado
        * _forca_atual;


    tremor_frames_restantes -= 1;


    if (tremor_frames_restantes <= 0)
    {
        tremor_ativo = false;
    }
}
else
{
    // Não deixa a câmera deslocada
    // durante uma tela preta
    tremor_deslocamento_x = 0;
}

#endregion


#region Atualizar câmera

// Posição normal somada ao tremor.
// O clamp impede mostrar algo fora da room.
camera_x =
    clamp(
        round(_alvo_x)
        + tremor_deslocamento_x,

        0,
        _limite_x
    );


// O jogo não possui movimento vertical
camera_y = 0;


camera_set_view_pos(
    camera_id,
    camera_x,
    camera_y
);

#endregion