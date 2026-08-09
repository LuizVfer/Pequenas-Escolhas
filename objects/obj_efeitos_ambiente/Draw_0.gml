#region Desenhar efeitos

for (
    var _i = 0;
    _i < array_length(efeitos);
    _i++
)
{
    var _efeito =
        efeitos[_i];


    var _tempo_vivo =
        _efeito.vida_total
        - _efeito.vida;


    var _duracao_entrada =
        _efeito.tipo
            == TIPO_FUMACA_CIDADE
        ? 0.65
        : 0.35;


    var _entrada =
        clamp(
            _tempo_vivo
                / _duracao_entrada,

            0,
            1
        );


    var _saida =
        clamp(
            _efeito.vida / 0.85,
            0,
            1
        );


    var _alpha =
        _efeito.alpha
        * _entrada
        * _saida;


    var _x =
        round(_efeito.x);

    var _y =
        round(_efeito.y);


    draw_set_color(
        _efeito.cor
    );


    switch (_efeito.tipo)
    {
        case TIPO_POEIRA_CIDADE:

            draw_set_alpha(
                _alpha
            );


            draw_rectangle(
                _x,
                _y,

                _x + _efeito.tamanho,
                _y + 1,

                false
            );


            draw_set_alpha(
                _alpha * 0.45
            );


            draw_point(
                _x
                    + _efeito.tamanho
                    + 3,

                _y
            );

        break;


        case TIPO_FUMACA_CIDADE:

            var _crescimento =
                floor(
                    _efeito.tamanho

                    + _tempo_vivo
                    * 0.65
                );


            draw_set_alpha(
                _alpha * 0.55
            );


            draw_rectangle(
                _x - _crescimento,
                _y - _crescimento,

                _x + _crescimento,
                _y + _crescimento,

                false
            );


            draw_set_alpha(
                _alpha
            );


            draw_rectangle(
                _x - 1,
                _y - 1,

                _x + 1,
                _y + 1,

                false
            );


            draw_set_alpha(
                _alpha * 0.35
            );


            draw_rectangle(
                _x
                    + _crescimento
                    - 1,

                _y,

                _x
                    + _crescimento
                    + 1,

                _y + 2,

                false
            );

        break;


        case TIPO_FOLHA:

            var _virada_folha =
                sin(
                    _efeito.fase
                    * 1.45
                );


            draw_set_alpha(
                _alpha
            );


            if (
                abs(_virada_folha)
                < 0.35
            )
            {
                draw_rectangle(
                    _x,
                    _y,

                    _x + 1,

                    _y
                        + _efeito.tamanho
                        + 1,

                    false
                );
            }
            else
            {
                draw_rectangle(
                    _x,
                    _y,

                    _x
                        + _efeito.tamanho
                        + 1,

                    _y + 1,

                    false
                );
            }

        break;


        case TIPO_POLEN:

            draw_set_alpha(
                _alpha
            );


            draw_point(
                _x,
                _y
            );


            if (_efeito.tamanho > 1)
            {
                draw_set_alpha(
                    _alpha * 0.42
                );


                draw_point(
                    _x + 1,
                    _y
                );
            }

        break;


        case TIPO_VAGALUME:
        case TIPO_BRILHO_DESTINO:

            var _pulso =
                0.20

                + 0.80
                * (
                    0.5

                    + 0.5
                    * sin(
                        _efeito.fase
                    )
                );


            var _alpha_luz =
                _alpha
                * _pulso;


            // Brilho externo
            draw_set_alpha(
                _alpha_luz * 0.22
            );


            draw_rectangle(
                _x - 2,
                _y - 2,

                _x + 2,
                _y + 2,

                false
            );


            // Brilho intermediário
            draw_set_alpha(
                _alpha_luz * 0.48
            );


            draw_rectangle(
                _x - 1,
                _y - 1,

                _x + 1,
                _y + 1,

                false
            );


            // Centro
            draw_set_alpha(
                _alpha_luz
            );


            draw_point(
                _x,
                _y
            );

        break;


        case TIPO_FRAGMENTO_VILA:

            draw_set_alpha(
                _alpha
            );


            if (_efeito.subtipo == 0)
            {
                var _inclinacao =
                    sign(
                        sin(
                            _efeito.fase
                            * 1.4
                        )
                    );


                draw_line(
                    _x,
                    _y,

                    _x
                        + _efeito.tamanho,

                    _y
                        + _inclinacao
                );
            }
            else
            {
                draw_rectangle(
                    _x,
                    _y,

                    _x + 1,
                    _y + 1,

                    false
                );
            }

        break;


        case TIPO_RAJADA_VILA:

            var _onda =
                round(
                    sin(
                        _efeito.fase
                    )
                );


            draw_set_alpha(
                _alpha
            );


            draw_line(
                _x,
                _y,

                _x
                    + _efeito.tamanho,

                _y + _onda
            );


            draw_set_alpha(
                _alpha * 0.52
            );


            draw_line(
                _x + 7,
                _y + 4,

                _x
                    + _efeito.tamanho
                    - 5,

                _y
                    + 3
                    - _onda
            );


            draw_set_alpha(
                _alpha * 0.30
            );


            draw_line(
                _x + 3,
                _y - 4,

                _x
                    + _efeito.tamanho
                    - 10,

                _y
                    - 4
                    + _onda
            );

        break;


        case TIPO_PETALA:

            var _virada_petala =
                sin(
                    _efeito.fase
                    * 1.3
                );


            draw_set_alpha(
                _alpha
            );


            if (_virada_petala >= 0)
            {
                draw_rectangle(
                    _x,
                    _y,

                    _x
                        + _efeito.tamanho,

                    _y + 1,

                    false
                );
            }
            else
            {
                draw_rectangle(
                    _x,
                    _y,

                    _x + 1,

                    _y
                        + _efeito.tamanho,

                    false
                );
            }


            draw_set_alpha(
                _alpha * 0.42
            );


            draw_point(
                _x + 1,
                _y
            );

        break;
    }
}


// Restaura as configurações de desenho
draw_set_alpha(1);
draw_set_color(c_white);

#endregion