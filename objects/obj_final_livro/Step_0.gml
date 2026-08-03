// ==================================================
// LIVRO FECHADO
// ==================================================

if (estado_final == 0)
{
    // Aguarda o fade da troca de room terminar
    if (
        instance_exists(global.fade_instancia)
        && global.fade_instancia.ativo
    )
    {
        exit;
    }


    contador++;


    if (
        contador >= tempo_livro_fechado
        && !abertura_iniciada
    )
    {
        abertura_iniciada = true;


        var _abrir_livro = method(
            id,

            function()
            {
                // Toca o som durante a tela preta
                if (som_livro_abrindo != noone)
                {
                    audio_play_sound(
                        som_livro_abrindo,
                        2,
                        false
                    );
                }


                estado_final = 1;
                contador = 0;
                configurar_consequencia_pedra();
            }
        );


        global.fade_instancia.iniciar(
            _abrir_livro,
            0.03,
            60
        );
    }
}

// ==================================================
// CONSEQUÊNCIA SENDO CONTADA
// ==================================================

if (estado_final == 1)
{
    
    // Aguarda o fade terminar antes de começar a escrever
    if (
        instance_exists(global.fade_instancia)
        && global.fade_instancia.ativo
    )
    {
        exit;
    }
    if (array_length(frases_consequencia) <= 0)
    {
        exit;
    }


    var _frase =
        frases_consequencia[frase_atual];

    var _tamanho =
        string_length(_frase);


    // Máquina de escrever
    if (caracteres_visiveis < _tamanho)
    {
        caracteres_visiveis = min(
            caracteres_visiveis
                + velocidade_frase,

            _tamanho
        );
    }


    var _confirmar =
        keyboard_check_pressed(ord("E"))
        || keyboard_check_pressed(vk_enter);


    if (_confirmar)
    {
        // Completa imediatamente a frase
        if (caracteres_visiveis < _tamanho)
        {
            caracteres_visiveis = _tamanho;
        }

        // Vai para a próxima frase
        else if (
            frase_atual
            < array_length(frases_consequencia) - 1
        )
        {
            frase_atual++;
            caracteres_visiveis = 0;
        }

        // Terminou todas as frases
        else
        {
            if (transicao_consequencia_iniciada)
            {
                exit;
            }
        
        
            // ==================================================
            // PEDRA → CACHORRO
            // ==================================================
        
            else
            {
                if (transicao_consequencia_iniciada)
                {
                    exit;
                }
            
            
                // ==================================================
                // PEDRA → CACHORRO
                // ==================================================
            
                if (consequencia_atual == 0)
                {
                    transicao_consequencia_iniciada = true;
            
                    var _mostrar_cachorro = method(
                        id,
            
                        function()
                        {
                            configurar_consequencia_cachorro();
                        }
                    );
            
                    global.fade_instancia.iniciar(
                        _mostrar_cachorro,
                        0.03,
                        45
                    );
                }
            
            
                // ==================================================
                // CACHORRO → SEMENTES
                // ==================================================
            
                else if (consequencia_atual == 1)
                {
                    transicao_consequencia_iniciada = true;
            
                    var _mostrar_sementes = method(
                        id,
            
                        function()
                        {
                            configurar_consequencia_sementes();
                        }
                    );
            
                    global.fade_instancia.iniciar(
                        _mostrar_sementes,
                        0.03,
                        45
                    );
                }
            
            
                // ==================================================
                // SEMENTES → BRINQUEDO
                // ==================================================
                
                else if (consequencia_atual == 2)
                {
                    transicao_consequencia_iniciada = true;
                
                    var _mostrar_brinquedo = method(
                        id,
                
                        function()
                        {
                            configurar_consequencia_brinquedo();
                        }
                    );
                
                    global.fade_instancia.iniciar(
                        _mostrar_brinquedo,
                        0.03,
                        45
                    );
                }
                
                
                // ==================================================
                // BRINQUEDO CONCLUÍDO
                // ==================================================
                
                else if (consequencia_atual == 3)
                {
                    transicao_consequencia_iniciada = true;
               
                    var _fechar_livro = method(
                        id,
               
                        function()
                        {
                            consequencia_concluida = true;
               
                            // Som do livro fechando
                            if (som_livro_fechando != noone)
                            {
                                audio_play_sound(
                                    som_livro_fechando,
                                    2,
                                    false
                                );
                            }
               
                            estado_final = 2;
                            contador = 0;
                        }
                    );
               
                    global.fade_instancia.iniciar(
                        _fechar_livro,
                        0.03,
                        60
                    );
                }
            }
        }
    }
}

