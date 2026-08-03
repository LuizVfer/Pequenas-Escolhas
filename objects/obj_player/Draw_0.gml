// Desenha o player normalmente
draw_self();


// Desenha o indicador E acima do objeto próximo
if (!global.dialogo_ativo && instance_exists(interagivel_atual))
{
    draw_sprite( spr_tecla_E_placeholder, 0, interagivel_atual.x, interagivel_atual.bbox_top - interagivel_atual.offset_indicador_y );
}