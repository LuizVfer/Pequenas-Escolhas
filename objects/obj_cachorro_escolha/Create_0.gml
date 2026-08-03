event_inherited();

distancia_interacao = 48;
offset_indicador_y = 12;
prioridade_interacao = 10;

// Estado visual
alimentado = false;
libertado = false;

// A escolha já foi feita anteriormente
if (global.escolha_cachorro != -1)
{
    pode_interagir = false;

    switch (global.escolha_cachorro)
    {
        case 0:
            libertado = true;
            alimentado = false;
            sprite_index = spr_cachorro_livre;
        break;
    
        case 1:
            libertado = true;
            alimentado = true;
            sprite_index = spr_cachorro_livre;
        break;
    
        case 2:
            libertado = false;
            alimentado = false;
            sprite_index = spr_cachorro_preso;
        break;
    }
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
    if (global.escolha_cachorro != -1)
    {
        exit;
    }

    var _salvar_escolha = method(
        id,

        function(_opcao)
        {
            global.escolha_cachorro = _opcao;
            pode_interagir = false;

            switch (_opcao)
            {
                case 0:
                    libertado = true;
                    alimentado = false;
            
                    sprite_index = spr_cachorro_livre;
                    image_index = 0;
                    image_speed = 0;
                break;
            
                case 1:
                    libertado = true;
                    alimentado = true;
            
                    sprite_index = spr_cachorro_livre;
                    image_index = 0;
                    image_speed = 0;
                break;
            
                case 2:
                    libertado = false;
                    alimentado = false;
            
                    sprite_index = spr_cachorro_preso;
                break;
            }
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