import 'item.dart';
import 'produto.dart';
import 'servico.dart';


class Catalogo {

  
  final List<Produto> produtos = [
    Produto(101, 'Racao Royal Canin Indoor Para Caes Adultos 7,5kg', 290.00),
    Produto(102, 'Racao Royal Canin Sterilised para Gatos Adultos Castrados', 492.00),
    Produto(103, 'Bifinho Keldog para Caes Sabor Carne e Cereais', 23.92),
    Produto(104, 'Fraldas Descartaveis Super Secao para Caes Machos 12un', 38.61),
  ];

  final List<Servico> servicos = [
    Servico(201, 'Banho e tosa', 55.99),
    Servico(202, 'Tosa higienica', 12.99),
    Servico(203, 'Hidratacao dos pelos', 20.99),
  ];

  
  Item? buscarProduto(int codigo) {
    for (var p in produtos) {
      if (p.codigo == codigo) return p;
    }
    return null;
  }

  Item? buscarServico(int codigo) {
    for (var s in servicos) {
      if (s.codigo == codigo) return s;
    }
    return null;
  }
}
