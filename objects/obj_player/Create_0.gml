#region Movimento

vel_max = 2;
aceleracao = 0.25;
desaceleracao = 0.35;

hsp = 0;
direcao = 1;

// Guarda movimentos menores que 1 pixel
x_resto = 0;

#endregion


#region Interação

// Objeto interagível selecionado
interagivel_atual = noone;


// Último alvo usado pelo indicador
indicador_alvo_anterior = noone;


// Posição desenhada na room
indicador_x = x;
indicador_y = y;


// Estado da animação
indicador_alpha = 0;
indicador_tempo = 0;

#endregion


#region Animações

velocidade_idle = 1;
velocidade_walk = 1;
velocidade_martelo = 1;


// Permite que o projeto continue funcionando
// mesmo antes de o sprite ser criado
sprite_martelando =
    asset_get_index(
        "spr_player_martelando"
    );


animacao_martelo_ativa = false;
contador_animacao_martelo = 0;


// --------------------------------------------------
// Trocar animação
// --------------------------------------------------

definir_animacao = function(
    _sprite,
    _velocidade,
    _reiniciar = false
)
{
    if (_sprite < 0)
    {
        return false;
    }


    if (
        sprite_index != _sprite
        || _reiniciar
    )
    {
        sprite_index = _sprite;
        image_index = 0;
    }


    // Sprites com somente um frame
    // devem permanecer parados
    if (sprite_get_number(_sprite) <= 1)
    {
        image_speed = 0;
    }
    else
    {
        image_speed = _velocidade;
    }


    return true;
};


// --------------------------------------------------
// Animações normais
// --------------------------------------------------

usar_animacao_idle = function(
    _reiniciar = false
)
{
    return definir_animacao(
        spr_player_idle,
        velocidade_idle,
        _reiniciar
    );
};


usar_animacao_walk = function(
    _reiniciar = false
)
{
    return definir_animacao(
        spr_player_walk,
        velocidade_walk,
        _reiniciar
    );
};


// --------------------------------------------------
// Martelada
// --------------------------------------------------

iniciar_animacao_martelo = function()
{
    if (sprite_martelando < 0)
    {
        show_debug_message(
            "AVISO: spr_player_martelando ainda não foi criado."
        );

        return false;
    }


    animacao_martelo_ativa = true;


    definir_animacao(
        sprite_martelando,
        velocidade_martelo,
        true
    );


    contador_animacao_martelo =
        max(
            1,

            ceil(
                sprite_get_number(
                    sprite_martelando
                )
                / velocidade_martelo
            )
        );


    return true;
};


atualizar_animacao_martelo = function()
{
    if (!animacao_martelo_ativa)
    {
        return false;
    }


    hsp = 0;
    x_resto = 0;

    contador_animacao_martelo--;


    if (contador_animacao_martelo <= 0)
    {
        animacao_martelo_ativa = false;
        contador_animacao_martelo = 0;

        usar_animacao_idle(true);

        return false;
    }


    return true;
};

#endregion


#region Som dos passos

// Posição usada para calcular
// quanto o jogador realmente andou
x_anterior_passos = x;

distancia_passos_acumulada = 0;
distancia_entre_passos = 70;

passo_alternado = false;

#endregion

#region Poeira dos passos

poeira_passos_ativa =
    room == rm_cidade
    || room == rm_floresta
    || room == rm_vila;


distancia_poeira_acumulada = 0;


// Quantos pixels o jogador percorre
// antes de produzir poeira
switch (room)
{
    case rm_cidade:
        distancia_entre_poeiras = 14;
    break;


    case rm_floresta:
        distancia_entre_poeiras = 9;
    break;


    case rm_vila:
        distancia_entre_poeiras = 7;
    break;


    default:
        distancia_entre_poeiras = 10;
    break;
}

#endregion


#region Métodos de movimento

