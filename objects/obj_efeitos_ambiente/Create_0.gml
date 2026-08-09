#region Configuração geral

particulas = [];

acumulador_distancia = 0;

poeira_ativa = false;
poeira_distancia = 10;

poeira_cor_1 = c_white;
poeira_cor_2 = c_white;
poeira_alpha = 0.25;

#endregion

#region Efeitos da floresta

folhas = [];
vagalumes = [];

folhas_ativas = false;
vagalumes_ativos = false;


// Controladores de surgimento
tempo_proxima_folha = 0.4;
tempo_proximo_vagalume = 0.2;


// Quantidade máxima simultânea
maximo_folhas = 8;
maximo_vagalumes = 7;


// Paleta padrão
folha_cor_1 = c_white;
folha_cor_2 = c_white;
folha_cor_3 = c_white;

vagalume_cor = c_white;

#endregion

#region Efeito da cidade

poeiras_cidade = [];

poeira_cidade_ativa = false;

tempo_proxima_poeira_cidade = 0.1;

maximo_poeiras_cidade = 20;


poeira_cidade_cor_1 =
    c_white;

poeira_cidade_cor_2 =
    c_white;

#endregion

#region Efeito da vila

fragmentos_vila = [];

fragmentos_vila_ativos = false;

tempo_proximo_fragmento_vila = 0.15;

maximo_fragmentos_vila = 12;


palha_cor_1 = c_white;
palha_cor_2 = c_white;
semente_cor = c_white;

#endregion

#region Efeito do destino

petalas_destino = [];

petalas_destino_ativas = false;

tempo_proxima_petala_destino = 0.15;

maximo_petalas_destino = 10;


petala_cor_1 = c_white;
petala_cor_2 = c_white;
petala_cor_3 = c_white;

#endregion


#region Configuração por região

switch (room)
{
    case rm_cidade:

        // Piso de pedra: poeira bem discreta
        poeira_ativa = true;
        poeira_distancia = 14;

        poeira_cor_1 =
            make_color_rgb(163, 150, 110);

        poeira_cor_2 =
            make_color_rgb(132, 124, 98);

        poeira_alpha = 0.18;
        
        // Poeira leve suspensa no ar
        poeira_cidade_ativa = true;
        
        
        poeira_cidade_cor_1 =
            make_color_rgb(
                210,
                196,
                162
            );
        
        
        poeira_cidade_cor_2 =
            make_color_rgb(
                176,
                158,
                126
            );

    break;


    case rm_floresta:

        // Terra escura e folhas secas
        poeira_ativa = true;
        poeira_distancia = 9;

        poeira_cor_1 =
            make_color_rgb(87, 68, 55);

        poeira_cor_2 =
            make_color_rgb(106, 86, 63);

        poeira_alpha = 0.28;
        
        // Folhas e vagalumes exclusivos da floresta
        folhas_ativas = true;
        vagalumes_ativos = true;
        
        
        // Verdes e marrons da vegetação
        folha_cor_1 =
            make_color_rgb(65, 89, 56);
        
        folha_cor_2 =
            make_color_rgb(48, 74, 46);
        
        folha_cor_3 =
            make_color_rgb(106, 86, 63);
        
        
        // Amarelo desaturado
        vagalume_cor =
            make_color_rgb(206, 189, 106);

    break;


    case rm_vila:

        // Chão seco próximo da plantação
        poeira_ativa = true;
        poeira_distancia = 7;

        poeira_cor_1 =
            make_color_rgb(170, 138, 94);

        poeira_cor_2 =
            make_color_rgb(148, 114, 76);

        poeira_alpha = 0.30;
        
        // Palhas e sementes levadas pelo vento
        fragmentos_vila_ativos = true;
        
        
        palha_cor_1 =
            make_color_rgb(
                221,
                190,
                119
            );
        
        
        palha_cor_2 =
            make_color_rgb(
                190,
                151,
                84
            );
        
        
        semente_cor =
            make_color_rgb(
                135,
                103,
                69
            );

    break;

    case rm_destino:

        // Pétalas próximas das flores
        petalas_destino_ativas = true;
    
    
        petala_cor_1 =
            make_color_rgb(
                224,
                170,
                157
            );
    
    
        petala_cor_2 =
            make_color_rgb(
                235,
                205,
                170
            );
    
    
        petala_cor_3 =
            make_color_rgb(
                195,
                132,
                126
            );
    
    break;
}

#endregion



#region Criar partícula

criar_particula = function(
    _x,
    _y,
    _velocidade_x,
    _velocidade_y,
    _gravidade,
    _vida,
    _largura,
    _altura,
    _cor,
    _alpha
)
{
    var _particula =
    {
        x: _x,
        y: _y,

        velocidade_x: _velocidade_x,
        velocidade_y: _velocidade_y,

        gravidade: _gravidade,

        vida: _vida,
        vida_total: _vida,

        largura: _largura,
        altura: _altura,

        cor: _cor,
        alpha: _alpha
    };


    array_push(
        particulas,
        _particula
    );
};

#endregion


#region Criar poeira dos passos

criar_poeira_passos = function(
    _player,
    _direcao
)
{
    var _origem_x =
        _player.x
        - _direcao * 5
        + random_range(-2, 2);


    var _origem_y =
        _player.bbox_bottom
        - 1;


    var _cor =
        choose(
            poeira_cor_1,
            poeira_cor_2
        );


    var _velocidade_x =
        -_direcao
        * random_range(8, 14)
        + random_range(-3, 3);


    var _velocidade_y =
        random_range(-9, -5);


    criar_particula(
        _origem_x,
        _origem_y,

        _velocidade_x,
        _velocidade_y,

        18,

        random_range(0.28, 0.42),

       irandom_range(2, 3),
        2,
        
        _cor,
        poeira_alpha
    );
};

