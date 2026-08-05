// ==================================================
// SEGURANÇA
// ==================================================

if (global.roda_usada)
{
    instance_destroy();
    exit;
}


if (reparo_iniciado)
{
    image_speed = 0;
    image_index = 0;
    exit;
}

// ==================================================
// NOVO PUZZLE DA RODA
// ==================================================

if (estado_puzzle_roda > 0)
{
    var _player_minigame =
        instance_find(obj_player, 0);


    // Segurança
    if (!instance_exists(_player_minigame))
    {
        estado_puzzle_roda = 0;
        sendo_empurrada = false;
        minigame_ativo = false;

        global.controle_bloqueado = false;

        exit;
    }


    // ==================================================
    // MANTER O PLAYER NA POSE DE EMPURRAR
    // ==================================================

    if (
        estado_puzzle_roda >= 2
        && estado_puzzle_roda <= 4
    )
    {
        global.controle_bloqueado = true;

        _player_minigame.sprite_index =
            spr_player_empurrando;

        _player_minigame.image_xscale = 1;
        _player_minigame.direcao = 1;

        _player_minigame.x =
            x - distancia_player_roda;
    }


    // ==================================================
    // 1 — AGUARDAR O DIÁLOGO TERMINAR
    // ==================================================

    if (estado_puzzle_roda == 1)
    {
        if (!global.controle_bloqueado)
        {
            global.controle_bloqueado = true;

            _player_minigame.hsp = 0;

            _player_minigame.x =
                x - distancia_player_roda;

            _player_minigame.sprite_index =
                spr_player_empurrando;

            _player_minigame.image_xscale = 1;
            _player_minigame.direcao = 1;

            _player_minigame.image_index = 0;
            _player_minigame.image_speed = 0;

            preparar_minigame_roda();
        }

        exit;
    }


    // ==================================================
    // 2 — MINIGAME ATIVO
    // ==================================================

    if (estado_puzzle_roda == 2)
    {
        image_speed = 0;

        _player_minigame.image_speed = 0;
        
        anim_minigame_roda += 0.10;


        if (feedback_erro > 0)
        {
            feedback_erro--;
        }


        if (bloqueio_entrada_minigame > 0)
        {
            bloqueio_entrada_minigame--;
            exit;
        }


        // Move o marcador
        marcador_posicao +=
            velocidade_marcador
            * marcador_direcao;


        // Volta ao chegar nas extremidades
        if (marcador_posicao >= 1)
        {
            marcador_posicao = 1;
            marcador_direcao = -1;
        }
        else if (marcador_posicao <= 0)
        {
            marcador_posicao = 0;
            marcador_direcao = 1;
        }


        // ==============================================
        // TENTATIVA COM E
        // ==============================================

        if (keyboard_check_pressed(ord("E")))
        {
            var _zona_inicio =
                zona_centro
                - zona_largura * 0.5;

            var _zona_fim =
                zona_centro
                + zona_largura * 0.5;


            var _acertou =
                marcador_posicao >= _zona_inicio
                && marcador_posicao <= _zona_fim;


            // ==========================================
            // ACERTOU
            // ==========================================

            if (_acertou)
            {
                minigame_ativo = false;

                x_inicio_impulso = x;

                x_fim_impulso =
                    calcular_destino_impulso(
                        impulso_atual + 1
                    );

                contador_impulso = 0;

                estado_puzzle_roda = 3;


                var _som_acerto =
                    audio_play_sound(
                        snd_opcao_confirmar,
                        1,
                        false
                    );

                audio_sound_gain(
                    _som_acerto,
                    0.45,
                    0
                );
            }


            // ==========================================
            // ERROU
            // ==========================================

            else
            {
                feedback_erro = 30;

                marcador_posicao = 0;
                marcador_direcao = 1;

                bloqueio_entrada_minigame = 10;

                sortear_zona_minigame();


                var _som_erro =
                    audio_play_sound(
                        snd_opcao_mover,
                        0,
                        false
                    );

                audio_sound_gain(
                    _som_erro,
                    0.30,
                    0
                );

                audio_sound_pitch(
                    _som_erro,
                    0.70
                );
            }
        }

        exit;
    }


    // ==================================================
    // 3 — MOVIMENTO DO IMPULSO
    // ==================================================

    if (estado_puzzle_roda == 3)
    {
        contador_impulso++;


        var _progresso_impulso =
            clamp(
                contador_impulso
                    / duracao_impulso,
                0,
                1
            );


        // Movimento suave no começo e no final
        var _progresso_suave =
            _progresso_impulso
            * _progresso_impulso
            * (
                3
                - 2 * _progresso_impulso
            );


        x = lerp(
            x_inicio_impulso,
            x_fim_impulso,
            _progresso_suave
        );


        // Player acompanha a roda
        _player_minigame.x =
            x - distancia_player_roda;


        // Animações durante o movimento
        image_speed = velocidade_animacao;

        _player_minigame.sprite_index =
            spr_player_empurrando;

        _player_minigame.image_speed = 0.18;


        // ==============================================
        // IMPULSO TERMINOU
        // ==============================================

        if (_progresso_impulso >= 1)
        {
            x = x_fim_impulso;

            _player_minigame.x =
                x - distancia_player_roda;


            image_speed = 0;
            image_index = 0;

            _player_minigame.image_speed = 0;
            _player_minigame.image_index = 0;


            impulso_atual++;


            // ==========================================
            // CHEGOU À CARROÇA
            // ==========================================

            if (
                impulso_atual
                >= quantidade_impulsos
            )
            {
                // Garante posição exata no alvo
                x = x_destino_sequencia;

                estado_puzzle_roda = 5;

                sendo_empurrada = false;
                minigame_ativo = false;

                global.controle_bloqueado = false;


                _player_minigame.sprite_index =
                    spr_player_idle;

                _player_minigame.image_index = 0;
                _player_minigame.image_speed = 0;


                global.dialogo_instancia.abrir(
                [
                    {
                        nome: "Mensageiro",
                        texto: "A roda está no lugar. Agora preciso prendê-la."
                    }
                ]);
            }


            // ==========================================
            // PREPARAR PRÓXIMO IMPULSO
            // ==========================================

            else
            {
                estado_puzzle_roda = 4;

                contador_espera =
                    espera_proximo_impulso;
            }
        }

        exit;
    }


    // ==================================================
    // 4 — ESPERA ENTRE IMPULSOS
    // ==================================================

    if (estado_puzzle_roda == 4)
    {
        image_speed = 0;

        _player_minigame.image_speed = 0;


        contador_espera--;


        if (contador_espera <= 0)
        {
            preparar_minigame_roda();
        }

        exit;
    }


    // ==================================================
    // 5 — RODA POSICIONADA
    // ==================================================

    // ==================================================
    // 5 — AGUARDAR DIÁLOGO DO MARTELO TERMINAR
    // ==================================================
    
    if (estado_puzzle_roda == 5)
    {
        sendo_empurrada = false;
        minigame_ativo = false;
        pode_interagir = false;
    
        image_speed = 0;
        image_index = 0;
    
    
        // O diálogo terminou
        if (!global.controle_bloqueado)
        {
            global.controle_bloqueado = true;
    
            _player_minigame.hsp = 0;
    
            _player_minigame.sprite_index =
                spr_player_idle;
    
            _player_minigame.image_index = 0;
            _player_minigame.image_speed = 0;
    
            marteladas_corretas = 0;
    
            preparar_minigame_martelo();
        }
    
        exit;
    }
    
    // ==================================================
    // 6 — MINIGAME DO MARTELO
    // ==================================================
    
    if (estado_puzzle_roda == 6)
    {
        global.controle_bloqueado = true;
    
        sendo_empurrada = false;
        pode_interagir = false;
    
        image_speed = 0;
        image_index = 0;
    
    
        // Player permanece parado perto da roda
        _player_minigame.hsp = 0;
    
        _player_minigame.sprite_index =
            spr_player_idle;
    
        _player_minigame.image_index = 0;
        _player_minigame.image_speed = 0;
    
    
        anim_minigame_roda += 0.10;
    
    
        if (feedback_erro > 0)
        {
            feedback_erro--;
        }
    
    
        // Pequena pausa entre as tentativas
        if (bloqueio_entrada_minigame > 0)
        {
            bloqueio_entrada_minigame--;
            exit;
        }
    
    
        // ==============================================
        // MOVIMENTO DO MARCADOR
        // ==============================================
    
        marcador_posicao +=
            velocidade_marcador
            * marcador_direcao;
    
    
        if (marcador_posicao >= 1)
        {
            marcador_posicao = 1;
            marcador_direcao = -1;
        }
        else if (marcador_posicao <= 0)
        {
            marcador_posicao = 0;
            marcador_direcao = 1;
        }
    
    
        // ==============================================
        // TENTATIVA
        // ==============================================
    
        if (keyboard_check_pressed(ord("E")))
        {
            var _zona_inicio =
                zona_centro
                - zona_largura * 0.5;
    
            var _zona_fim =
                zona_centro
                + zona_largura * 0.5;
    
    
            var _acertou =
                marcador_posicao >= _zona_inicio
                && marcador_posicao <= _zona_fim;
    
    
            // ==========================================
            // ACERTOU
            // ==========================================
    
            if (_acertou)
            {
                marteladas_corretas++;
    
    
                // Abaixa a música em cada martelada
                if (instance_exists(global.game_instancia))
                {
                    global.game_instancia
                        .abaixar_musica_para_efeito(
                            35,
                            0.25
                        );
                }
    
    
                var _som_martelo = audio_play_sound(
                    snd_martelo,
                    2,
                    false
                );
    
                audio_sound_gain(
                    _som_martelo,
                    1,
                    0
                );
    
    
                // ======================================
                // TRÊS ACERTOS CONSECUTIVOS
                // ======================================
    
                if (
                    marteladas_corretas
                    >= quantidade_marteladas
                )
                {
                    minigame_ativo = false;
    
                    _player_minigame.sprite_index =
                        spr_player_idle;
    
                    _player_minigame.image_index = 0;
                    _player_minigame.image_speed = 0;
    
                    concluir_reparo_carroca();
                }
                else
                {
                    preparar_minigame_martelo();
                }
            }
    
    
            // ==========================================
            // ERROU
            // ==========================================
    
            else
            {
                // Perde toda a sequência
                marteladas_corretas = 0;
    
                feedback_erro = 30;
    
                marcador_posicao = 0;
                marcador_direcao = 1;
    
                velocidade_marcador =
                    velocidade_martelo_base;
    
                bloqueio_entrada_minigame = 12;
    
                zona_centro = random_range(
                    0.24,
                    0.76
                );
    
    
                var _som_erro = audio_play_sound(
                    snd_opcao_mover,
                    0,
                    false
                );
    
                audio_sound_gain(
                    _som_erro,
                    0.30,
                    0
                );
    
                audio_sound_pitch(
                    _som_erro,
                    0.70
                );
            }
        }
    
        exit;
    }
}


