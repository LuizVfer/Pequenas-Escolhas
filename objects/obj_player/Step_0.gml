#region Atualizar estado e animações

// A martelada possui prioridade sobre
// idle, walk e o estado bloqueado
var _martelando =
    atualizar_animacao_martelo();


if (!_martelando)
{
    roda_estado();
}

#endregion


#region Som dos passos

var _deslocamento_passos =
    abs(
        x - x_anterior_passos
    );


x_anterior_passos = x;


if (
    !global.controle_bloqueado
    && !animacao_martelo_ativa
    && _deslocamento_passos > 0.01
)
{
    distancia_passos_acumulada +=
        _deslocamento_passos;


    if (
        distancia_passos_acumulada
        >= distancia_entre_passos
    )
    {
        distancia_passos_acumulada = 0;


        var _pitch_passo =
            passo_alternado
            ? 1.06
            : 0.94;


        passo_alternado =
            !passo_alternado;


        audio_play_sound(
            snd_passos,
            0,
            false,
            0.1,
            0,
            _pitch_passo
        );
    }
}
else
{
    distancia_passos_acumulada = 0;
}

#endregion


#region Procurar interação

interagivel_atual = noone;
global.interacao_ativa = noone;


if (!global.controle_bloqueado)
{
    var _melhor_distancia =
        infinity;

    var _melhor_prioridade =
        -infinity;


    var _quantidade =
        instance_number(
            obj_par_interagivel
        );


    for (
        var _i = 0;
        _i < _quantidade;
        _i++
    )
    {
        var _alvo =
            instance_find(
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
            _alvo.x
            + _alvo.offset_interacao_x;


        var _ponto_y =
            _alvo.y
            + _alvo.offset_interacao_y;


        var _distancia =
            point_distance(
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
            _prioridade
                == _melhor_prioridade
            && _distancia
                < _melhor_distancia;


        if (
            _dentro_da_distancia
            && (
                _prioridade_melhor
                || _mesma_prioridade_mais_perto
            )
        )
        {
            _melhor_prioridade =
                _prioridade;

            _melhor_distancia =
                _distancia;

            interagivel_atual =
                _alvo;
        }
    }
}

#endregion


#region Executar interação

if (instance_exists(interagivel_atual))
{
    global.interacao_ativa =
        interagivel_atual;


    if (
        keyboard_check_pressed(
            ord("E")
        )
    )
    {
        var _alvo_final =
            interagivel_atual;


        var _som_interacao =
            audio_play_sound(
                snd_interacao,
                0,
                false
            );


        if (_som_interacao != -1)
        {
            audio_sound_gain(
                _som_interacao,
                0.40,
                0
            );


            audio_sound_pitch(
                _som_interacao,
                0.90
            );
        }


        with (_alvo_final)
        {
            interagir();
        }
    }
}

#endregion

#region Atualizar indicador de interação

var _delta_indicador =
    delta_time / 1000000;


var _mostrar_indicador =
    instance_exists(
        interagivel_atual
    )
    && !global.dialogo_ativo
    && !global.controle_bloqueado;


if (_mostrar_indicador)
{
    // Reinicia a entrada quando o alvo muda
    if (
        interagivel_atual
        != indicador_alvo_anterior
    )
    {
        indicador_alpha = 0;
        indicador_tempo = 0;
    }


    // Objetos grandes usam o ponto acessível
    // empregado no cálculo da interação
    if (
        interagivel_atual
            .indicador_usar_ponto_interacao
    )
    {
        indicador_x =
            round(
                interagivel_atual.x
                + interagivel_atual
                    .offset_interacao_x
            );


        indicador_y =
            round(
                interagivel_atual.y
                + interagivel_atual
                    .offset_interacao_y
                - interagivel_atual
                    .offset_indicador_y
            );
    }
    else
    {
        // NPCs e objetos pequenos continuam
        // mostrando o indicador sobre a cabeça
        indicador_x =
            round(
                interagivel_atual.x
            );


        indicador_y =
            round(
                interagivel_atual.bbox_top
                - interagivel_atual
                    .offset_indicador_y
            );
    }


    // Aproximadamente 0,17 segundo para aparecer
    indicador_alpha =
        min(
            1,
            indicador_alpha
                + 6
                * _delta_indicador
        );


    indicador_tempo +=
        _delta_indicador;
}
else
{
    // Aproximadamente 0,12 segundo para desaparecer
    indicador_alpha =
        max(
            0,
            indicador_alpha
                - 8
                * _delta_indicador
        );
}


if (_mostrar_indicador)
{
    indicador_alvo_anterior =
        interagivel_atual;
}
else
{
    indicador_alvo_anterior =
        noone;
}

#endregion