event_inherited();


#region Estados

MECANISMO_PARADO = 0;
MECANISMO_DIALOGO = 1;
MECANISMO_PUZZLE = 2;
MECANISMO_CONCLUIDO = 3;
MECANISMO_FADE = 4;

estado_mecanismo = MECANISMO_PARADO;

#endregion


#region Interação

distancia_interacao = 44;
offset_indicador_y = 12;
prioridade_interacao = 10;

mecanismo_examinado = false;
transicao_iniciada = false;

pode_interagir =
    global.ponte_descoberta
    && !global.ponte_abaixada;

#endregion


#region Puzzle

// 0 = cima
// 1 = direita
// 2 = baixo
posicoes_rodas = [1, 2, 2];

roda_selecionada = 0;

quantidade_rodas = 3;

contador_conclusao = 0;
espera_conclusao = 18;

anim_puzzle = 0;

#endregion


#region Áudio

som_ponte = snd_ponte_abaixando;

#endregion


#region Funções do puzzle

girar_posicao = function(_indice)
{
    posicoes_rodas[_indice] =
        (posicoes_rodas[_indice] + 1) mod 3;
};


girar_roda = function(_indice)
{
    girar_posicao(_indice);

    // Cada roda movimenta a próxima
    if (_indice < quantidade_rodas - 1)
    {
        girar_posicao(_indice + 1);
    }
};


puzzle_resolvido = function()
{
    for (
        var _i = 0;
        _i < quantidade_rodas;
        _i++
    )
    {
        if (posicoes_rodas[_i] != 0)
        {
            return false;
        }
    }

    return true;
};


abrir_puzzle = function()
{
    estado_mecanismo =
        MECANISMO_PUZZLE;

    global.controle_bloqueado = true;
    pode_interagir = false;
};


fechar_puzzle = function()
{
    // Impede que o mesmo Esc abra a pausa
    global.bloquear_pause_frames = 2;
    keyboard_clear(vk_escape);

    estado_mecanismo =
        MECANISMO_PARADO;

    global.controle_bloqueado = false;

    pode_interagir =
        global.ponte_descoberta
        && !global.ponte_abaixada;
};

#endregion


#region Interação principal

interagir = function()
{
    if (
        !global.ponte_descoberta
        || global.ponte_abaixada
        || estado_mecanismo
            != MECANISMO_PARADO
        || transicao_iniciada
    )
    {
        exit;
    }


    pode_interagir = false;


    // Primeira vez examinando o mecanismo
    if (!mecanismo_examinado)
    {
        mecanismo_examinado = true;

        estado_mecanismo =
            MECANISMO_DIALOGO;


        global.dialogo_instancia.abrir(
        [
            {
                nome: "Mensageiro",
                texto:
                    "Três rodas controlam o mecanismo."
            },
            {
                nome: "Mensageiro",
                texto:
                    "Quando uma gira, a próxima também se move."
            },
            {
                nome: "Mensageiro",
                texto:
                    "Preciso alinhar as três marcas."
            }
        ]);

        exit;
    }


    // Nas próximas interações abre diretamente
    abrir_puzzle();
};

#endregion