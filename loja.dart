
class Loja {

  
  final String nome;
  final String telefone;
  final String endereco;

  int    _totalVendas   = 0;
  double _valorTotalDia = 0.0;

  Loja({
    required this.nome,
    required this.telefone,
    required this.endereco,
  });

  int    get totalVendas   => _totalVendas;
  double get valorTotalDia => _valorTotalDia;

  
  void registrarVenda(double valor) {
    _totalVendas++;
    _valorTotalDia += valor;
  }

  void exibirBoasVindas() {
    print('--------------------------------------------------');
    print('    BEM VINDO AO AUTOATENDIMENTO DO CUIDAPET');
    print('--------------------------------------------------');
    print('Localizacao: $endereco');
    print('Telefone: $telefone');
  }

  
  void exibirResumo() {
    print('\n--------------------------------------------------');
    print('              RESUMO DO DIA');
    print('--------------------------------------------------');
    print('Total de vendas realizadas: $_totalVendas');
    print('Valor total arrecadado: R\$ ${_valorTotalDia.toStringAsFixed(2)}');
    print('--------------------------------------------------');
    print('Obrigado por usar o $nome! Ate a proxima!');
  }
}
