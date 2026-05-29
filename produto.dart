import 'item.dart';


class Produto extends Item {

  Produto(int codigo, String nome, double preco)
      : super(codigo, nome, preco);

 
 
  @override
  void exibir() {
    print('Codigo $codigo - $nome');
    print('   Preco: R\$ ${preco.toStringAsFixed(2)}\n');
  }
}
