event_inherited();


#region Estados

MECANISMO_PARADO = 0;
MECANISMO_DIALOGO = 1;
MECANISMO_PUZZLE = 2;
MECANISMO_CONCLUIDO = 3;
MECANISMO_FADE = 4;

estado_mecanismo = MECANISMO_PARADO;

#endregion


#region Configuração da interação

distancia_interacao = 44;
offset_indicador_y = 12;
prioridade_interacao = 10;

mecanismo_examinado = false;
transicao_iniciada = false;

pode_interagir =
    global.ponte_descoberta
    && !global.ponte_abaixada;

#endregion


#region Configuração do puzzle

// Posições das engrenagens:
// 0 = cima
// 1 = direita
// 2 = baixo
posicoes_rodas = [1, 2, 2];

quantidade_rodas = 3;
roda_selecionada = 0;

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

    // Cada engrenagem também movimenta a seguinte
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
    estado_mecanismo = MECANISMO_PUZZLE;

    global.controle_bloqueado = true;
    pode_interagir = false;
};


fechar_puzzle = function()
{
    // Impede que o mesmo Esc abra o menu de pausa
    global.bloquear_pause_frames = 2;
    keyboard_clear(vk_escape);

    estado_mecanismo = MECANISMO_PARADO;

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
        || estado_mecanismo != MECANISMO_PARADO
        || transicao_iniciada
    )
    {
        exit;
    }


    // Primeira análise do mecanismo
    if (!mecanismo_examinado)
    {
        var _dialogo_aberto =
            global.dialogo_instancia.abrir(
            [
                {
                    nome: "Mensageiro",
                    texto: "Este mecanismo possui três rodas ligadas entre si."
                },

                {
                    nome: "Mensageiro",
                    texto: "Quando uma delas gira, a roda seguinte também se move."
                },

                {
                    nome: "Mensageiro",
                    texto: "Se as três marcas apontarem para cima, talvez o mecanismo baixe a ponte."
                }
            ]);


        // Só registra a análise se o diálogo abrir
        if (_dialogo_aberto)
        {
            mecanismo_examinado = true;
            estado_mecanismo = MECANISMO_DIALOGO;
            pode_interagir = false;
        }

        exit;
    }


    // Nas próximas interações, abre o puzzle
    abrir_puzzle();
};

#endregion