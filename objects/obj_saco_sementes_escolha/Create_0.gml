event_inherited();

distancia_interacao = 44;
offset_indicador_y = 12;
prioridade_interacao = 10;

alimentando_animacao = false;


// ==================================================
// RESTAURA ESCOLHA SALVA
// ==================================================

if (global.escolha_sementes != -1)
{
    pode_interagir = false;

    switch (global.escolha_sementes)
    {
        // Amarrar
        case 0:
            sprite_index =
                spr_saco_sementes_amarrado;
        break;


        // Deixar como está
        case 1:
            sprite_index =
                spr_saco_sementes_rasgado;
        break;


        // Abrir mais
        case 2:
            sprite_index =
                spr_saco_sementes_aberto;
        break;
    }

    image_index = 0;
    image_speed = 0;
}
else
{
    pode_interagir = true;
}


// ==================================================
// INTERAÇÃO
// ==================================================

interagir = function()
{
    if (global.escolha_sementes != -1)
    {
        exit;
    }


    var _salvar_escolha = method(
        id,

        function(_opcao)
        {
            global.escolha_sementes = _opcao;
            pode_interagir = false;

            var _mensagem = "";


            switch (_opcao)
            {
                // Amarrar
                case 0:
                    sprite_index =
                        spr_saco_sementes_amarrado;

                    _mensagem =
                        "Você apertou a corda e fechou o rasgo. O saco está bem fechado.";
                break;


                // Deixar como está
                case 1:
                    sprite_index =
                        spr_saco_sementes_rasgado;

                    _mensagem =
                        "Você decidiu não mexer no saco. Algumas sementes continuam caindo.";
                break;


                // Abrir mais
                case 2:
                    sprite_index =
                        spr_saco_sementes_aberto;

                    _mensagem =
                        "Você puxou o tecido e aumentou o rasgo. Mais sementes se espalharam pelo caminho.";
                break;
            }


            image_index = 0;
            image_speed = 0;


            show_debug_message(
                "Escolha das sementes salva: "
                + string(global.escolha_sementes)
            );


            global.dialogo_instancia.abrir(
            [
                {
                    nome: "",
                    texto: _mensagem
                }
            ]);
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