// ==================================================
// LIVRO FECHADO NO ENCERRAMENTO
// ==================================================

if (estado_final == 2)
{
    // Aguarda o fade anterior terminar
    if (
        instance_exists(global.fade_instancia)
        && global.fade_instancia.ativo
    )
    {
        exit;
    }


    contador++;


    if (contador >= tempo_livro_fechado_final)
    {
        var _mostrar_mensagem_final = method(
            id,

            function()
            {
                estado_final = 3;

                frase_final_atual = 0;
                caracteres_finais_visiveis = 0;

                mensagem_final_concluida = false;
            }
        );


        global.fade_instancia.iniciar(
            _mostrar_mensagem_final,
            0.03,
            45
        );
    }

    exit;
}

// ==================================================
// MENSAGEM FINAL
// ==================================================

if (estado_final == 3)
{
    // Só começa depois que o fade terminar
    if (
        instance_exists(global.fade_instancia)
        && global.fade_instancia.ativo
    )
    {
        exit;
    }


    if (mensagem_final_concluida)
    {
        exit;
    }


    var _frase =
        frases_finais[frase_final_atual];

    var _tamanho =
        string_length(_frase);


    // Máquina de escrever
    if (caracteres_finais_visiveis < _tamanho)
    {
        caracteres_finais_visiveis = min(
            caracteres_finais_visiveis
                + velocidade_mensagem_final,

            _tamanho
        );
    }


    var _confirmar =
        keyboard_check_pressed(ord("E"))
        || keyboard_check_pressed(vk_enter);


    if (_confirmar)
    {
        // Completa a frase atual
        if (caracteres_finais_visiveis < _tamanho)
        {
            caracteres_finais_visiveis = _tamanho;
        }

        // Avança para a próxima frase
        else if (
            frase_final_atual
            < array_length(frases_finais) - 1
        )
        {
            frase_final_atual++;
            caracteres_finais_visiveis = 0;
        }

        // Todas as frases terminaram
        else
        {
            mensagem_final_concluida = true;
       
            var _mostrar_creditos = method(
                id,
       
                function()
                {
                    estado_final = 4;
       
                    contador_creditos = 0;
       
                    alpha_titulo_final = 0;
                    alpha_creditos = 0;
       
                    final_completo = false;
                }
            );
       
            global.fade_instancia.iniciar(
                _mostrar_creditos,
                0.03,
                60
            );
        }
    }

    exit;
}

// ==================================================
// ESTADO 4 — TÍTULO FINAL E CRÉDITOS
// ==================================================

if (estado_final == 4)
{
    // Aguarda o fade terminar
    if (
        instance_exists(global.fade_instancia)
        && global.fade_instancia.ativo
    )
    {
        exit;
    }


    contador_creditos++;


    // ==================================================
    // TÍTULO APARECE PRIMEIRO
    // ==================================================

    alpha_titulo_final = min(
        alpha_titulo_final
            + velocidade_alpha_titulo,
        1
    );


    // ==================================================
    // CRÉDITOS APARECEM DEPOIS
    // ==================================================

    if (contador_creditos >= tempo_antes_creditos)
    {
        alpha_creditos = min(
            alpha_creditos
                + velocidade_alpha_creditos,
            1
        );
    }


    // ==================================================
    // CRÉDITOS CONCLUÍDOS
    // ==================================================

    if (
        alpha_titulo_final >= 1
        && alpha_creditos >= 1
    )
    {
        if (!final_completo)
        {
            final_completo = true;

            // O menu mostrará "Jogar novamente"
            global.jogo_concluido = true;
        }
    }


    // ==================================================
    // VOLTAR AO MENU
    // ==================================================

    if (final_completo)
    {
        var _confirmar =
            keyboard_check_pressed(ord("E"))
            || keyboard_check_pressed(vk_enter);


        if (
            _confirmar
            && !retorno_menu_iniciado
        )
        {
            retorno_menu_iniciado = true;


            var _voltar_ao_menu = method(
                id,

                function()
                {
                    global.controle_bloqueado = true;

                    // Não chama resetar_progresso()
                    room_goto(rm_menu);
                }
            );


            global.fade_instancia.iniciar(
                _voltar_ao_menu,
                0.03,
                45
            );
        }
    }

    exit;
}