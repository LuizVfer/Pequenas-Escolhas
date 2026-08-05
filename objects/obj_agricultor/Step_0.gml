#region Portão já aberto

if (global.portao_aberto)
{
    aguardando_abertura = false;
    transicao_iniciada = false;
    pode_interagir = true;

    exit;
}

#endregion


#region Abertura ainda não iniciada

if (!aguardando_abertura)
{
    pode_interagir = true;

    exit;
}

#endregion


#region Aguardar diálogo

pode_interagir = false;


// Aguarda a conversa da entrega terminar.
if (
    global.dialogo_ativo
    || transicao_iniciada
)
{
    exit;
}

#endregion


#region Iniciar abertura do portão

transicao_iniciada = true;


var _abrir_portao = method(
    id,

    function()
    {
        global.portao_aberto = true;


        // ----------------------------------------------
        // Mover agricultor para perto do portão
        // ----------------------------------------------

        var _ponto = instance_find(
            obj_ponto_agricultor_portao,
            0
        );

        if (_ponto != noone)
        {
            x = _ponto.x;
            y = _ponto.y;
        }


        // ----------------------------------------------
        // Atualizar o portão
        // ----------------------------------------------

        with (obj_portao_vila)
        {
            sprite_index = spr_portao_aberto;
            image_index = 0;
            image_speed = 0;

            pode_interagir = false;
        }


        // ----------------------------------------------
        // Remover a colisão do portão
        // ----------------------------------------------

        with (obj_bloqueio_portao)
        {
            instance_destroy();
        }


        // ----------------------------------------------
        // Som do portão
        // ----------------------------------------------

        if (som_portao != noone)
        {
            global.game_instancia
                .abaixar_musica_para_efeito(
                    75,
                    0.30
                );

            audio_play_sound(
                som_portao,
                2,
                false
            );
        }


        // ----------------------------------------------
        // Finalizar abertura
        // ----------------------------------------------

        aguardando_abertura = false;
        transicao_iniciada = false;
        pode_interagir = true;
    }
);


global.fade_instancia.iniciar(
    _abrir_portao,
    0.05,
    60
);

#endregion