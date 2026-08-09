#region Poeira do jogador

var _player =
    instance_find(
        obj_player,
        0
    );


if (_player == noone)
{
    acumulador_distancia = 0;
    exit;
}


// Movimento real ocorrido neste frame
var _movimento_x =
    _player.x
    - _player.xprevious;


var _distancia_movida =
    abs(_movimento_x);


var _player_andando =
    poeira_ativa
    && !global.controle_bloqueado
    && _distancia_movida > 0.01
    && _distancia_movida < 12;


if (_player_andando)
{
    acumulador_distancia +=
        _distancia_movida;


    while (
        acumulador_distancia
        >= poeira_distancia
    )
    {
        criar_poeira_passos(
            _player,
            sign(_movimento_x)
        );


        acumulador_distancia -=
            poeira_distancia;
    }
}
else
{
    // Reinicia quando o jogador para
    acumulador_distancia = 0;
}

#endregion