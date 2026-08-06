event_inherited();


#region Configuração da interação

distancia_interacao = 56;
prioridade_interacao = 10;

offset_indicador_y = 12;

// Ponto de interação próximo ao brinquedo na árvore
offset_interacao_x = 0;
offset_interacao_y = 32;

#endregion


#region Restaurar estado

// O brinquedo desaparece da árvore caso tenha sido
// recuperado ou derrubado
visible = !(
    global.escolha_brinquedo == 0
    || global.escolha_brinquedo == 1
);

// A escolha só é liberada depois de conversar
// com a criança
pode_interagir =
    global.crianca_destino_conversada
    && global.escolha_brinquedo == -1;

#endregion


#region Aplicar resultado da escolha

aplicar_escolha_brinquedo = function()
{
    var _mensagem = "";


    switch (global.escolha_brinquedo)
    {
        // Ajudar a criança
        case 0:
            with (obj_crianca_destino)
            {
                sprite_index = spr_crianca_brinquedo;
                image_index = 0;
                image_speed = 0;
            }

            visible = false;

            _mensagem =
                "Com algum esforço, o mensageiro alcança o brinquedo e o devolve à criança.";
        break;


        // Derrubar com uma pedra
        case 1:
            with (obj_crianca_destino)
            {
                sprite_index = spr_crianca_brinquedo_quebrado;
                image_index = 0;
                image_speed = 0;
            }

            visible = false;

            _mensagem =
                "A pedra atinge o galho. O brinquedo cai, mas se quebra ao tocar o chão.";
        break;


        // Não fazer nada
        case 2:
            with (obj_crianca_destino)
            {
                sprite_index = spr_crianca_alcancando;
                image_index = 0;
                image_speed = 0;
            }

            _mensagem =
                "O mensageiro decide não interferir e segue seu caminho.";
        break;


        // Segurança para um valor inválido
        default:
            exit;
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

#endregion


#region Interação

interagir = function()
{
    // Impede que outra escolha seja feita
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


            // As opções que alteram os sprites
            // utilizam uma transição
            if (_opcao == 0 || _opcao == 1)
            {
                var _aplicar_resultado = method(
                    id,

                    function()
                    {
                        aplicar_escolha_brinquedo();
                    }
                );


                // O controle permanecerá bloqueado durante o fade
                global.dialogo_instancia.desbloqueio_atrasado = 0;


                global.fade_instancia.iniciar(
                    _aplicar_resultado,
                    0.05,
                    0
                );

                exit;
            }


            // Não fazer nada não precisa de transição
            aplicar_escolha_brinquedo();
        }
    );


    global.dialogo_instancia.abrir_escolha(
        "Mensageiro",

        "O brinquedo está preso entre os galhos, longe do alcance da criança. O que fazer?",

        [
            "Ajudar a criança",
            "Derrubar com uma pedra",
            "Não fazer nada"
        ],

        _salvar_escolha
    );
};

#endregion