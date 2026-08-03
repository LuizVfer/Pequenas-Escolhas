// Inherit the parent event
event_inherited();

chutada = false;
velocidade_chute = 3;

// Se a pedra já foi chutada ou retirada
// em uma visita anterior à room, ela não reaparece
if (
    global.escolha_pedra == 0
    || global.escolha_pedra == 1
)
{
    instance_destroy();
    exit;
}

distancia_interacao = 40;
offset_indicador_y = 10;

// Caso a escolha já tenha sido feita
pode_interagir = global.escolha_pedra == -1;


interagir = function()
{
    // Segurança para não escolher novamente
    if (global.escolha_pedra != -1)
    {
        exit;
    }

    // Função vinculada especificamente a esta pedra
    var _resultado_pedra = method(
        id,

        function(_opcao)
        {
            global.escolha_pedra = _opcao;
            pode_interagir = false;

            show_debug_message(
                "Escolha da pedra salva: "
                + string(global.escolha_pedra)
            );


            switch (_opcao)
            {
                // Chutar a pedra
                case 0:
                    chutada = true;
                    pode_interagir = false;
                break;
                
                // Retirar a pedra
                case 1:
                    instance_destroy();
                break;
            
                // Não fazer nada
                case 2:
                    // A pedra permanece no lugar
                break;
            }
        }
    );


    global.dialogo_instancia.abrir_escolha(
        "Mensageiro",

        "Uma pequena pedra está no meio do caminho. O que fazer?",

        [
            "Chutar a pedra",
            "Retirar a pedra",
            "Não fazer nada"
        ],

        _resultado_pedra
    );
};