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


#region Configuração da interação

offset_indicador_y = 12;
prioridade_interacao = 10;

cacador_examinado = false;
transicao_iniciada = false;
bloqueio_interacao = 0;

pode_interagir =
    !global.caminho_cacador_liberado;

#endregion


#region Configuração do puzzle

quantidade_pecas = 4;
peca_selecionada = 0;

// Orientações:
// 0 = horizontal
// 1 = vertical
rotacoes_corda = [1, 0, 1, 1];

// Todas devem ficar na horizontal
solucao_corda = [0, 0, 0, 0];

contador_conclusao = 0;
espera_conclusao = 24;

anim_puzzle = 0;

#endregion


#region Funções do puzzle

girar_peca = function(_indice)
{
    rotacoes_corda[_indice] =
        (rotacoes_corda[_indice] + 1) mod 2;
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
    // Impede que o mesmo Esc abra o menu
    global.bloquear_pause_frames = 2;
    keyboard_clear(vk_escape);

    estado_cacador = CACADOR_PARADO;

    global.controle_bloqueado = false;

    pode_interagir =
        !global.caminho_cacador_liberado;
};

#endregion


#region Interação principal

interagir = function()
{
    if (
        bloqueio_interacao > 0
        || estado_cacador != CACADOR_PARADO
        || transicao_iniciada
    )
    {
        exit;
    }


    // Conversa depois do puzzle
    if (global.caminho_cacador_liberado)
    {
        var _dialogo_final_aberto =
            global.dialogo_instancia.abrir(
            [
                {
                    nome: "Caçador",
                    texto: "Pronto, a passagem está livre. Siga enquanto ainda há luz."
                }
            ]);

        if (_dialogo_final_aberto)
        {
            estado_cacador =
                CACADOR_DIALOGO_FINAL;

            pode_interagir = false;
        }

        exit;
    }


    // Primeira conversa
    if (!cacador_examinado)
    {
        var _dialogo_inicial_aberto =
            global.dialogo_instancia.abrir(
            [
                {
                    nome: "Caçador",
                    texto: "Espere. Minhas cordas se enroscaram e estão bloqueando a passagem."
                },

                {
                    nome: "Caçador",
                    texto: "Se eu puxá-las assim, os nós ficarão ainda mais apertados."
                },

                {
                    nome: "Caçador",
                    texto: "Ajude-me a alinhar os trechos para que eu possa soltá-las."
                },

                {
                    nome: "Mensageiro",
                    texto: "Certo. Mostre-me por onde começar."
                }
            ]);

        if (_dialogo_inicial_aberto)
        {
            cacador_examinado = true;
            estado_cacador = CACADOR_DIALOGO;
            pode_interagir = false;
        }

        exit;
    }


    // Reabre o puzzle caso o jogador tenha saído
    abrir_puzzle_corda();
};

#endregion