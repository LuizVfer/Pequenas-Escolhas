// Executa o estado atual do player
roda_estado();


// Limpa a interação anterior
interagivel_atual = noone;
global.interacao_ativa = noone;

if (!global.controle_bloqueado)
{
    var _melhor_distancia = 1000000;
    var _melhor_prioridade = -1000000;

    var _quantidade =
        instance_number(obj_par_interagivel);

    for (var _i = 0; _i < _quantidade; _i++)
    {
        var _alvo = instance_find(
            obj_par_interagivel,
            _i
        );

        if (!instance_exists(_alvo))
        {
            continue;
        }

        if (!_alvo.pode_interagir)
        {
            continue;
        }

        var _ponto_x =
            _alvo.x + _alvo.offset_interacao_x;
        
        var _ponto_y =
            _alvo.y + _alvo.offset_interacao_y;
        
        var _distancia = point_distance(
            x,
            y,
            _ponto_x,
            _ponto_y
        );

        var _prioridade =
            _alvo.prioridade_interacao;

        var _dentro_da_distancia =
            _distancia
            <= _alvo.distancia_interacao;

        var _prioridade_melhor =
            _prioridade
            > _melhor_prioridade;

        var _mesma_prioridade_mais_perto =
            _prioridade == _melhor_prioridade
            && _distancia < _melhor_distancia;


        if (
            _dentro_da_distancia
            && (
                _prioridade_melhor
                || _mesma_prioridade_mais_perto
            )
        )
        {
            _melhor_prioridade = _prioridade;
            _melhor_distancia = _distancia;
            interagivel_atual = _alvo;
        }
    }


    if (instance_exists(interagivel_atual))
    {
        global.interacao_ativa =
            interagivel_atual;

        if (keyboard_check_pressed(ord("E")))
        {
            var _alvo_final =
                interagivel_atual;

            with (_alvo_final)
            {
                interagir();
            }
        }
    }
}