#region Configuração

vida = 20;
vida_total = vida;


// Movimento inicial
velocidade_x = 0;
velocidade_y =
    random_range(-0.45, -0.20);

gravidade = 0.018;


// Tamanho propositalmente visível
// durante o primeiro teste
tamanho =
    irandom_range(3, 4);


cor =
    make_color_rgb(
        170,
        138,
        94
    );


alpha_maximo = 0.60;


switch (room)
{
    case rm_cidade:

        cor =
            make_color_rgb(
                163,
                150,
                110
            );

        alpha_maximo = 0.60;

    break;


    case rm_floresta:

        cor =
            make_color_rgb(
                106,
                86,
                63
            );

        alpha_maximo = 0.70;

    break;


    case rm_vila:

        cor =
            make_color_rgb(
                170,
                138,
                94
            );

        alpha_maximo = 0.75;

    break;
}

#endregion