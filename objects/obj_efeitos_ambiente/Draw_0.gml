#region Desenhar poeira da cidade

for (
    var _i = 0;
    _i < array_length(poeiras_cidade);
    _i++
)
{
    var _poeira =
        poeiras_cidade[_i];


    var _tempo_vivo =
        _poeira.vida_total
        - _poeira.vida;


    // Aparece e desaparece suavemente
    var _entrada =
        clamp(
            _tempo_vivo / 0.35,
            0,
            1
        );


    var _saida =
        clamp(
            _poeira.vida / 0.75,
            0,
            1
        );


    var _alpha =
        _poeira.alpha
        * _entrada
        * _saida;


    var _x =
        round(_poeira.x);


    var _y =
        round(_poeira.y);


    draw_set_color(
        _poeira.cor
    );


    // Grão principal
    draw_set_alpha(
        _alpha
    );


    draw_rectangle(
        _x,
        _y,

        _x + _poeira.tamanho,
        _y + 1,

        false
    );


    // Pequeno grão atrás
    draw_set_alpha(
        _alpha * 0.55
    );


    draw_rectangle(
        _x
            + _poeira.tamanho
            + 3,

        _y,

        _x
            + _poeira.tamanho
            + 4,

        _y + 1,

        false
    );
}

#endregion

#region Desenhar fragmentos da vila

for (
    var _i = 0;
    _i < array_length(fragmentos_vila);
    _i++
)
{
    var _fragmento =
        fragmentos_vila[_i];


    var _tempo_vivo =
        _fragmento.vida_total
        - _fragmento.vida;


    var _entrada =
        clamp(
            _tempo_vivo / 0.35,
            0,
            1
        );


    var _saida =
        clamp(
            _fragmento.vida / 0.8,
            0,
            1
        );


    var _alpha =
        _fragmento.alpha
        * _entrada
        * _saida;


    var _x =
        round(_fragmento.x);


    var _y =
        round(_fragmento.y);


    draw_set_color(
        _fragmento.cor
    );


    draw_set_alpha(
        _alpha
    );


    if (_fragmento.tipo == 0)
    {
        // Palha inclinando enquanto gira
        var _inclinacao =
            sign(
                sin(
                    _fragmento.fase * 1.4
                )
            );


        draw_line(
            _x,
            _y,

            _x + _fragmento.tamanho,
            _y + _inclinacao
        );
    }
    else
    {
        // Pequena semente
        draw_rectangle(
            _x,
            _y,
            _x + 1,
            _y + 1,
            false
        );
    }
}

#endregion

#region Desenhar pétalas do destino

for (
    var _i = 0;
    _i < array_length(petalas_destino);
    _i++
)
{
    var _petala =
        petalas_destino[_i];


    var _tempo_vivo =
        _petala.vida_total
        - _petala.vida;


    var _entrada =
        clamp(
            _tempo_vivo / 0.35,
            0,
            1
        );


    var _saida =
        clamp(
            _petala.vida / 0.8,
            0,
            1
        );


    var _alpha =
        _petala.alpha
        * _entrada
        * _saida;


    var _x =
        round(_petala.x);


    var _y =
        round(_petala.y);


    var _virada =
        sin(
            _petala.fase * 1.3
        );


    draw_set_color(
        _petala.cor
    );


    draw_set_alpha(
        _alpha
    );


    if (_virada >= 0)
    {
        // Pétala virada horizontalmente
        draw_rectangle(
            _x,
            _y,

            _x + _petala.tamanho,
            _y + 1,

            false
        );
    }
    else
    {
        // Pétala virada verticalmente
        draw_rectangle(
            _x,
            _y,

            _x + 1,
            _y + _petala.tamanho,

            false
        );
    }


    // Pequeno brilho em uma das extremidades
    draw_set_alpha(
        _alpha * 0.45
    );


    draw_point(
        _x + 1,
        _y
    );
}

#endregion

#region Desenhar folhas

for (
    var _i = 0;
    _i < array_length(folhas);
    _i++
)
{
    var _folha =
        folhas[_i];


    var _tempo_vivo =
        _folha.vida_total
        - _folha.vida;


    var _entrada =
        clamp(
            _tempo_vivo / 0.5,
            0,
            1
        );


    var _saida =
        clamp(
            _folha.vida / 1.2,
            0,
            1
        );


    var _alpha =
        _folha.alpha
        * _entrada
        * _saida;


    var _x =
        round(_folha.x);


    var _y =
        round(_folha.y);


    // Simula a folha virando no vento
    var _inclinacao =
        sign(
            sin(
                _folha.fase * 1.6
            )
        );


    draw_set_color(
        _folha.cor
    );


    draw_set_alpha(
        _alpha
    );


    draw_rectangle(
        _x,
        _y,
    
        _x + _folha.tamanho + 1,
        _y + 1,
    
        false
    );
}

#endregion

#region Desenhar vagalumes

for (
    var _i = 0;
    _i < array_length(vagalumes);
    _i++
)
{
    var _vagalume =
        vagalumes[_i];


    var _tempo_vivo =
        _vagalume.vida_total
        - _vagalume.vida;


    // Entrada e saída suaves
    var _entrada =
        clamp(
            _tempo_vivo / 0.6,
            0,
            1
        );


    var _saida =
        clamp(
            _vagalume.vida / 0.8,
            0,
            1
        );


    // Cada vagalume pulsa em um ritmo diferente
    var _pulso =
        0.25
        + 0.75
        * (
            0.5
            + 0.5
            * sin(_vagalume.fase)
        );


    var _alpha =
        _vagalume.alpha
        * _entrada
        * _saida
        * _pulso;


    var _x =
        round(_vagalume.x);


    var _y =
        round(_vagalume.y);


    draw_set_color(
        _vagalume.cor
    );


    // Brilho externo
    draw_set_alpha(
        _alpha * 0.30
    );
    
    draw_rectangle(
        _x - 1,
        _y - 1,
        _x + 2,
        _y + 2,
        false
    );
    
    
    // Centro luminoso
    draw_set_alpha(
        _alpha
    );
    
    draw_rectangle(
        _x,
        _y,
        _x + 1,
        _y + 1,
        false
    );
}

#endregion

#region Desenhar partículas

for (
    var _i = 0;
    _i < array_length(particulas);
    _i++
)
{
    var _particula =
        particulas[_i];


    var _proporcao_vida =
        clamp(
            _particula.vida
            / _particula.vida_total,

            0,
            1
        );


    var _alpha =
        _particula.alpha
        * sqr(_proporcao_vida);


    var _x =
        round(_particula.x);


    var _y =
        round(_particula.y);


    draw_set_color(
        _particula.cor
    );


    draw_set_alpha(
        _alpha
    );


    draw_rectangle(
        _x,
        _y,
    
        _x
            + _particula.largura,
    
        _y
            + _particula.altura,
    
        false
    );
}


draw_set_alpha(1);
draw_set_color(c_white);

#endregion