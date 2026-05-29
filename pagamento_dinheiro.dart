import 'pagamento.dart';

// ============================================================
//  CLASSE CONCRETA: pagamento em dinheiro com 10% de desconto
//  Herda de Pagamento e implementa os membros obrigatorios
// ============================================================
class PagamentoDinheiro extends Pagamento {

  static const double _taxaDesconto = 0.10;   // 10%

  @override
  String get nomePagamento => 'Dinheiro (10% de desconto)';

  @override
  double calcularTotal(double valor) {
    double desconto = valor * _taxaDesconto;
    return valor - desconto;
  }
}
