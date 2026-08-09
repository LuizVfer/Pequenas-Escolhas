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