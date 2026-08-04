if (musica_pendente != noone)
{
    var _musica = musica_pendente;

    musica_pendente = noone;

    tocar_musica(_musica);
}