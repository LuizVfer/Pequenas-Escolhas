#region Tipos e estado geral

TIPO_POEIRA_CIDADE = 0;
TIPO_FUMACA_CIDADE = 1;
TIPO_FOLHA = 2;
TIPO_VAGALUME = 3;
TIPO_POLEN = 4;
TIPO_FRAGMENTO_VILA = 5;
TIPO_RAJADA_VILA = 6;
TIPO_PETALA = 7;
TIPO_BRILHO_DESTINO = 8;

efeitos = [];
maximo_total_efeitos = 56;

tempo_poeira_cidade = 0.05;
tempo_fumaca_cidade = 0.20;
tempo_folha = 0.10;
tempo_vagalume = 0.10;
tempo_polen = 0.10;
tempo_fragmento_vila = 0.10;
tempo_rajada_vila = 0.40;
tempo_petala = 0.10;
tempo_brilho_destino = 0.20;

maximo_poeira_cidade = 24;
maximo_fumaca_cidade = 8;
maximo_folhas = 14;
maximo_vagalumes = 10;
maximo_polen = 14;
maximo_fragmentos_vila = 18;
maximo_rajadas_vila = 3;
maximo_petalas = 18;
maximo_brilhos_destino = 8;

#endregion


#region Paletas

poeira_cidade_cor_1 =
    make_color_rgb(210, 196, 162);

poeira_cidade_cor_2 =
    make_color_rgb(176, 158, 126);

fumaca_cidade_cor_1 =
    make_color_rgb(176, 184, 180);

fumaca_cidade_cor_2 =
    make_color_rgb(143, 154, 153);


folha_cor_1 =
    make_color_rgb(65, 89, 56);

folha_cor_2 =
    make_color_rgb(48, 74, 46);

folha_cor_3 =
    make_color_rgb(106, 86, 63);

polen_floresta_cor =
    make_color_rgb(174, 166, 105);

vagalume_cor =
    make_color_rgb(226, 207, 111);


palha_cor_1 =
    make_color_rgb(221, 190, 119);

palha_cor_2 =
    make_color_rgb(190, 151, 84);

semente_cor =
    make_color_rgb(135, 103, 69);

rajada_vila_cor =
    make_color_rgb(222, 196, 143);


petala_cor_1 =
    make_color_rgb(224, 170, 157);

petala_cor_2 =
    make_color_rgb(235, 205, 170);

petala_cor_3 =
    make_color_rgb(195, 132, 126);

polen_destino_cor =
    make_color_rgb(226, 215, 151);

brilho_destino_cor =
    make_color_rgb(221, 231, 171);


// Posição da chaminé existente
// no fundo da Cidade
fontes_fumaca_cidade =
[
    {
        x: 1608,
        y: 29
    }
];

#endregion


#region Funções auxiliares

obter_area_camera = function()
{
    var _camera =
        view_camera[0];


    if (_camera == -1)
    {
        return {
            x: 0,
            y: 0,
            largura: 640,
            altura: 360
        };
    }


    return {
        x:
            camera_get_view_x(
                _camera
            ),

        y:
            camera_get_view_y(
                _camera
            ),

        largura:
            camera_get_view_width(
                _camera
            ),

        altura:
            camera_get_view_height(
                _camera
            )
    };
};


contar_tipo = function(_tipo)
{
    var _quantidade = 0;


    for (
        var _i = 0;
        _i < array_length(efeitos);
        _i++
    )
    {
        if (efeitos[_i].tipo == _tipo)
        {
            _quantidade++;
        }
    }


    return _quantidade;
};


adicionar_efeito = function(
    _tipo,
    _x,
    _y,
    _velocidade_x,
    _velocidade_y,
    _vida,
    _tamanho,
    _cor,
    _alpha,
    _velocidade_fase,
    _amplitude,
    _subtipo = 0
)
{
    if (
        array_length(efeitos)
        >= maximo_total_efeitos
    )
    {
        return false;
    }


    array_push(
        efeitos,
        {
            tipo: _tipo,
            subtipo: _subtipo,

            x: _x,
            y: _y,

            velocidade_x:
                _velocidade_x,

            velocidade_y:
                _velocidade_y,

            vida: _vida,
            vida_total: _vida,

            tamanho: _tamanho,
            cor: _cor,
            alpha: _alpha,

            fase:
                random_range(
                    0,
                    pi * 2
                ),

            velocidade_fase:
                _velocidade_fase,

            amplitude:
                _amplitude
        }
    );


    return true;
};


