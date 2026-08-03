event_inherited();

distancia_interacao = 48;
offset_indicador_y = 12;
prioridade_interacao = 0;


interagir = function()
{
    global.dialogo_instancia.abrir(
    [
        {
            nome: "Caçador",
            texto: "A mata fica mais fechada adiante. É fácil perder a direção entre essas árvores."
        },

        {
            nome: "Mensageiro",
            texto: "Vou permanecer próximo da trilha."
        },

        {
            nome: "Caçador",
            texto: "É o mais seguro. A floresta costuma esconder mais caminhos do que revela."
        }
    ]);
};