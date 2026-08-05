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

// ==================================================
// NOVO SISTEMA DE IMPULSOS
// ==================================================

// Quantidade de acertos necessários para levar
// a roda até a carroça
quantidade_impulsos = 3;

// Quantos impulsos já foram concluídos
impulso_atual = 0;

// Referência ao alvo encontrado automaticamente
alvo_roda = noone;

// Posições usadas para dividir o percurso
x_inicio_sequencia = x;
x_destino_sequencia = x;

// Movimento de cada impulso
x_inicio_impulso = x;
x_fim_impulso = x;

duracao_impulso = 36;
contador_impulso = 0;

// Espera antes do próximo minigame
espera_proximo_impulso = 12;
contador_espera = 0;

// O jogador sempre ficará à esquerda da roda
distancia_player_roda = 32;

anim_minigame_roda = 0;


// ==================================================
// ENCONTRAR O ALVO AUTOMATICAMENTE
// ==================================================

encontrar_alvo_roda = function()
{
    var _melhor_alvo = noone;
    var _melhor_distancia = 1000000;

    var _quantidade =
        instance_number(obj_alvo_roda);

    for (
        var _i = 0;
        _i < _quantidade;
        _i++
    )
    {
        var _alvo =
            instance_find(
                obj_alvo_roda,
                _i
            );

        if (!instance_exists(_alvo))
        {
            continue;
        }

        // A roda só pode ser empurrada
        // para a direita
        if (_alvo.x <= x)
        {
            continue;
        }

        var _distancia =
            _alvo.x - x;

        if (_distancia < _melhor_distancia)
        {
            _melhor_distancia = _distancia;
            _melhor_alvo = _alvo;
        }
    }

    return _melhor_alvo;
};


// ==================================================
// CALCULAR A POSIÇÃO DE CADA IMPULSO
// ==================================================

calcular_destino_impulso = function(_numero_impulso)
{
    var _progresso =
        clamp(
            _numero_impulso
                / quantidade_impulsos,
            0,
            1
        );

    return lerp(
        x_inicio_sequencia,
        x_destino_sequencia,
        _progresso
    );
};

// ==================================================
// ESTADOS DO NOVO PUZZLE
// ==================================================

// 0 = parado
// 1 = aguardando o diálogo terminar
// 2 = minigame ativo
// 3 = executando impulso
// 4 = espera entre impulsos
// 5 = roda posicionada na carroça
estado_puzzle_roda = 0;


// ==================================================
// MINIGAME DE PRECISÃO
// ==================================================

minigame_ativo = false;

// Posição normalizada: 0 até 1
marcador_posicao = 0;
marcador_direcao = 1;

velocidade_marcador = 0.025;

// 30% da barra será considerada área correta
zona_largura = 0.30;
zona_centro = 0.50;

// Evita que o mesmo E seja registrado duas vezes
bloqueio_entrada_minigame = 0;

// Feedback visual ao errar
feedback_erro = 0;


// ==================================================
// SORTEAR A ZONA CORRETA
// ==================================================

sortear_zona_minigame = function()
{
    zona_centro = random_range(
        0.27,
        0.73
    );
};


// ==================================================
// PREPARAR NOVA TENTATIVA
// ==================================================

preparar_minigame_roda = function()
{
    marcador_posicao = 0;
    marcador_direcao = 1;

    bloqueio_entrada_minigame = 12;
    feedback_erro = 0;
    
    anim_minigame_roda = 0;

    sortear_zona_minigame();

    minigame_ativo = true;
    estado_puzzle_roda = 2;
};

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


    // A roda será empurrada somente para a direita
    lado_empurrao = 1;
    
    
    // Procura automaticamente o alvo mais próximo
    // que esteja à direita da roda
    alvo_roda = encontrar_alvo_roda();
    
    if (!instance_exists(alvo_roda))
    {
        global.dialogo_instancia.abrir(
        [
            {
                nome: "Mensageiro",
                texto: "Não parece haver lugar para levar esta roda."
            }
        ]);
    
        exit;
    }
    
    
    // Guarda o percurso completo
    x_inicio_sequencia = x;
    x_destino_sequencia = alvo_roda.x;
    
    impulso_atual = 0;
    contador_impulso = 0;
    contador_espera = 0;
    
    // Depois do diálogo, começará o minigame
    estado_puzzle_roda = 1;


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