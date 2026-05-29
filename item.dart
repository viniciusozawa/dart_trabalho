
abstract class Exibivel {
  void exibir();
}


abstract class Item implements Exibivel {
  final int    codigo;
  final String nome;
  final double preco;

  
  Item(this.codigo, this.nome, this.preco);
}
