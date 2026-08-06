#region Iniciar música pendente

if (musica_pendente == noone)
{
    exit;
}


var _musica =
    musica_pendente;

musica_pendente = noone;


tocar_musica(
    _musica
);

#endregion