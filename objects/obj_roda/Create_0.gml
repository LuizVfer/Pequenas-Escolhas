event_inherited();


#region Estados

ESTADO_PARADO = 0;
ESTADO_DIALOGO_RODA = 1;
ESTADO_MINIGAME_RODA = 2;
ESTADO_IMPULSO = 3;
ESTADO_ESPERA = 4;
ESTADO_DIALOGO_MARTELO = 5;
ESTADO_MINIGAME_MARTELO = 6;
ESTADO_FINALIZANDO = 7;

estado_puzzle_roda = ESTADO_PARADO;

#endregion


#region Interação

prioridade_interacao = 20;
distancia_interacao = 40;
offset_indicador_y = 12;

pode_interagir = global.roda_liberada;

sendo_empurrada = false;
reparo_iniciado = false;

image_index = 0;
image_speed = 0;

#endregion


#region Movimento da roda

quantidade_impulsos = 3;
impulso_atual = 0;

alvo_roda = noone;

x_inicio_sequencia = x;
x_destino_sequencia = x;

x_inicio_impulso = x;
x_fim_impulso = x;

duracao_impulso = 36;
contador_impulso = 0;

espera_proximo_impulso = 12;
contador_espera = 0;

distancia_player_roda = 32;
velocidade_animacao = 0.08;

#endregion


#region Minigame

minigame_ativo = false;

marcador_posicao = 0;
marcador_direcao = 1;
velocidade_marcador = 0.025;

zona_centro = 0.50;
zona_largura = 0.30;

bloqueio_entrada_minigame = 0;
feedback_erro = 0;

anim_minigame_roda = 0;

carregando_impulso = false;
velocidade_carga_roda = 0.018;

#endregion


#region Martelo

quantidade_marteladas = 3;
marteladas_corretas = 0;

velocidade_martelo_base = 0.030;
aumento_velocidade_martelo = 0.004;

largura_zona_martelo = 0.22;

#endregion


#region Funções auxiliares

encontrar_alvo_roda = function()
{
    var _alvo_encontrado = noone;
    var _menor_distancia = infinity;

    var _quantidade =
        instance_number(obj_alvo_roda);

    for (
        var _i = 0;
        _i < _quantidade;
        _i++
    )
    {
        var _alvo =
            instance_find(obj_alvo_roda, _i);

        if (!instance_exists(_alvo))
        {
            continue;
        }

        // A roda só avança para a direita
        if (_alvo.x <= x)
        {
            continue;
        }

        var _distancia =
            _alvo.x - x;

        if (_distancia < _menor_distancia)
        {
            _menor_distancia = _distancia;
            _alvo_encontrado = _alvo;
        }
    }

    return _alvo_encontrado;
};


calcular_destino_impulso = function(_impulso)
{
    var _progresso =
        clamp(
            _impulso / quantidade_impulsos,
            0,
            1
        );

    return lerp(
        x_inicio_sequencia,
        x_destino_sequencia,
        _progresso
    );
};


sortear_zona = function(_minimo, _maximo)
{
    zona_centro =
        random_range(_minimo, _maximo);
};


reiniciar_marcador = function(_bloqueio)
{
    marcador_posicao = 0;
    marcador_direcao = 1;

    bloqueio_entrada_minigame = _bloqueio;
    feedback_erro = 0;

    anim_minigame_roda = 0;
    carregando_impulso = false;
};


atualizar_marcador = function()
{
    marcador_posicao +=
        velocidade_marcador
        * marcador_direcao;

    if (marcador_posicao >= 1)
    {
        marcador_posicao = 1;
        marcador_direcao = -1;
    }
    else if (marcador_posicao <= 0)
    {
        marcador_posicao = 0;
        marcador_direcao = 1;
    }
};


marcador_acertou_zona = function()
{
    var _inicio =
        zona_centro
        - zona_largura * 0.5;

    var _fim =
        zona_centro
        + zona_largura * 0.5;

    return (
        marcador_posicao >= _inicio
        && marcador_posicao <= _fim
    );
};


posicionar_player_empurrando =
function(_player, _animar)
{
    _player.hsp = 0;
    _player.x =
        x - distancia_player_roda;


    // Só reinicia quando realmente
    // começa a animação de empurrar
    if (
        _player.sprite_index
        != spr_player_empurrando
    )
    {
        _player.sprite_index =
            spr_player_empurrando;

        _player.image_index = 0;
    }


    _player.image_xscale = 1;
    _player.direcao = 1;


    if (_animar)
    {
        // Usa a velocidade configurada
        // diretamente no Sprite Editor
        _player.image_speed = 1;
    }
    else
    {
        _player.image_index = 0;
        _player.image_speed = 0;
    }
};


