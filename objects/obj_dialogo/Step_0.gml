// Libera o controle após fechar
if (desbloqueio_atrasado > 0)
{
    desbloqueio_atrasado--;


    if (desbloqueio_atrasado <= 0)
    {
        var _fade_ativo =
            instance_exists(global.fade_instancia)
            && global.fade_instancia.ativo;


        // Não libera o jogador enquanto outro fade acontece
        if (_fade_ativo)
        {
            global.controle_bloqueado = true;
        }
        else
        {
            global.controle_bloqueado = false;
        }
    }


    exit;
}


// Diálogo fechado
if (!ativo)
{
    exit;
}


// Evita que o mesmo E usado para abrir avance
if (bloqueio_entrada > 0)
{
    bloqueio_entrada--;
    exit;
}

// ==================================================
// ESCOLHAS
// ==================================================

if (modo_escolha)
{
    var _quantidade = array_length(opcoes);

    var _cima =
        keyboard_check_pressed(vk_up)
        || keyboard_check_pressed(ord("W"));

    var _baixo =
        keyboard_check_pressed(vk_down)
        || keyboard_check_pressed(ord("S"));

    var _confirmar =
        keyboard_check_pressed(ord("E"))
        || keyboard_check_pressed(vk_enter);


    var _opcao_antes = opcao_atual;


    // Move para cima
    if (_cima)
    {
        opcao_atual =
            (opcao_atual - 1 + _quantidade)
            mod _quantidade;
    }
    
    
    // Move para baixo
    if (_baixo)
    {
        opcao_atual =
            (opcao_atual + 1)
            mod _quantidade;
    }
    
    
    // Som ao mudar de opção
    if (opcao_atual != _opcao_antes)
    {
        var _som_mover = audio_play_sound(
            snd_opcao_mover,
            0,
            false
        );
    
        audio_sound_gain(
            _som_mover,
            0.35,
            0
        );
    
        audio_sound_pitch(
            _som_mover,
            0.90
        );
    }
    
    
    // Confirma a opção
    if (_confirmar)
    {
        var _som_confirmar = audio_play_sound(
            snd_opcao_confirmar,
            1,
            false
        );
    
        audio_sound_gain(
            _som_confirmar,
            0.55,
            0
        );
    
    
        var _resultado = opcao_atual;
        var _funcao = funcao_escolha;
        
        // Fecha a caixa antes de aplicar o resultado
        fechar();
        
        // Executa o callback da escolha
        if (is_method(_funcao))
        {
            method_call(
                _funcao,
                [_resultado]
            );
        }
        else
        {
            show_debug_message(
                "ERRO: funcao_escolha não contém um método válido."
            );
        }
    }

    exit;
}


// Texto da página atual
var _texto_atual = paginas[pagina_atual].texto;
var _tamanho_texto = string_length(_texto_atual);




// ==================================================
// MÁQUINA DE ESCREVER E SOM DO TEXTO
// ==================================================

if (texto_visivel < _tamanho_texto)
{
    var _caracteres_antes =
        floor(texto_visivel);


    texto_visivel = min(
        texto_visivel + velocidade_texto,
        _tamanho_texto
    );


    var _caracteres_agora =
        floor(texto_visivel);


    // A quantidade de caracteres realmente aumentou
    if (_caracteres_agora > _caracteres_antes)
    {
        // Evita tocar um efeito em todas as letras
        if (
            _caracteres_agora
            >= ultimo_caractere_som
            + intervalo_som_texto
        )
        {
            ultimo_caractere_som =
                _caracteres_agora;


            // Evita muitos efeitos sobrepostos
            if (!audio_is_playing(snd_texto))
            {
                var _som_texto = audio_play_sound(
                    snd_texto,
                    0,
                    false
                );
                
                
                // Alterna entre um som levemente grave e agudo
                var _pitch_texto = 1.30;
                
                if (pitch_texto_alternado)
                {
                    _pitch_texto = 1.50;
                }
                
                pitch_texto_alternado =
                    !pitch_texto_alternado;
                
                
                audio_sound_pitch(
                    _som_texto,
                    _pitch_texto
                );
            }
        }
    }
}


var _confirmar =
    keyboard_check_pressed(ord("E"))
    || keyboard_check_pressed(vk_enter);


if (_confirmar)
{
    if (texto_visivel < _tamanho_texto)
    {
        texto_visivel = _tamanho_texto;
    }
    else
    {
        pagina_atual++;

        if (pagina_atual >= array_length(paginas))
        {
            fechar();
        }
        else
        {
            texto_visivel = 0;
            ultimo_caractere_som = 0;
        }
    }
}

