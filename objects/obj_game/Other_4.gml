// ==================================================
// MÚSICA DE CADA ROOM
// ==================================================

switch (room)
{
    // Menu e introdução compartilham a mesma música
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


    // Destino e final compartilham a mesma música
    case rm_destino:
    case rm_final_livro:
        agendar_musica(
            snd_mus_destino_final,
            atraso_musica
        );
    break;


    default:
        alarm[0] = -1;
        musica_pendente = noone;
        parar_musica();
    break;
}