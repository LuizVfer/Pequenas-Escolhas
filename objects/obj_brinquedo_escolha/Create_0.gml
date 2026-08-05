event_inherited();

distancia_interacao = 56;
offset_indicador_y = 12;
prioridade_interacao = 10;

// Ajuste conforme o local do brinquedo na árvore
offset_interacao_x = 0;
offset_interacao_y = 32;


// A escolha já foi feita
if (global.escolha_brinquedo != -1)
{
    pode_interagir = false;

    // Nas opções 0 e 1, o brinquedo já caiu da árvore
    if (
        global.escolha_brinquedo == 0
        || global.escolha_brinquedo == 1
    )
    {
        visible = false;
    }
}
else
{
    pode_interagir =
        global.crianca_destino_conversada;
}

// ==================================================
// APLICAR RESULTADO DA ESCOLHA
// ==================================================

aplicar_escolha_brinquedo = function()
{
    var _mensagem = "";


    switch (global.escolha_brinquedo)
    {
        // ==========================================
        // AJUDAR A CRIANÇA
        // ==========================================

        case 0:
            with (obj_crianca_destino)
            {
                sprite_index =
                    spr_crianca_brinquedo;

                image_index = 0;
                image_speed = 0;
            }

            visible = false;

            _mensagem =
                "Você alcançou o brinquedo e o entregou à criança.";
        break;


        // ==========================================
        // DERRUBAR COM UMA PEDRA
        // ==========================================

        case 1:
            with (obj_crianca_destino)
            {
                sprite_index =
                    spr_crianca_brinquedo_quebrado;

                image_index = 0;
                image_speed = 0;
            }

            visible = false;

            _mensagem =
                "Você lançou uma pedra. O brinquedo caiu, mas se partiu.";
        break;


        // ==========================================
        // NÃO FAZER NADA
        // ==========================================

        case 2:
            with (obj_crianca_destino)
            {
                sprite_index =
                    spr_crianca_alcancando;

                image_index = 0;
                image_speed = 0;
            }

            _mensagem =
                "Você decidiu continuar seu caminho.";
        break;
    }


    show_debug_message(
        "Escolha do brinquedo salva: "
        + string(global.escolha_brinquedo)
    );


    global.dialogo_instancia.abrir(
    [
        {
            nome: "",
            texto: _mensagem
        }
    ]);
};


// ==================================================
// INTERAÇÃO
// ==================================================

interagir = function()
{
    if (global.escolha_brinquedo != -1)
    {
        exit;
    }


    var _salvar_escolha = method(
        id,

        function(_opcao)
        {
            global.escolha_brinquedo = _opcao;
            pode_interagir = false;


            // ==========================================
            // OPÇÕES QUE ALTERAM OS OBJETOS
            // ==========================================

            if (
                _opcao == 0
                || _opcao == 1
            )
            {
                var _aplicar_resultado = method(
                    id,

                    function()
                    {
                        aplicar_escolha_brinquedo();
                    }
                );


                // Impede o diálogo anterior de liberar
                // o jogador durante o fade
                global.dialogo_instancia
                    .desbloqueio_atrasado = 0;


                global.fade_instancia.iniciar(
                    _aplicar_resultado,
                    0.05,
                    0
                );
            }


            // ==========================================
            // NÃO FAZER NADA
            // ==========================================

            else
            {
                aplicar_escolha_brinquedo();
            }
        }
    );


    global.dialogo_instancia.abrir_escolha(
        "Mensageiro",

        "O brinquedo da criança está preso entre os galhos. O que fazer?",

        [
            "Ajudar a criança",
            "Derrubar com uma pedra",
            "Não fazer nada"
        ],

        _salvar_escolha
    );
};