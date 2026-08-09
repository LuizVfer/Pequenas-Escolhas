#region Desenhar jogador

draw_self();

#endregion


#region Indicador de interação

if (indicador_alpha > 0.001)
{
    // Oscilação lenta de somente 1 pixel
    var _movimento_y =
        round(
            sin(
                indicador_tempo
                * 5
            )
        );


    // Cresce suavemente de 90% até 100%
    var _escala_indicador =
        0.90
        + 0.10
        * indicador_alpha;


    draw_sprite_ext(
        spr_tecla_E,
        0,

        indicador_x,
        indicador_y
            + _movimento_y,

        _escala_indicador,
        _escala_indicador,

        0,
        c_white,
        indicador_alpha
    );
}

#endregion