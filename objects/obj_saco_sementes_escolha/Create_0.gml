event_inherited();


#region Configuração da interação

distancia_interacao = 44;
offset_indicador_y = 12;
prioridade_interacao = 10;

opcao_pendente = -1;
transicao_iniciada = false;

#endregion


#region Restaurar escolha salva

image_index = 0;
image_speed = 0;


if (global.escolha_sementes != -1)
{
    pode_interagir = false;


    switch (global.escolha_sementes)
    {
        // Amarrar o saco
        case 0:
            sprite_index =
                spr_saco_sementes_amarrado;
        break;


        // Deixar como está
        case 1:
            sprite_index =
                spr_saco_sementes_rasgado;
        break;


        // Abrir mais o rasgo
        case 2:
            sprite_index =
                spr_saco_sementes_aberto;
        break;
    }
}
else
{
    sprite_index =
        spr_saco_sementes_rasgado;

    pode_interagir = true;
}

#endregion


#region Aplicar escolha

aplicar_escolha_sementes = function(_opcao)
{
    var _mensagem = "";


    switch (_opcao)
    {
        // ==================================================
        // AMARRAR O SACO
        // ==================================================

        case 0:
            _mensagem =
                "Você apertou a corda e fechou o rasgo. O saco está bem fechado.";
        break;


        // ==================================================
        // DEIXAR COMO ESTÁ
        // ==================================================

        case 1:
            _mensagem =
                "Você decidiu não mexer no saco. Algumas sementes continuam caindo.";
        break;


        // ==================================================
        // ABRIR MAIS O RASGO
        // ==================================================

        case 2:
            _mensagem =
                "Você puxou o tecido e aumentou o rasgo. Mais sementes se espalharam pelo caminho.";
        break;


        default:
            return false;
    }


    var _dialogo_aberto =
        global.dialogo_instancia.abrir(
        [
            {
                nome: "",
                texto: _mensagem
            }
        ]);


    // Não registra nem altera o saco caso
    // o diálogo de resultado não possa abrir
    if (!_dialogo_aberto)
    {
        return false;
    }


    global.escolha_sementes = _opcao;
    pode_interagir = false;


    switch (_opcao)
    {
        case 0:
            sprite_index =
                spr_saco_sementes_amarrado;
        break;


        case 1:
            sprite_index =
                spr_saco_sementes_rasgado;
        break;


        case 2:
            sprite_index =
                spr_saco_sementes_aberto;
        break;
    }


    image_index = 0;
    image_speed = 0;


    show_debug_message(
        "Escolha das sementes salva: "
        + string(global.escolha_sementes)
    );


    return true;
};

#endregion


#region Interação

interagir = function()
{
    if (
        global.escolha_sementes != -1
        || transicao_iniciada
        || !pode_interagir
    )
    {
        exit;
    }


    var _salvar_escolha = method(
        id,

        function(_opcao)
        {
            // ==============================================
            // AMARRAR OU ABRIR MAIS
            // ==============================================

            if (
                _opcao == 0
                || _opcao == 2
            )
            {
                opcao_pendente = _opcao;


                var _aplicar_escolha = method(
                    id,

                    function()
                    {
                        var _escolha_aplicada =
                            aplicar_escolha_sementes(
                                opcao_pendente
                            );


                        opcao_pendente = -1;
                        transicao_iniciada = false;


                        // Permite tentar novamente caso
                        // o resultado não consiga ser aplicado
                        if (!_escolha_aplicada)
                        {
                            pode_interagir = true;
                        }
                    }
                );


                var _fade_iniciado =
                    global.fade_instancia.iniciar(
                        _aplicar_escolha,
                        0.05,
                        45
                    );


                // Só bloqueia e registra a transição
                // quando o fade realmente começar
                if (_fade_iniciado)
                {
                    transicao_iniciada = true;
                    pode_interagir = false;

                    // Impede o diálogo anterior de liberar
                    // o jogador durante o fade
                    global.dialogo_instancia
                        .desbloqueio_atrasado = 0;
                }
                else
                {
                    opcao_pendente = -1;
                    transicao_iniciada = false;
                    pode_interagir = true;
                }
            }


            // ==============================================
            // DEIXAR COMO ESTÁ
            // ==============================================

            else
            {
                var _escolha_aplicada =
                    aplicar_escolha_sementes(
                        _opcao
                    );


                pode_interagir =
                    !_escolha_aplicada;
            }
        }
    );


    global.dialogo_instancia.abrir_escolha(
        "Mensageiro",

        "Um saco de sementes está rasgado. Algumas sementes estão caindo pelo caminho.",

        [
            "Amarrar o saco",
            "Deixar como está",
            "Abrir mais o rasgo"
        ],

        _salvar_escolha
    );
};

#endregion