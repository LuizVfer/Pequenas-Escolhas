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
// SOM DA ARMADILHA
// ==================================================

tocar_som_armadilha = function()
{
    // Abaixa a música para destacar o efeito
    if (instance_exists(global.game_instancia))
    {
        global.game_instancia
            .abaixar_musica_para_efeito(
                55,
                0.30
            );
    }

    var _som = audio_play_sound(
        snd_armadilha,
        2,
        false
    );

    audio_sound_gain(
        _som,
        0.70,
        0
    );

    audio_sound_pitch(
        _som,
        0.95
    );
};


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
    
    
            // ==========================================
            // LIBERTAR OU ALIMENTAR E LIBERTAR
            // ==========================================
            
            if (
                _opcao == 0
                || _opcao == 1
            )
            {
                var _mostrar_cachorro_livre = method(
                    id,
            
                    function()
                    {
                        libertado = true;
            
                        alimentado =
                            (global.escolha_cachorro == 1);
                        
                        tocar_som_armadilha();
            
                        sprite_index =
                            spr_cachorro_livre;
            
                        image_index = 0;
                        image_speed = 0;
                    }
                );
            
            
                global.dialogo_instancia
                    .desbloqueio_atrasado = 0;
            
            
                global.fade_instancia.iniciar(
                    _mostrar_cachorro_livre,
                    0.05,
                    45
                );
            }
    
    
            // ==========================================
            // IGNORAR
            // ==========================================
    
            else
            {
                libertado = false;
                alimentado = false;
    
                sprite_index =
                    spr_cachorro_preso;
    
                image_index = 0;
                image_speed = 0;
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