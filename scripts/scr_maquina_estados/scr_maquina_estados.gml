function estado() constructor
{
    // Iniciando o estado
    static inicia = function() {};

    // Roda o estado
    static roda = function() {};

    // Finaliza o estado
    static finaliza = function() {};
}


// Função para iniciar um estado específico
function inicia_estado(_estado)
{
    estado_atual = _estado;
    estado_atual.inicia();
}


// Função para trocar de estado
function troca_estado(_estado)
{
    estado_atual.finaliza();

    estado_atual = _estado;

    estado_atual.inicia();
}


// Rodar o estado atual
function roda_estado()
{
    estado_atual.roda();
}