// ==================================================
// RODA NÃO ATIVADA PARA EMPURRAR
// ==================================================

if (!sendo_empurrada)
{
    pode_interagir =
        global.roda_liberada;

    image_speed = 0;
    image_index = 0;

    exit;
}


pode_interagir = false;


// Não move durante diálogo ou fade
if (global.controle_bloqueado)
{
    image_speed = 0;
    image_index = 0;
    exit;
}


var _player = instance_find(obj_player, 0);

if (_player == noone)
{
    sendo_empurrada = false;

    image_speed = 0;
    image_index = 0;

    exit;
}


// ==================================================
// SOLTAR A RODA
// ==================================================

var _distancia_player =
    abs(_player.x - x);

if (_distancia_player > distancia_soltar)
{
    sendo_empurrada = false;
    pode_interagir = true;

    image_speed = 0;
    image_index = 0;

    exit;
}


// ==================================================
// VERIFICAR EMPURRÃO E ENCAIXE VISUAL
// ==================================================

var _movimento = 0;

// Posição exata em que a roda deve ficar encostada
var _x_encoste =
    _player.x
    + lado_empurrao * distancia_encoste_visual;


// Player está no lado correto da roda
var _lado_correto =
(
    lado_empurrao > 0
    && _player.x < x
)
||
(
    lado_empurrao < 0
    && _player.x > x
);


