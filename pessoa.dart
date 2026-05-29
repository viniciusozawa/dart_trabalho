
abstract class Pessoa {

  String nome;

  
  Pessoa(this.nome);

  
  String apresentar();

  @override
  String toString() => apresentar();
}
