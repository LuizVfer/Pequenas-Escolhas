event_inherited();
prioridade_interacao = 20;

distancia_interacao = 40;
offset_indicador_y = 12;

// Estado da roda
sendo_empurrada = false;
lado_empurrao = 1;

// Player 32 px + roda 32 px:
// 16 px do player + 16 px da roda
distancia_encoste_visual = 32;

// Pequena tolerância para não falhar por subpixel
tolerancia_encoste = 3;

// Distância de contato (32) + 16 px de tolerância.
// Permite aproximar-se da roda sem cancelar o empurrão.
distancia_soltar = 48;

// Velocidade da animação
velocidade_animacao = 0.25;

// Começa parada no frame 0
image_speed = 0;
image_index = 0;

reparo_iniciado = false;

image_speed = 0;


// Se já foi usada, não deve reaparecer
if (global.roda_usada)
{
    instance_destroy();
    exit;
}


pode_interagir = global.roda_liberada;


interagir = function()
{
    if (
        !global.roda_liberada
        || global.roda_usada
        || sendo_empurrada
    )
    {
        exit;
    }


    var _player = instance_find(obj_player, 0);

    if (_player == noone)
    {
        exit;
    }


    // Descobre de qual lado o player está
    lado_empurrao = sign(x - _player.x);

    if (lado_empurrao == 0)
    {
        lado_empurrao = 1;
    }


    sendo_empurrada = true;
    pode_interagir = false;


    global.dialogo_instancia.abrir(
    [
        {
            nome: "Mensageiro",
            texto: "Vou empurrá-la até a carroça."
        }
    ]);
};