#region Atualizar poeira

vida--;


x +=
    velocidade_x;


y +=
    velocidade_y;


velocidade_y +=
    gravidade;


if (vida <= 0)
{
    instance_destroy();
}

#endregion