// Player está andando na direção do empurrão
var _andando_para_roda =
(
    lado_empurrao > 0
    && _player.hsp > 0
)
||
(
    lado_empurrao < 0
    && _player.hsp < 0
);


// Verifica se o ponto de encoste alcançou a roda
var _alcancou_roda = false;

if (lado_empurrao > 0)
{
    _alcancou_roda =
        _x_encoste >= x
        && _x_encoste - x
            <= abs(_player.hsp) + tolerancia_encoste;
}
else
{
    _alcancou_roda =
        _x_encoste <= x
        && x - _x_encoste
            <= abs(_player.hsp) + tolerancia_encoste;
}


// ==================================================
// MOVIMENTAR
// ==================================================

if (
    _lado_correto
    && _andando_para_roda
    && _alcancou_roda
)
{
    var _novo_x = _x_encoste;

    if (!place_meeting(_novo_x, y, obj_solid))
    {
        _movimento = _novo_x - x;
        x = _novo_x;
    }
}


// ==================================================
// ANIMAÇÃO
// ==================================================

if (_movimento != 0)
{
    // Positivo girando para a direita,
    // negativo girando para a esquerda
    image_speed =
        velocidade_animacao
        * sign(_movimento);
}
else
{
    image_speed = 0;
    image_index = 0;
}


