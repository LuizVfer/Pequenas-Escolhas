// ==================================================
// SEGURANÇA
// ==================================================

if (global.roda_usada)
{
    instance_destroy();
    exit;
}


if (reparo_iniciado)
{
    image_speed = 0;
    image_index = 0;
    exit;
}


// ==================================================
// RODA NÃO ATIVADA PARA EMPURRAR
// ==================================================

if (!sendo_empurrada)
{
    pode_interagir =
        global.roda_liberada;

    image_speed = 0;
    image_index = 0;

    exit;
}


pode_interagir = false;


// Não move durante diálogo ou fade
if (global.controle_bloqueado)
{
    image_speed = 0;
    image_index = 0;
    exit;
}


var _player = instance_find(obj_player, 0);

if (_player == noone)
{
    sendo_empurrada = false;

    image_speed = 0;
    image_index = 0;

    exit;
}


// ==================================================
// SOLTAR A RODA
// ==================================================

var _distancia_player =
    abs(_player.x - x);

if (_distancia_player > distancia_soltar)
{
    sendo_empurrada = false;
    pode_interagir = true;

    image_speed = 0;
    image_index = 0;

    exit;
}


// ==================================================
// VERIFICAR EMPURRÃO E ENCAIXE VISUAL
// ==================================================

var _movimento = 0;

// Posição exata em que a roda deve ficar encostada
var _x_encoste =
    _player.x
    + lado_empurrao * distancia_encoste_visual;


// Player está no lado correto da roda
var _lado_correto =
(
    lado_empurrao > 0
    && _player.x < x
)
||
(
    lado_empurrao < 0
    && _player.x > x
);


// Player está andando na direção do empurrão
var _andando_para_roda =
(
    lado_empurrao > 0
    && _player.hsp > 0
)
||
(
    lado_empurrao < 0
    && _player.hsp < 0
);


// Verifica se o ponto de encoste alcançou a roda
var _alcancou_roda = false;

if (lado_empurrao > 0)
{
    _alcancou_roda =
        _x_encoste >= x
        && _x_encoste - x
            <= abs(_player.hsp) + tolerancia_encoste;
}
else
{
    _alcancou_roda =
        _x_encoste <= x
        && x - _x_encoste
            <= abs(_player.hsp) + tolerancia_encoste;
}


// ==================================================
// MOVIMENTAR
// ==================================================

if (
    _lado_correto
    && _andando_para_roda
    && _alcancou_roda
)
{
    var _novo_x = _x_encoste;

    if (!place_meeting(_novo_x, y, obj_solid))
    {
        _movimento = _novo_x - x;
        x = _novo_x;
    }
}


// ==================================================
// ANIMAÇÃO
// ==================================================

if (_movimento != 0)
{
    // Positivo girando para a direita,
    // negativo girando para a esquerda
    image_speed =
        velocidade_animacao
        * sign(_movimento);
}
else
{
    image_speed = 0;
    image_index = 0;
}


// ==================================================
// CHEGOU AO ALVO DA CARROÇA
// ==================================================

if (place_meeting(x, y, obj_alvo_roda))
{
    reparo_iniciado = true;
    sendo_empurrada = false;

    image_speed = 0;
    image_index = 0;


        var _finalizar_reparo = method(
        id,
    
        function()
        {
            global.roda_usada = true;
            global.roda_liberada = false;
            
            if(instance_exists(obj_carroca_quebrada))
            {
                with (obj_carroca_quebrada)
                {
                    consertada = true;
                    sprite_index = spr_carroca_consertada;
                    image_index = 0;
                    image_speed = 0;
                }
            }
            
            // Remove somente o bloqueio da carroça
            if(instance_exists(obj_solid))
            {
                with (obj_solid)
                {
                    if (bloqueio_carroca)
                    {
                        instance_destroy();
                    }
                }
            }
    
            audio_play_sound(
                snd_martelo,
                1,
                false
            );
    
            instance_destroy();
        }
    );
    
    global.fade_instancia.iniciar(
        _finalizar_reparo,
        0.05,
        45
    );
}