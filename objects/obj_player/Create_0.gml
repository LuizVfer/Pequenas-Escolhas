#region variaveis
// Movimento
vel_max = 2;
aceleracao = 0.25;
desaceleracao = 0.35;

hsp = 0;
direcao = 1;

// Guarda movimentos menores que 1 pixel
x_resto = 0;

// Objeto interagível mais próximo
interagivel_atual = noone;

// ==================================================
// SOM DOS PASSOS
// ==================================================

// Posição usada para descobrir quanto o player andou
x_anterior_passos = x;

// Distância acumulada desde o último passo
distancia_passos_acumulada = 0;

// Distância necessária para tocar outro passo
distancia_entre_passos = 40;

// Alterna o pitch entre os passos
passo_alternado = false;

#endregion

#region metodos

// Lê A/D e setas
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

mover_horizontal = function(_velocidade)
{
    // Acumula a parte decimal do movimento
    x_resto += _velocidade;

    // Converte o movimento acumulado em pixels inteiros
    var _movimento = floor(abs(x_resto)) * sign(x_resto);

    // Mantém apenas o resto decimal
    x_resto -= _movimento;

    var _passo = sign(_movimento);

    // Move um pixel por vez para não atravessar obstáculos
    repeat (abs(_movimento))
    {
        if (!place_meeting(x + _passo, y, obj_solid))
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

    // Impede o player de sair da room
    x = clamp(x, 16, room_width - 16);
};

#endregion

#region estados
// ==================================================
// ESTADO PARADO
// ==================================================

estado_parado = new estado();

estado_parado.inicia = function()
{
    image_speed = 0;
};

estado_parado.roda = function()
{
    
    if (global.controle_bloqueado)
    {
        troca_estado(estado_bloqueado);
    }
    else
    {
        var _dir = ler_input_horizontal();

        if (_dir != 0)
        {
            troca_estado(estado_andando);
        }
        else
        {
            // Desaceleração
            if (abs(hsp) <= desaceleracao)
            {
                hsp = 0;
            }
            else
            {
                hsp -= sign(hsp) * desaceleracao;
            }

            mover_horizontal(hsp)
        }
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
    
    image_speed = 0.15;

};

estado_andando.roda = function()
{
    if (global.controle_bloqueado)
    {
        troca_estado(estado_bloqueado);
    }
    else
    {
        var _dir = ler_input_horizontal();

        if (_dir == 0)
        {
            troca_estado(estado_parado);
        }
        else
        {
            // Aceleração
            hsp += _dir * aceleracao;
            hsp = clamp(hsp, -vel_max, vel_max);

            // Movimento
            mover_horizontal(hsp)

            // Direção da sprite
            direcao = _dir;
            image_xscale = direcao;
        }
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
    image_speed = 0;

};

estado_bloqueado.roda = function()
{

    if (!global.controle_bloqueado)
    {
        troca_estado(estado_parado);
    }

};

estado_bloqueado.finaliza = function()
{
};

#endregion

// Usa uma posição específica depois de trocar de room
if (
    variable_global_exists("usar_spawn")
    && global.usar_spawn
)
{
    x = global.spawn_x;
    y = global.spawn_y;

    global.usar_spawn = false;
}

// Estado inicial
inicia_estado(estado_parado);