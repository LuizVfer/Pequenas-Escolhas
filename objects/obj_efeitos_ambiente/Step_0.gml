#region Delta time

var _delta =
    min(
        delta_time / 1000000,
        0.05
    );

#endregion

#region Poeira suspensa da cidade

if (poeira_cidade_ativa)
{
    tempo_proxima_poeira_cidade -=
        _delta;


    if (
        tempo_proxima_poeira_cidade <= 0
        && array_length(poeiras_cidade)
            < maximo_poeiras_cidade
    )
    {
        criar_poeira_cidade();


        tempo_proxima_poeira_cidade =
            random_range(
                0.20,
                0.45
            );
    }


    var _area_cidade =
        obter_area_camera();


    for (
        var _i =
            array_length(poeiras_cidade) - 1;

        _i >= 0;

        _i--
    )
    {
        var _poeira =
            poeiras_cidade[_i];


        _poeira.vida -=
            _delta;


        _poeira.fase +=
            _poeira.velocidade_fase
            * _delta;


        _poeira.x +=
            _poeira.velocidade_x
            * _delta;


        _poeira.y +=
        (
            _poeira.velocidade_y
            + sin(_poeira.fase)
            * _poeira.oscilacao
        )
        * _delta;


        if (
            _poeira.vida <= 0

            || _poeira.x
                < _area_cidade.x - 24

            || _poeira.x
                > _area_cidade.x
                + _area_cidade.largura
                + 24
        )
        {
            array_delete(
                poeiras_cidade,
                _i,
                1
            );
        }
        else
        {
            poeiras_cidade[_i] =
                _poeira;
        }
    }
}

#endregion

#region Fragmentos da vila

if (fragmentos_vila_ativos)
{
    tempo_proximo_fragmento_vila -=
        _delta;


    if (
        tempo_proximo_fragmento_vila <= 0
        && array_length(fragmentos_vila)
            < maximo_fragmentos_vila
    )
    {
        criar_fragmento_vila();


        tempo_proximo_fragmento_vila =
            random_range(
                0.45,
                0.90
            );
    }


    var _area_vila =
        obter_area_camera();


    for (
        var _i =
            array_length(fragmentos_vila) - 1;

        _i >= 0;

        _i--
    )
    {
        var _fragmento =
            fragmentos_vila[_i];


        _fragmento.vida -=
            _delta;


        _fragmento.fase +=
            _fragmento.velocidade_fase
            * _delta;


        _fragmento.x +=
            _fragmento.velocidade_x
            * _delta;


        _fragmento.y +=
        (
            _fragmento.velocidade_y
            + sin(_fragmento.fase)
            * _fragmento.oscilacao
        )
        * _delta;


        if (
            _fragmento.vida <= 0

            || _fragmento.x
                < _area_vila.x - 32

            || _fragmento.y
                < _area_vila.y - 24

            || _fragmento.y
                > _area_vila.y
                + _area_vila.altura
                + 24
        )
        {
            array_delete(
                fragmentos_vila,
                _i,
                1
            );
        }
        else
        {
            fragmentos_vila[_i] =
                _fragmento;
        }
    }
}

#endregion

#region Pétalas do destino

if (petalas_destino_ativas)
{
    tempo_proxima_petala_destino -=
        _delta;


    if (
        tempo_proxima_petala_destino <= 0
        && array_length(petalas_destino)
            < maximo_petalas_destino
    )
    {
        criar_petala_destino();


        tempo_proxima_petala_destino =
            random_range(
                0.55,
                1.10
            );
    }


    var _area_destino =
        obter_area_camera();


    for (
        var _i =
            array_length(petalas_destino) - 1;

        _i >= 0;

        _i--
    )
    {
        var _petala =
            petalas_destino[_i];


        _petala.vida -=
            _delta;


        _petala.fase +=
            _petala.velocidade_fase
            * _delta;


        _petala.x +=
            _petala.velocidade_x
            * _delta;


        _petala.y +=
        (
            _petala.velocidade_y
            + sin(_petala.fase)
            * _petala.oscilacao
        )
        * _delta;


        if (
            _petala.vida <= 0

            || _petala.x
                < _area_destino.x - 32

            || _petala.y
                < _area_destino.y + 170

            || _petala.y
                > _area_destino.y
                + _area_destino.altura
                + 16
        )
        {
            array_delete(
                petalas_destino,
                _i,
                1
            );
        }
        else
        {
            petalas_destino[_i] =
                _petala;
        }
    }
}

#endregion

#region Folhas da floresta

if (folhas_ativas)
{
    tempo_proxima_folha -=
        _delta;


    if (
        tempo_proxima_folha <= 0
        && array_length(folhas)
            < maximo_folhas
    )
    {
        criar_folha();


        tempo_proxima_folha =
            random_range(1.2, 2.2);
    }


    var _area_folhas =
        obter_area_camera();


    for (
        var _i = array_length(folhas) - 1;
        _i >= 0;
        _i--
    )
    {
        var _folha =
            folhas[_i];


        _folha.vida -=
            _delta;


        _folha.fase +=
            _folha.velocidade_fase
            * _delta;


        _folha.x +=
            _folha.velocidade_x
            * _delta;


        _folha.y +=
        (
            _folha.velocidade_y
            + sin(_folha.fase)
            * _folha.oscilacao
        )
        * _delta;


        if (
            _folha.vida <= 0
            || _folha.x
                < _area_folhas.x - 24
        )
        {
            array_delete(
                folhas,
                _i,
                1
            );
        }
        else
        {
            folhas[_i] =
                _folha;
        }
    }
}

#endregion

#region Vagalumes da floresta

if (vagalumes_ativos)
{
    tempo_proximo_vagalume -=
        _delta;


    if (
        tempo_proximo_vagalume <= 0
        && array_length(vagalumes)
            < maximo_vagalumes
    )
    {
        criar_vagalume();


        tempo_proximo_vagalume =
            random_range(0.7, 1.3);
    }


    for (
        var _i = array_length(vagalumes) - 1;
        _i >= 0;
        _i--
    )
    {
        var _vagalume =
            vagalumes[_i];


        _vagalume.vida -=
            _delta;


        _vagalume.fase +=
            _vagalume.velocidade_pulso
            * _delta;


        _vagalume.x +=
        (
            _vagalume.velocidade_x
            + sin(_vagalume.fase * 0.65)
            * 1.5
        )
        * _delta;


        _vagalume.y +=
        (
            _vagalume.velocidade_y
            + cos(_vagalume.fase * 0.8)
            * 1.5
        )
        * _delta;


        if (_vagalume.vida <= 0)
        {
            array_delete(
                vagalumes,
                _i,
                1
            );
        }
        else
        {
            vagalumes[_i] =
                _vagalume;
        }
    }
}

#endregion


#region Atualizar partículas

for (
    var _i = array_length(particulas) - 1;
    _i >= 0;
    _i--
)
{
    var _particula =
        particulas[_i];


    _particula.vida -= _delta;


    if (_particula.vida <= 0)
    {
        array_delete(
            particulas,
            _i,
            1
        );
    }
    else
    {
        _particula.velocidade_y +=
            _particula.gravidade
            * _delta;


        _particula.x +=
            _particula.velocidade_x
            * _delta;


        _particula.y +=
            _particula.velocidade_y
            * _delta;


        particulas[_i] =
            _particula;
    }
}

#endregion