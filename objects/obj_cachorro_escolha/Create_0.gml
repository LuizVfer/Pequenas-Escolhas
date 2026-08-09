event_inherited();


#region Configuração da interação

offset_indicador_y = 12;
prioridade_interacao = 10;
opcao_cachorro_pendente = -1;

#endregion


#region Estado visual

alimentado = false;
libertado = false;


// Restaura o resultado caso a escolha já tenha sido feita
switch (global.escolha_cachorro)
{
    // Libertou o cachorro
    case 0:
        libertado = true;
        alimentado = false;

        sprite_index = spr_cachorro_livre;
    break;


    // Alimentou e libertou
    case 1:
        libertado = true;
        alimentado = true;

        sprite_index = spr_cachorro_livre;
    break;


    // Ignorou ou ainda não realizou a escolha
    default:
        libertado = false;
        alimentado = false;

        sprite_index = spr_cachorro_preso;
    break;
}


image_index = 0;
image_speed = 1;

pode_interagir =
    global.escolha_cachorro == -1;

#endregion


#region Som da armadilha

tocar_som_armadilha = function()
{
    // Abaixa temporariamente a música
    // para destacar o efeito
    if (instance_exists(global.game_instancia))
    {
        global.game_instancia
            .abaixar_musica_para_efeito(
                55,
                0.30
            );
    }


    var _som_armadilha = audio_play_sound(
        snd_armadilha,
        2,
        false
    );


    audio_sound_gain(
        _som_armadilha,
        0.70,
        0
    );

    audio_sound_pitch(
        _som_armadilha,
        0.95
    );
};

#endregion


#region Aplicar escolha

aplicar_escolha_cachorro = function(_opcao)
{
    global.escolha_cachorro = _opcao;
    pode_interagir = false;


    switch (_opcao)
    {
        // Libertar
        case 0:
            libertado = true;
            alimentado = false;

            sprite_index = spr_cachorro_livre;

            tocar_som_armadilha();
        break;


        // Alimentar e libertar
        case 1:
            libertado = true;
            alimentado = true;

            sprite_index = spr_cachorro_livre;

            tocar_som_armadilha();
        break;


        // Ignorar
        case 2:
            libertado = false;
            alimentado = false;

            sprite_index = spr_cachorro_preso;
        break;


        // Segurança para um valor inválido
        default:
            global.escolha_cachorro = -1;
            pode_interagir = true;
            exit;
    }


    image_index = 0;
    image_speed = 1;
};

#endregion


#region Interação

interagir = function()
{
    // Impede que uma nova escolha seja realizada
    if (
        global.escolha_cachorro != -1
        || !pode_interagir
    )
    {
        exit;
    }


    var _salvar_escolha = method(
        id,

        function(_opcao)
        {
            // ==========================================
            // LIBERTAR OU ALIMENTAR E LIBERTAR
            // ==========================================

            if (_opcao == 0 || _opcao == 1)
            {
                // Guarda a escolha na instância.
                // O callback será executado somente
                // depois que o fade terminar.
                opcao_cachorro_pendente =
                    _opcao;


                var _aplicar_resultado = method(
                    id,

                    function()
                    {
                        // Recupera a escolha armazenada
                        var _opcao_salva =
                            opcao_cachorro_pendente;


                        // Limpa a opção pendente
                        opcao_cachorro_pendente =
                            -1;


                        aplicar_escolha_cachorro(
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


                // Bloqueia a interação somente se
                // a transição realmente começar
                if (_fade_iniciado)
                {
                    pode_interagir = false;
                }
                else
                {
                    // O fade não começou, portanto
                    // não existe escolha aguardando
                    opcao_cachorro_pendente = -1;
                }


                exit;
            }


            // Ignorar não precisa de transição visual
            aplicar_escolha_cachorro(
                _opcao
            );
        }
    );


    global.dialogo_instancia.abrir_escolha(
        "Mensageiro",

        "Um cachorro está preso em uma armadilha. O que fazer?",

        [
            "Libertar o cachorro",
            "Alimentar e libertar",
            "Ignorar o cachorro"
        ],

        _salvar_escolha
    );
};

#endregion

