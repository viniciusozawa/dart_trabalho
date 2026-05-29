import 'pagamento.dart';


class PagamentoCartao extends Pagamento {

  @override
  String get nomePagamento => 'Cartao';

  @override
  double calcularTotal(double valor) {
    return valor;   
  }
}