obter_x_surgimento = function(
    _area,
    _inicial
)
{
    if (_inicial)
    {
        return
            _area.x
            + random_range(
                8,
                _area.largura - 8
            );
    }


    return
        _area.x
        + _area.largura
        + random_range(
            4,
            28
        );
};

#endregion


#region Criar poeira da Cidade

criar_poeira_cidade = function()
{
    var _area =
        obter_area_camera();

    var _vida =
        random_range(5, 9);


    return adicionar_efeito(
        TIPO_POEIRA_CIDADE,

        _area.x
            + random_range(
                16,
                _area.largura - 16
            ),

        _area.y
            + random_range(
                46,
                _area.altura - 46
            ),

        random_range(-10, -4),
        random_range(-0.8, 0.8),

        _vida,

        irandom_range(1, 3),

        choose(
            poeira_cidade_cor_1,
            poeira_cidade_cor_2
        ),

        random_range(0.32, 0.58),
        random_range(1.1, 2.4),
        random_range(2, 5)
    );
};

#endregion


#region Criar fumaça da Cidade

criar_fumaca_cidade = function()
{
    var _area =
        obter_area_camera();

    var _fonte =
        noone;


    for (
        var _i = 0;
        _i
            < array_length(
                fontes_fumaca_cidade
            );
        _i++
    )
    {
        var _candidata =
            fontes_fumaca_cidade[_i];


        if (
            _candidata.x
                >= _area.x - 24

            && _candidata.x
                <= _area.x
                + _area.largura
                + 24
        )
        {
            _fonte =
                _candidata;

            break;
        }
    }


    if (!is_struct(_fonte))
    {
        return false;
    }


    var _vida =
        random_range(4, 6.5);


    return adicionar_efeito(
        TIPO_FUMACA_CIDADE,

        _fonte.x
            + random_range(-2, 2),

        _fonte.y
            + random_range(-1, 1),

        random_range(-4, 1),
        random_range(-10, -6),

        _vida,

        irandom_range(2, 3),

        choose(
            fumaca_cidade_cor_1,
            fumaca_cidade_cor_2
        ),

        random_range(0.18, 0.30),
        random_range(1, 1.8),
        random_range(0.8, 2)
    );
};

#endregion


#region Criar folha

criar_folha = function(
    _inicial = false
)
{
    var _area =
        obter_area_camera();

    var _vida =
        random_range(13, 19);


    return adicionar_efeito(
        TIPO_FOLHA,

        obter_x_surgimento(
            _area,
            _inicial
        ),

        _area.y
            + random_range(
                44,
                _area.altura - 42
            ),

        random_range(-50, -28),
        random_range(-2, 3),

        _vida,

        irandom_range(1, 3),

        choose(
            folha_cor_1,
            folha_cor_2,
            folha_cor_3
        ),

        random_range(0.42, 0.68),
        random_range(1.8, 3.4),
        random_range(5, 11)
    );
};

#endregion


#region Criar pólen

criar_polen = function(
    _cor,
    _inicial = false
)
{
    var _area =
        obter_area_camera();

    var _vida =
        random_range(7, 12);


    return adicionar_efeito(
        TIPO_POLEN,

        obter_x_surgimento(
            _area,
            _inicial
        ),

        _area.y
            + random_range(
                105,
                _area.altura - 36
            ),

        random_range(-12, -4),
        random_range(-1.2, 0.8),

        _vida,

        irandom_range(1, 2),

        _cor,

        random_range(0.28, 0.50),
        random_range(1.2, 2.5),
        random_range(2.5, 5.5)
    );
};

#endregion


#region Criar vagalume

