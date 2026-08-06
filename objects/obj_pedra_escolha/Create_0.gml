event_inherited();


#region Configuração da interação

distancia_interacao = 40;
offset_indicador_y = 10;

#endregion


#region Configuração da pedra

chutada = false;
velocidade_chute = 3;

// Guarda temporariamente a opção
// enquanto o fade acontece
opcao_pedra_pendente = -1;

#endregion


#region Restaurar estado

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


// Ao escolher não fazer nada,
// a pedra permanece sem nova interação
pode_interagir =
    global.escolha_pedra == -1;

#endregion


#region Aplicar escolha

aplicar_escolha_pedra = function(_opcao)
{
    global.escolha_pedra = _opcao;
    pode_interagir = false;


    switch (_opcao)
    {
        // Chutar a pedra
        case 0:

            instance_destroy();

        break;


        // Retirar a pedra
        case 1:

            instance_destroy();

        break;


        // Não fazer nada
        case 2:

            // A pedra permanece no caminho

        break;


        // Proteção contra opção inválida
        default:

            global.escolha_pedra = -1;
            pode_interagir = true;

        break;
    }
};

#endregion


#region Interação

interagir = function()
{
    // Impede outra escolha enquanto uma
    // já estiver salva ou aguardando o fade
    if (
        global.escolha_pedra != -1
        || !pode_interagir
        || opcao_pedra_pendente != -1
    )
    {
        exit;
    }


    var _salvar_escolha = method(
        id,

        function(_opcao)
        {
            // Chutar e retirar utilizam fade
            if (_opcao == 0 || _opcao == 1)
            {
                opcao_pedra_pendente =
                    _opcao;


                var _aplicar_resultado = method(
                    id,

                    function()
                    {
                        var _opcao_salva =
                            opcao_pedra_pendente;


                        opcao_pedra_pendente =
                            -1;


                        aplicar_escolha_pedra(
                            _opcao_salva
                        );
                    }
                );


                var _fade_iniciado =
                    global.fade_instancia.iniciar(
                        _aplicar_resultado,
                        0.05,
                        45
                    );


                if (_fade_iniciado)
                {
                    pode_interagir = false;
                }
                else
                {
                    // Permite tentar novamente caso
                    // outro fade já esteja acontecendo
                    opcao_pedra_pendente = -1;
                    pode_interagir = true;
                }


                exit;
            }


            // Não fazer nada não altera o cenário
            aplicar_escolha_pedra(
                _opcao
            );
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

#endregion