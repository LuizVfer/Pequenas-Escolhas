event_inherited();

// Configuração da interação
distancia_interacao = 40;
offset_indicador_y = 10;

// Configuração do chute
chutada = false;
velocidade_chute = 3;

// A pedra desaparece caso já tenha sido
// chutada ou retirada anteriormente
if (
    global.escolha_pedra == 0
    || global.escolha_pedra == 1
)
{
    instance_destroy();
    exit;
}

// A pedra continua visível ao escolher não fazer nada,
// mas não poderá ser examinada novamente
pode_interagir = (global.escolha_pedra == -1);


// ==================================================
// INTERAÇÃO
// ==================================================

interagir = function()
{
    // Impede que uma nova escolha seja realizada
    if (global.escolha_pedra != -1)
    {
        exit;
    }

    var _salvar_escolha = method(
        id,

        function(_opcao)
        {
            global.escolha_pedra = _opcao;
            pode_interagir = false;

            switch (_opcao)
            {
                // Chutar a pedra
                case 0:
                    chutada = true;
                break;

                // Retirar a pedra
                case 1:
                    instance_destroy();
                break;

                // Não fazer nada
                case 2:
                    // A pedra permanece no caminho
                break;
            }
        }
    );

    global.dialogo_instancia.abrir_escolha(
        "Mensageiro",

        "Uma pequena pedra repousa no meio do caminho. O que fazer?",

        [
            "Chutar a pedra",
            "Retirar a pedra",
            "Não fazer nada"
        ],

        _salvar_escolha
    );
};