criar_vagalume = function()
{
    var _area =
        obter_area_camera();

    var _vida =
        random_range(5, 8);


    return adicionar_efeito(
        TIPO_VAGALUME,

        _area.x
            + random_range(
                28,
                _area.largura - 28
            ),

        _area.y
            + random_range(
                190,
                312
            ),

        random_range(-4, 4),
        random_range(-2, 2),

        _vida,

        1,

        vagalume_cor,

        random_range(0.55, 0.82),
        random_range(2.2, 4.2),
        random_range(1, 2.2)
    );
};

#endregion


#region Criar fragmento da Vila

criar_fragmento_vila = function(
    _inicial = false
)
{
    var _area =
        obter_area_camera();

    var _vida =
        random_range(9, 15);


    // 0 = palha
    // 1 = semente
    var _subtipo =
        irandom(3) == 0
        ? 1
        : 0;


    return adicionar_efeito(
        TIPO_FRAGMENTO_VILA,

        obter_x_surgimento(
            _area,
            _inicial
        ),

        _area.y
            + random_range(
                72,
                310
            ),

        random_range(-42, -24),
        random_range(-1.5, 1.5),

        _vida,

        _subtipo == 0
            ? irandom_range(3, 6)
            : 1,

        _subtipo == 0
            ? choose(
                palha_cor_1,
                palha_cor_2
            )
            : semente_cor,

        random_range(0.62, 0.88),
        random_range(2, 3.8),
        random_range(4, 9),

        _subtipo
    );
};

#endregion


#region Criar rajada da Vila

criar_rajada_vila = function(
    _inicial = false
)
{
    var _area =
        obter_area_camera();

    var _vida =
        random_range(7, 10);


    return adicionar_efeito(
        TIPO_RAJADA_VILA,

        obter_x_surgimento(
            _area,
            _inicial
        ),

        _area.y
            + random_range(
                255,
                310
            ),

        random_range(-74, -52),
        0,

        _vida,

        irandom_range(20, 38),

        rajada_vila_cor,

        random_range(0.14, 0.24),
        random_range(2, 3),
        0
    );
};

#endregion


#region Criar pétala

criar_petala = function(
    _inicial = false
)
{
    var _area =
        obter_area_camera();

    var _vida =
        random_range(9, 14);


    return adicionar_efeito(
        TIPO_PETALA,

        obter_x_surgimento(
            _area,
            _inicial
        ),

        _area.y
            + random_range(
                175,
                316
            ),

        random_range(-34, -19),
        random_range(-1, 1.5),

        _vida,

        irandom_range(2, 3),

        choose(
            petala_cor_1,
            petala_cor_2,
            petala_cor_3
        ),

        random_range(0.68, 0.92),
        random_range(2, 3.8),
        random_range(5, 10)
    );
};

#endregion


#region Criar brilho do Destino

criar_brilho_destino = function()
{
    var _area =
        obter_area_camera();

    var _vida =
        random_range(4.5, 7);


    return adicionar_efeito(
        TIPO_BRILHO_DESTINO,

        _area.x
            + random_range(
                28,
                _area.largura - 28
            ),

        _area.y
            + random_range(
                190,
                305
            ),

        random_range(-2.5, 2.5),
        random_range(-1.6, 1.6),

        _vida,

        1,

        brilho_destino_cor,

        random_range(0.36, 0.58),
        random_range(1.8, 3.2),
        random_range(0.8, 1.8)
    );
};

#endregion


#region Preencher a tela ao entrar

// Evita que a room comece vazia
// enquanto os efeitos estão surgindo
switch (room)
{
    case rm_cidade:

        repeat (18)
        {
            criar_poeira_cidade();
        }

    break;


    case rm_floresta:

        repeat (10)
        {
            criar_folha(true);
        }


        repeat (10)
        {
            criar_polen(
                polen_floresta_cor,
                true
            );
        }


        repeat (7)
        {
            criar_vagalume();
        }

    break;


    case rm_vila:

        repeat (13)
        {
            criar_fragmento_vila(true);
        }


        repeat (2)
        {
            criar_rajada_vila(true);
        }

    break;


    case rm_destino:

        repeat (13)
        {
            criar_petala(true);
        }


        repeat (8)
        {
            criar_polen(
                polen_destino_cor,
                true
            );
        }


        repeat (5)
        {
            criar_brilho_destino();
        }

    break;
}

#endregion