#region Configuração da interação

// Distância máxima entre o jogador
// e o ponto de interação
distancia_interacao = 48;


// Permite desativar temporariamente
// a interação deste objeto
pode_interagir = true;


// NPCs usam normalmente prioridade 0.
// Puzzles e escolhas usam valores maiores.
prioridade_interacao = 0;

#endregion


#region Ponto de interação

// Desloca o ponto usado para calcular
// a distância até o jogador.
//
// Útil para objetos grandes, como
// a ponte e o portão.
offset_interacao_x = 0;
offset_interacao_y = 0;

#endregion


#region Indicador de interação

// Distância vertical entre o topo
// do objeto e o indicador da tecla E
offset_indicador_y = 40;

#endregion


#region Função padrão

// Os objetos filhos devem substituir
// esta função pela interação correspondente.
interagir = function()
{
    show_debug_message(
        "AVISO: interação não configurada em "
        + object_get_name(object_index)
        + "."
    );
};

#endregion