posicionar_player_idle = function(
    _player
)
{
    _player.hsp = 0;


    // Não deixa o minigame substituir
    // a martelada por idle
    if (
        variable_instance_exists(
            _player,
            "animacao_martelo_ativa"
        )
        && _player.animacao_martelo_ativa
    )
    {
        return;
    }


    _player.sprite_index =
        spr_player_idle;

    _player.image_index = 0;
    _player.image_speed = 0;
};


parar_roda = function()
{
    image_index = 0;
    image_speed = 0;
};


tocar_som_erro = function()
{
    var _som = audio_play_sound(
        snd_opcao_mover,
        0,
        false
    );

    audio_sound_gain(
        _som,
        0.30,
        0
    );

    audio_sound_pitch(
        _som,
        0.70
    );
};

#endregion


#region Preparação dos minigames

preparar_minigame_roda = function()
{
    velocidade_marcador = 0.025;
    zona_largura = 0.30;

    reiniciar_marcador(12);
    sortear_zona(0.27, 0.73);

    minigame_ativo = true;
    estado_puzzle_roda =
        ESTADO_MINIGAME_RODA;
};


preparar_minigame_martelo = function()
{
    velocidade_marcador =
        velocidade_martelo_base
        + marteladas_corretas
        * aumento_velocidade_martelo;

    zona_largura =
        largura_zona_martelo;

    reiniciar_marcador(12);
    sortear_zona(0.24, 0.76);

    minigame_ativo = true;
    estado_puzzle_roda =
        ESTADO_MINIGAME_MARTELO;
};

#endregion


#region Finalização

concluir_reparo_carroca = function()
{
    if (reparo_iniciado)
    {
        exit;
    }

    reparo_iniciado = true;
    minigame_ativo = false;

    estado_puzzle_roda =
        ESTADO_FINALIZANDO;

    global.controle_bloqueado = true;


    var _finalizar_reparo = method(
        id,

        function()
        {
            global.roda_usada = true;
            global.roda_liberada = false;


            with (obj_carroca_quebrada)
            {
                consertada = true;

                sprite_index =
                    spr_carroca_consertada;

                image_index = 0;
                image_speed = 0;
            }


            with (obj_solid)
            {
                if (bloqueio_carroca)
                {
                    instance_destroy();
                }
            }
            
            // Impacto do reparo da carroça
            with (obj_camera)
            {
                tremer(2, 12);
            }


            instance_destroy();
        }
    );


    global.fade_instancia.iniciar(
        _finalizar_reparo,
        0.05,
        45
    );
};

#endregion


#region Interação

interagir = function()
{
    // A roda só pode ser usada depois da conversa
    // com o ferreiro e antes do reparo
    if (
        !global.roda_liberada
        || global.roda_usada
        || estado_puzzle_roda != ESTADO_PARADO
    )
    {
        exit;
    }

    var _player = instance_find(obj_player, 0);

    if (!instance_exists(_player))
    {
        exit;
    }

    // Procura o ponto onde a roda deverá parar
    alvo_roda = encontrar_alvo_roda();

    if (!instance_exists(alvo_roda))
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Mensageiro",
                texto: "Não vejo como levar esta roda até a carroça daqui."
            }
        ]);

        exit;
    }

    // Primeiro confirma que o diálogo realmente abriu
    var _dialogo_aberto = global.dialogo_instancia.abrir(
    [
        {
            nome: "Mensageiro",
            texto: "Certo. Vou empurrá-la até a carroça."
        }
    ]);

    if (!_dialogo_aberto)
    {
        exit;
    }

    // Prepara a sequência do puzzle
    x_inicio_sequencia = x;
    x_destino_sequencia = alvo_roda.x;

    impulso_atual = 0;
    contador_impulso = 0;
    contador_espera = 0;

    sendo_empurrada = true;
    pode_interagir = false;

    estado_puzzle_roda = ESTADO_DIALOGO_RODA;
};

#endregion


// Não deixa a roda reaparecer depois do reparo
if (global.roda_usada)
{
    instance_destroy();
    exit;
}