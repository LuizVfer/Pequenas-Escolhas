#region Desenhar jogador

draw_self();

#endregion


#region Indicador de interação

if (
    !global.dialogo_ativo
    && !global.controle_bloqueado
    && instance_exists(
        interagivel_atual
    )
)
{
    draw_sprite(
        spr_tecla_E_placeholder,
        0,

        interagivel_atual.x,

        interagivel_atual.bbox_top
            - interagivel_atual
                .offset_indicador_y
    );
}

#endregion