import 'pessoa.dart';


class Cliente extends Pessoa {

  List<double> historicoCompras = [];

 
  Cliente(String nome) : super(nome);

  
  void registrarCompra(double valor) {
    historicoCompras.add(valor);
  }

  
  double get totalGasto {
    double total = 0.0;
    for (double compra in historicoCompras) {
      total += compra;
    }
    return total;
  }

  
  int get quantidadeCompras => historicoCompras.length;

  
  @override
  String apresentar() {
    return 'Cliente: $nome';
  }
}
