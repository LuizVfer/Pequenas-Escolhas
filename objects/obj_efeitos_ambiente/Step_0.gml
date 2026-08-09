#region Delta time

var _delta =
    min(
        delta_time / 1000000,
        0.05
    );

#endregion


#region Criar novos efeitos

switch (room)
{
    case rm_cidade:

        tempo_poeira_cidade -=
            _delta;

        tempo_fumaca_cidade -=
            _delta;


        if (
            tempo_poeira_cidade <= 0

            && contar_tipo(
                TIPO_POEIRA_CIDADE
            )
            < maximo_poeira_cidade
        )
        {
            criar_poeira_cidade();


            tempo_poeira_cidade =
                random_range(
                    0.14,
                    0.30
                );
        }


        if (
            tempo_fumaca_cidade <= 0

            && contar_tipo(
                TIPO_FUMACA_CIDADE
            )
            < maximo_fumaca_cidade
        )
        {
            criar_fumaca_cidade();


            tempo_fumaca_cidade =
                random_range(
                    0.40,
                    0.75
                );
        }

    break;


    case rm_floresta:

        tempo_folha -=
            _delta;

        tempo_vagalume -=
            _delta;

        tempo_polen -=
            _delta;


        if (
            tempo_folha <= 0

            && contar_tipo(
                TIPO_FOLHA
            )
            < maximo_folhas
        )
        {
            criar_folha();


            tempo_folha =
                random_range(
                    0.45,
                    0.90
                );
        }


        if (
            tempo_vagalume <= 0

            && contar_tipo(
                TIPO_VAGALUME
            )
            < maximo_vagalumes
        )
        {
            criar_vagalume();


            tempo_vagalume =
                random_range(
                    0.45,
                    0.90
                );
        }


        if (
            tempo_polen <= 0

            && contar_tipo(
                TIPO_POLEN
            )
            < maximo_polen
        )
        {
            criar_polen(
                polen_floresta_cor
            );


            tempo_polen =
                random_range(
                    0.35,
                    0.70
                );
        }

    break;


    case rm_vila:

        tempo_fragmento_vila -=
            _delta;

        tempo_rajada_vila -=
            _delta;


        if (
            tempo_fragmento_vila <= 0

            && contar_tipo(
                TIPO_FRAGMENTO_VILA
            )
            < maximo_fragmentos_vila
        )
        {
            criar_fragmento_vila();


            tempo_fragmento_vila =
                random_range(
                    0.28,
                    0.58
                );
        }


        if (
            tempo_rajada_vila <= 0

            && contar_tipo(
                TIPO_RAJADA_VILA
            )
            < maximo_rajadas_vila
        )
        {
            criar_rajada_vila();


            tempo_rajada_vila =
                random_range(
                    1.8,
                    3.2
                );
        }

    break;


    case rm_destino:

        tempo_petala -=
            _delta;

        tempo_polen -=
            _delta;

        tempo_brilho_destino -=
            _delta;


        if (
            tempo_petala <= 0

            && contar_tipo(
                TIPO_PETALA
            )
            < maximo_petalas
        )
        {
            criar_petala();


            tempo_petala =
                random_range(
                    0.30,
                    0.62
                );
        }


        if (
            tempo_polen <= 0

            && contar_tipo(
                TIPO_POLEN
            )
            < maximo_polen
        )
        {
            criar_polen(
                polen_destino_cor
            );


            tempo_polen =
                random_range(
                    0.45,
                    0.85
                );
        }


        if (
            tempo_brilho_destino <= 0

            && contar_tipo(
                TIPO_BRILHO_DESTINO
            )
            < maximo_brilhos_destino
        )
        {
            criar_brilho_destino();


            tempo_brilho_destino =
                random_range(
                    0.65,
                    1.15
                );
        }

    break;
}

#endregion


#region Atualizar efeitos

var _area =
    obter_area_camera();


for (
    var _i =
        array_length(efeitos) - 1;

    _i >= 0;

    _i--
)
{
    var _efeito =
        efeitos[_i];


    _efeito.vida -=
        _delta;


    _efeito.fase +=
        _efeito.velocidade_fase
        * _delta;


    switch (_efeito.tipo)
    {
        case TIPO_POEIRA_CIDADE:

            _efeito.x +=
                _efeito.velocidade_x
                * _delta;


            _efeito.y +=
                (
                    _efeito.velocidade_y

                    + sin(
                        _efeito.fase
                    )
                    * _efeito.amplitude
                )
                * _delta;

        break;


        case TIPO_FUMACA_CIDADE:

            _efeito.x +=
                (
                    _efeito.velocidade_x

                    + sin(
                        _efeito.fase
                    )
                    * _efeito.amplitude
                )
                * _delta;


            _efeito.y +=
                _efeito.velocidade_y
                * _delta;

        break;


        case TIPO_FOLHA:
        case TIPO_FRAGMENTO_VILA:
        case TIPO_PETALA:
        case TIPO_POLEN:

            _efeito.x +=
                _efeito.velocidade_x
                * _delta;


            _efeito.y +=
                (
                    _efeito.velocidade_y

                    + sin(
                        _efeito.fase
                    )
                    * _efeito.amplitude
                )
                * _delta;

        break;


        case TIPO_VAGALUME:
        case TIPO_BRILHO_DESTINO:

            _efeito.x +=
                (
                    _efeito.velocidade_x

                    + sin(
                        _efeito.fase
                        * 0.65
                    )
                    * _efeito.amplitude
                )
                * _delta;


            _efeito.y +=
                (
                    _efeito.velocidade_y

                    + cos(
                        _efeito.fase
                        * 0.8
                    )
                    * _efeito.amplitude
                )
                * _delta;

        break;


        case TIPO_RAJADA_VILA:

            _efeito.x +=
                _efeito.velocidade_x
                * _delta;

        break;
    }


    var _fora_da_camera =
        _efeito.x
            < _area.x - 128

        || _efeito.x
            > _area.x
            + _area.largura
            + 128

        || _efeito.y
            < _area.y - 96

        || _efeito.y
            > _area.y
            + _area.altura
            + 96;


    if (
        _efeito.vida <= 0
        || _fora_da_camera
    )
    {
        array_delete(
            efeitos,
            _i,
            1
        );
    }
    else
    {
        efeitos[_i] =
            _efeito;
    }
}

#endregion