image_speed = 0;

// Restaura o resultado ao entrar novamente na room
switch (global.escolha_brinquedo)
{
    // Ajudou
    case 0:
        sprite_index = spr_crianca_brinquedo;
    break;

    // Derrubou com pedra e quebrou
    case 1:
        sprite_index = spr_crianca_brinquedo_quebrado;
    break;

    // Ignorou ou ainda não escolheu
    default:
        sprite_index = spr_crianca_alcancando;
    break;
}

image_index = 0;