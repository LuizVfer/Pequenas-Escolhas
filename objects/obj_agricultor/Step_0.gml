// Portão já está aberto
if (global.portao_aberto)
{
    pode_interagir = true;
    exit;
}


// Ainda não iniciou a abertura
if (!aguardando_abertura)
{
    pode_interagir = true;
    exit;
}


pode_interagir = false;


// Aguarda o diálogo terminar
if (
    global.dialogo_ativo
    || transicao_iniciada
)
{
    exit;
}


// ==================================================
// INICIAR ABERTURA
// ==================================================

transicao_iniciada = true;

var _abrir_portao = method(
    id,

    function()
    {
        global.portao_aberto = true;


        // Move o agricultor para perto do portão
        var _ponto = instance_find(
            obj_ponto_agricultor_portao,
            0
        );

        if (_ponto != noone)
        {
            x = _ponto.x;
            y = _ponto.y;
        }


        // Atualiza o portão
        with (obj_portao_vila)
        {
            sprite_index = spr_portao_aberto;
            image_index = 0;
            image_speed = 0;

            pode_interagir = false;
        }


        // Remove a colisão
        with (obj_bloqueio_portao)
        {
            instance_destroy();
        }


        // Futuro som do portão
        if (som_portao != noone)
        {
            // Abaixa a música durante a abertura do portão
            global.game_instancia.abaixar_musica_para_efeito(
                75,
                0.30
            );
            
            audio_play_sound(
                snd_portao_abrindo,
                2,
                false
            );
        }


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