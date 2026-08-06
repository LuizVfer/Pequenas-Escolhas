if (
    !ativo
    || alpha_fade <= 0
)
{
    exit;
}


#region Dimensões da GUI

var _gui_largura =
    display_get_gui_width();

var _gui_altura =
    display_get_gui_height();

#endregion


#region Desenhar fade

draw_set_color(c_black);

draw_set_alpha(
    clamp(
        alpha_fade,
        0,
        1
    )
);


draw_rectangle(
    0,
    0,
    _gui_largura,
    _gui_altura,
    false
);

#endregion


#region Restaurar configurações

draw_set_alpha(1);
draw_set_color(c_white);

#endregion