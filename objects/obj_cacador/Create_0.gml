event_inherited();


#region Estados

CACADOR_PARADO = 0;
CACADOR_DIALOGO = 1;
CACADOR_PUZZLE = 2;
CACADOR_CONCLUIDO = 3;
CACADOR_FADE = 4;
CACADOR_DIALOGO_FINAL = 5;

estado_cacador = CACADOR_PARADO;

#endregion


#region Interação

distancia_interacao = 48;
offset_indicador_y = 12;
prioridade_interacao = 10;

cacador_examinado = false;
transicao_iniciada = false;

pode_interagir =
    !global.caminho_cacador_liberado;

#endregion


#region Puzzle das cordas

quantidade_pecas = 4;
peca_selecionada = 0;

// Posições atuais das peças
rotacoes_corda = [1, 2, 3, 1];

// Posição correta de cada peça
solucao_corda = [0, 0, 0, 0];

contador_conclusao = 0;
espera_conclusao = 24;

anim_puzzle = 0;

#endregion


#region Funções do puzzle

girar_peca = function(_indice)
{
    rotacoes_corda[_indice] =
        (rotacoes_corda[_indice] + 1) mod 4;
};


puzzle_corda_resolvido = function()
{
    for (
        var _i = 0;
        _i < quantidade_pecas;
        _i++
    )
    {
        if (
            rotacoes_corda[_i]
            != solucao_corda[_i]
        )
        {
            return false;
        }
    }

    return true;
};


abrir_puzzle_corda = function()
{
    estado_cacador = CACADOR_PUZZLE;

    global.controle_bloqueado = true;
    pode_interagir = false;
};


fechar_puzzle_corda = function()
{
    // Evita que o mesmo Esc abra a pausa
    global.bloquear_pause_frames = 2;
    keyboard_clear(vk_escape);

    estado_cacador = CACADOR_PARADO;

    global.controle_bloqueado = false;

    pode_interagir =
        !global.caminho_cacador_liberado;
};

#endregion


#region Interação principal
bloqueio_interacao = 0;

interagir = function()
{
    if (
        bloqueio_interacao > 0
        || estado_cacador != CACADOR_PARADO
    )
    {
        exit;
    }


    // Conversa depois que o caminho foi liberado
    if (global.caminho_cacador_liberado)
    {
        estado_cacador =
            CACADOR_DIALOGO_FINAL;

        pode_interagir = false;


        global.dialogo_instancia.abrir(
        [
            {
                nome: "Caçador",
                texto:
                    "A estrada está livre. Siga antes que escureça."
            }
        ]);

        exit;
    }


    if (transicao_iniciada)
    {
        exit;
    }


    pode_interagir = false;


    // Primeira conversa
    if (!cacador_examinado)
    {
        cacador_examinado = true;

        estado_cacador =
            CACADOR_DIALOGO;


        global.dialogo_instancia.abrir(
        [
            {
                nome: "Caçador",
                texto:
                    "Espere. Minhas cordas ficaram presas no caminho."
            },
            {
                nome: "Caçador",
                texto:
                    "Se eu puxar na ordem errada, os nós apertam ainda mais."
            },
            {
                nome: "Caçador",
                texto:
                    "Ajude-me a alinhar as cordas."
            }
        ]);

        exit;
    }


    abrir_puzzle_corda();
};

#endregion


if (global.caminho_cacador_liberado)
{
    pode_interagir = true;
}