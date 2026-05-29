import 'item.dart';


class Servico extends Item {

 
  Servico(int codigo, String nome, double preco)
      : super(codigo, nome, preco);


  @override
  void exibir() {
    print('Codigo $codigo - $nome');
    print('   Preco: R\$ ${preco.toStringAsFixed(2)}\n');
  }
}
