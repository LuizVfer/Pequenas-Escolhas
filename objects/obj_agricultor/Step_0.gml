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


// Aguarda a conversa da entrega terminar
if (
    global.dialogo_ativo
    || transicao_iniciada
)
{
    exit;
}

#endregion


#region Preparar abertura do portão

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
        // Remover o bloqueio da passagem
        // ----------------------------------------------

        with (obj_bloqueio_portao)
        {
            instance_destroy();
        }


        // ----------------------------------------------
        // Reproduzir o som do portão
        // ----------------------------------------------

        if (som_portao != noone)
        {
            if (instance_exists(global.game_instancia))
            {
                global.game_instancia
                    .abaixar_musica_para_efeito(
                        75,
                        0.30
                    );
            }


            var _som_abertura = audio_play_sound(
                som_portao,
                2,
                false
            );


            audio_sound_gain(
                _som_abertura,
                1,
                0
            );
        }
        
        // Impacto do portão abrindo
        with (obj_camera)
        {
            tremer(2, 14);
        }


        // ----------------------------------------------
        // Finalizar abertura
        // ----------------------------------------------

        aguardando_abertura = false;
        transicao_iniciada = false;
        pode_interagir = true;

        // O obj_fade devolverá o controle ao jogador
    }
);

#endregion


#region Iniciar transição

var _fade_iniciado =
    global.fade_instancia.iniciar(
        _abrir_portao,
        0.05,
        60
    );


// Só registra a transição caso o fade comece
if (_fade_iniciado)
{
    transicao_iniciada = true;
}

#endregion