#endregion

#region Área visível da câmera

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
        x: camera_get_view_x(_camera),
        y: camera_get_view_y(_camera),

        largura:
            camera_get_view_width(_camera),

        altura:
            camera_get_view_height(_camera)
    };
};

#endregion

#region Criar poeira da cidade

criar_poeira_cidade = function()
{
    var _area =
        obter_area_camera();


    var _vida =
        random_range(
            6,
            10
        );


    var _poeira =
    {
        // Surge suavemente em algum ponto
        // da área visível
        x:
            _area.x
            + random_range(
                20,
                _area.largura - 20
            ),

        y:
            _area.y
            + random_range(
                55,
                _area.altura - 65
            ),


        // Vento lento para a esquerda
        velocidade_x:
            random_range(
                -11,
                -5
            ),

        velocidade_y:
            random_range(
                -1.2,
                0.6
            ),


        oscilacao:
            random_range(
                2,
                4
            ),

        fase:
            random_range(
                0,
                pi * 2
            ),

        velocidade_fase:
            random_range(
                1.2,
                2.2
            ),


        vida: _vida,
        vida_total: _vida,

        tamanho:
            irandom_range(
                2,
                3
            ),

        cor:
            choose(
                poeira_cidade_cor_1,
                poeira_cidade_cor_2
            ),

        alpha:
        random_range(
            0.55,
            0.80
        )
    };


    array_push(
        poeiras_cidade,
        _poeira
    );
};

#endregion

#region Criar fragmento da vila

criar_fragmento_vila = function()
{
    var _area =
        obter_area_camera();


    var _vida =
        random_range(
            9,
            15
        );


    // 0 = palha
    // 1 = semente
    var _tipo =
        irandom(3) == 0
        ? 1
        : 0;


    var _fragmento =
    {
        // Nasce à direita da câmera
        x:
            _area.x
            + _area.largura
            + random_range(
                4,
                24
            ),

        y:
            _area.y
            + random_range(
                70,
                285
            ),


        velocidade_x:
            random_range(
                -38,
                -22
            ),

        velocidade_y:
            random_range(
                -1.5,
                1.5
            ),


        oscilacao:
            random_range(
                4,
                8
            ),

        fase:
            random_range(
                0,
                pi * 2
            ),

        velocidade_fase:
            random_range(
                2,
                3.5
            ),


        vida: _vida,
        vida_total: _vida,

        tipo: _tipo,

        tamanho:
            _tipo == 0
            ? irandom_range(3, 5)
            : 1,

        cor:
            _tipo == 0
            ? choose(
                palha_cor_1,
                palha_cor_2
            )
            : semente_cor,

        alpha:
            random_range(
                0.55,
                0.80
            )
    };


    array_push(
        fragmentos_vila,
        _fragmento
    );
};

#endregion

#region Criar pétala do destino

criar_petala_destino = function()
{
    var _area =
        obter_area_camera();


    var _vida =
        random_range(
            9,
            14
        );


    var _petala =
    {
        // Surge à direita da câmera
        // e próxima da vegetação
        x:
            _area.x
            + _area.largura
            + random_range(
                6,
                24
            ),

        y:
            _area.y
            + random_range(
                210,
                _area.altura - 48
            ),


        velocidade_x:
            random_range(
                -30,
                -18
            ),

        velocidade_y:
            random_range(
                -1,
                1.5
            ),


        oscilacao:
            random_range(
                5,
                9
            ),

        fase:
            random_range(
                0,
                pi * 2
            ),

        velocidade_fase:
            random_range(
                2,
                3.6
            ),


        vida: _vida,
        vida_total: _vida,

        tamanho:
            irandom_range(
                2,
                3
            ),

        cor:
            choose(
                petala_cor_1,
                petala_cor_2,
                petala_cor_3
            ),

        alpha:
            random_range(
                0.65,
                0.90
            )
    };


    array_push(
        petalas_destino,
        _petala
    );
};

#endregion

#region Criar folha

criar_folha = function()
{
    var _area =
        obter_area_camera();


    var _folha =
    {
        // A folha nasce um pouco fora
        // do lado direito da câmera
        x:
            _area.x
            + _area.largura
            + random_range(4, 20),

        y:
            _area.y
            + random_range(
                45,
                _area.altura - 55
            ),


        velocidade_x:
            random_range(-46, -28),

        velocidade_y:
            random_range(-2, 3),


        oscilacao:
            random_range(5, 10),

        fase:
            random_range(0, pi * 2),

        velocidade_fase:
            random_range(1.8, 3.2),


        vida: 18,
        vida_total: 18,

        tamanho:
            irandom_range(1, 2),

        cor:
            choose(
                folha_cor_1,
                folha_cor_2,
                folha_cor_3
            ),

        alpha:
            random_range(0.28, 0.48)
    };


    array_push(
        folhas,
        _folha
    );
};

#endregion


#region Criar vagalume

criar_vagalume = function()
{
    var _area =
        obter_area_camera();


    var _vida =
        random_range(4.5, 7);


    var _vagalume =
    {
        // Surge na região baixa da floresta,
        // perto da vegetação
        x:
            _area.x
            + random_range(
                35,
                _area.largura - 35
            ),

        y:
            _area.y
            + random_range(
                205,
                310
            ),


        velocidade_x:
            random_range(-3, 3),

        velocidade_y:
            random_range(-1.5, 1.5),


        fase:
            random_range(0, pi * 2),

        velocidade_pulso:
            random_range(2, 4),


        vida: _vida,
        vida_total: _vida,

        cor: vagalume_cor,

        alpha:
            random_range(0.40, 0.65)
    };


    array_push(
        vagalumes,
        _vagalume
    );
};

#endregion