ler_input_horizontal = function()
{
    var _direita =
        keyboard_check(ord("D"))
        || keyboard_check(vk_right);


    var _esquerda =
        keyboard_check(ord("A"))
        || keyboard_check(vk_left);


    return _direita - _esquerda;
};


mover_horizontal = function(
    _velocidade
)
{
    var _x_anterior = x;


    // Acumula a parte decimal
    x_resto += _velocidade;


    var _movimento =
        floor(abs(x_resto))
        * sign(x_resto);


    x_resto -= _movimento;


    var _passo =
        sign(_movimento);


    // Movimento pixel por pixel
    repeat (abs(_movimento))
    {
        if (
            !place_meeting(
                x + _passo,
                y,
                obj_solid
            )
        )
        {
            x += _passo;
        }
        else
        {
            hsp = 0;
            x_resto = 0;

            break;
        }
    }


    x =
        clamp(
            x,
            16,
            room_width - 16
        );


    return x != _x_anterior;
};

#endregion


#region Estados

// ==================================================
// ESTADO PARADO
// ==================================================

estado_parado = new estado();


estado_parado.inicia = function()
{
    if (abs(hsp) <= 0.01)
    {
        hsp = 0;
        usar_animacao_idle();
    }
};


estado_parado.roda = function()
{
    if (global.controle_bloqueado)
    {
        troca_estado(
            estado_bloqueado
        );

        return;
    }


    var _dir =
        ler_input_horizontal();


    if (_dir != 0)
    {
        troca_estado(
            estado_andando
        );

        return;
    }


    // Desaceleração
    if (abs(hsp) <= desaceleracao)
    {
        hsp = 0;
    }
    else
    {
        hsp -=
            sign(hsp)
            * desaceleracao;
    }


    var _moveu =
        mover_horizontal(hsp);


    // Enquanto ainda desacelera,
    // mantém a animação de caminhada
    if (_moveu)
    {
        usar_animacao_walk();
    }
    else
    {
        usar_animacao_idle();
    }
};


estado_parado.finaliza = function()
{
};


// ==================================================
// ESTADO ANDANDO
// ==================================================

estado_andando = new estado();


estado_andando.inicia = function()
{
    usar_animacao_walk();
};


estado_andando.roda = function()
{
    if (global.controle_bloqueado)
    {
        troca_estado(
            estado_bloqueado
        );

        return;
    }


    var _dir =
        ler_input_horizontal();


    if (_dir == 0)
    {
        troca_estado(
            estado_parado
        );

        return;
    }


    hsp +=
        _dir
        * aceleracao;


    hsp =
        clamp(
            hsp,
            -vel_max,
            vel_max
        );


    direcao = _dir;
    image_xscale = direcao;


    var _moveu =
        mover_horizontal(hsp);


    // Se estiver pressionando contra uma parede,
    // não fica caminhando sem sair do lugar
    if (_moveu)
    {
        usar_animacao_walk();
    }
    else
    {
        usar_animacao_idle();
    }
};


estado_andando.finaliza = function()
{
};


// ==================================================
// ESTADO BLOQUEADO
// ==================================================

estado_bloqueado = new estado();


estado_bloqueado.inicia = function()
{
    hsp = 0;
    x_resto = 0;


    // Não interrompe uma martelada
    if (!animacao_martelo_ativa)
    {
        usar_animacao_idle();
    }
};


estado_bloqueado.roda = function()
{
    if (!global.controle_bloqueado)
    {
        troca_estado(
            estado_parado
        );
    }
};


estado_bloqueado.finaliza = function()
{
};

#endregion


#region Spawn entre rooms

if (
    variable_global_exists(
        "usar_spawn"
    )
    && global.usar_spawn
)
{
    x = global.spawn_x;
    y = global.spawn_y;

    global.usar_spawn = false;
}

#endregion


#region Inicialização

image_xscale = direcao;

usar_animacao_idle(true);
inicia_estado(estado_parado);

#endregion