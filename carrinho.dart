import 'item.dart';

class Carrinho {

  static const int maxItens = 3;   

  //atributo privado: lista de itens no carrinho
  final List<Item> _itens = [];   

  
  bool get cheio      => _itens.length >= maxItens;
  bool get vazio      => _itens.isEmpty;
  int  get quantidade => _itens.length;

  
  bool adicionar(Item item) {
    if (cheio) {
      print('\nSeu carrinho ja esta cheio! (maximo $maxItens itens)');
      return false;
    }
    _itens.add(item);
    print('\n"${item.nome}" adicionado ao carrinho!');
    print('Itens no carrinho: ${_itens.length}/$maxItens');
    return true;
  }

  
  double calcularTotal() {
    double total = 0.0;
    for (var item in _itens) {
      total += item.preco;
    }
    return total;
  }

  
  void listar() {
    _separador();
    print('                SEU CARRINHO');
    _separador();
    if (vazio) {
      print('Seu carrinho esta vazio!');
      return;
    }
    for (int i = 0; i < _itens.length; i++) {
      print('${i + 1}. ${_itens[i].nome}');
      print('   R\$ ${_itens[i].preco.toStringAsFixed(2)}');
    }
    _separador();
    print('TOTAL: R\$ ${calcularTotal().toStringAsFixed(2)}');
  }

  
  void limpar() {
    _itens.clear();
  }

  
  void _separador(){ 
    print('--------------------------------------------------'); 
  }
}
