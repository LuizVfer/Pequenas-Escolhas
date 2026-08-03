if (alpha_fade > 0)
{
    draw_set_color(c_black);
    draw_set_alpha(alpha_fade);

    draw_rectangle(
        0,
        0,
        640,
        360,
        false
    );

    // Sempre restaura as configurações
    draw_set_alpha(1);
    draw_set_color(c_white);
}