#region Música da room

switch (room)
{
    // Menu e introdução compartilham
    // a mesma música
    case rm_menu:
    case rm_intro:

        agendar_musica(
            snd_mus_titulo_intro,
            atraso_musica
        );

    break;


    case rm_cidade:

        agendar_musica(
            snd_mus_cidade,
            atraso_musica
        );

    break;


    case rm_floresta:

        agendar_musica(
            snd_mus_floresta,
            atraso_musica
        );

    break;


    case rm_vila:

        agendar_musica(
            snd_mus_vila,
            atraso_musica
        );

    break;


    // Destino e livro final compartilham
    // a mesma música
    case rm_destino:
    case rm_final_livro:

        agendar_musica(
            snd_mus_destino_final,
            atraso_musica
        );

    break;


    // Rooms sem música configurada
    default:

        parar_musica();

    break;
}

#endregion


#region Menu de pausa

var _room_permite_pausa =
    room == rm_cidade
    || room == rm_floresta
    || room == rm_vila
    || room == rm_destino;


if (
    _room_permite_pausa
    && !instance_exists(obj_pausa)
)
{
    instance_create_layer(
        0,
        0,
        "L11_Controllers",
        obj_pausa
    );
}

#endregion