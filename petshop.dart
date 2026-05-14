import 'dart:io';

// ============================================================
//  DADOS DA LOJA
// ============================================================
const String telefone = '(11) 1234-5678';
const String endereco = 'Rua dos Petshop, 123 - Bairro dos Animais - Cidade dos Bichos';

// ============================================================
//  ARRAYS DE PRODUTOS (paralelos)
// ============================================================
List<int>    codigosProdutos = [101, 102, 103, 104];
List<String> nomesProdutos   = [
  'Racao Royal Canin Indoor Para Caes Adultos 7,5kg',
  'Racao Royal Canin Sterilised para Gatos Adultos Castrados',
  'Bifinho Keldog para Caes Sabor Carne e Cereais',
  'Fraldas Descartaveis Super Secao para Caes Machos 12un'
];
List<double> precosProdutos  = [290.00, 492.00, 23.92, 38.61];

// ============================================================
//  ARRAYS DE SERVICOS (paralelos)
// ============================================================
List<int>    codigosServicos = [201, 202, 203];
List<String> nomesServicos   = ['Banho e tosa', 'Tosa higienica', 'Hidratacao dos pelos'];
List<double> precosServicos  = [55.99, 12.99, 20.99];

// ============================================================
//  CARRINHO DE COMPRAS (paralelos, maximo 3 itens)
// ============================================================
List<String> carrinhoNomes  = [];
List<double> carrinhoPrecos = [];

// ============================================================
//  CONTROLE DE VENDAS DO DIA
// ============================================================
int    totalVendas    = 0;
double valorTotalDia  = 0.0;

// ============================================================
//  FUNCAO PRINCIPAL
// ============================================================
void main() {
  exibirBoasVindas();

  stdout.write('\nDigite seu nome: ');
  String? nomeCliente = stdin.readLineSync();

  if (nomeCliente == null || nomeCliente.trim().isEmpty) {
    print('Nome invalido. Encerrando...');
    return;
  }

  // acesso restrito para funcionarios
  if (nomeCliente.trim().toLowerCase() == 'cuidapetrestrito') {
    acessoRestrito();
    resumoDoDia();
    return;
  }

  // autoatendimento do cliente
  print('\nSeja bem-vindo(a), $nomeCliente!');

  bool rodando = true;
  while (rodando) {
    exibirMenuPrincipal();
    String? opcao = stdin.readLineSync();

    if (opcao == '1') {
      menuProdutos();
    } else if (opcao == '2') {
      menuServicos();
    } else if (opcao == '3') {
      listarCarrinho();
    } else if (opcao == '4') {
      finalizarCarrinho(nomeCliente);
    } else if (opcao == '0') {
      rodando = false;
    } else {
      print('\nOpcao invalida! Escolha uma opcao do menu.');
    }
  }

  resumoDoDia();
}

// ============================================================
//  FUNCAO: exibe cabecalho de boas-vindas
// ============================================================
void exibirBoasVindas() {
  separador();
  print('    BEM VINDO AO AUTOATENDIMENTO DO CUIDAPET');
  separador();
  print('Localizacao: $endereco');
  print('Telefone: $telefone');
}

// ============================================================
//  FUNCAO: exibe o menu principal
// ============================================================
void exibirMenuPrincipal() {
  print('\n--------------------------------------------------');
  print('              MENU PRINCIPAL');
  print('--------------------------------------------------');
  print('  1 - Ver promocoes');
  print('  2 - Solicitar servico');
  print('  3 - Listar carrinho de compra');
  print('  4 - Finalizar carrinho de compra');
  print('  0 - Sair');
  print('--------------------------------------------------');
  stdout.write('Digite sua opcao desejada: ');
}

// ============================================================
//  FUNCAO: menu de produtos (opcao 1)
// ============================================================
void menuProdutos() {
  bool emProdutos = true;
  while (emProdutos) {
    separador();
    print('                  PROMOCOES');
    separador();
    exibirListaProdutos();
    print('  8 - Adicionar ao carrinho');
    print('  0 - Voltar');
    stdout.write('Digite sua opcao: ');
    String? op = stdin.readLineSync();

    if (op == '0') {
      emProdutos = false;
    } else if (op == '8') {
      stdout.write('Digite o codigo do produto: ');
      String? codStr = stdin.readLineSync();
      adicionarProdutoAoCarrinho(codStr);
    } else {
      print('\nOpcao invalida!');
    }
  }
}

// ============================================================
//  FUNCAO: menu de servicos (opcao 2)
// ============================================================
void menuServicos() {
  bool emServicos = true;
  while (emServicos) {
    separador();
    print('             SERVICOS DISPONIVEIS');
    separador();
    exibirListaServicos();
    print('  8 - Adicionar ao carrinho');
    print('  0 - Voltar');
    stdout.write('Digite sua opcao: ');
    String? op = stdin.readLineSync();

    if (op == '0') {
      emServicos = false;
    } else if (op == '8') {
      stdout.write('Digite o codigo do servico: ');
      String? codStr = stdin.readLineSync();
      adicionarServicoAoCarrinho(codStr);
    } else {
      print('\nOpcao invalida!');
    }
  }
}

// ============================================================
//  FUNCAO: imprime todos os produtos na tela
// ============================================================
void exibirListaProdutos() {
  for (int i = 0; i < nomesProdutos.length; i++) {
    print('Codigo ${codigosProdutos[i]} - ${nomesProdutos[i]}');
    print('   Preco: R\$ ${precosProdutos[i].toStringAsFixed(2)}\n');
  }
}

// ============================================================
//  FUNCAO: imprime todos os servicos na tela
// ============================================================
void exibirListaServicos() {
  for (int i = 0; i < nomesServicos.length; i++) {
    print('Codigo ${codigosServicos[i]} - ${nomesServicos[i]}');
    print('   Preco: R\$ ${precosServicos[i].toStringAsFixed(2)}\n');
  }
}

// ============================================================
//  FUNCAO: adiciona um produto ao carrinho pelo codigo
// ============================================================
void adicionarProdutoAoCarrinho(String? codStr) {
  if (carrinhoNomes.length >= 3) {
    print('\nSeu carrinho ja esta cheio! (maximo 3 itens)');
    return;
  }

  int? codDigitado = int.tryParse(codStr ?? '');
  if (codDigitado == null) {
    print('\nCodigo invalido!');
    return;
  }

  bool achou = false;
  for (int i = 0; i < codigosProdutos.length; i++) {
    if (codigosProdutos[i] == codDigitado) {
      carrinhoNomes.add(nomesProdutos[i]);
      carrinhoPrecos.add(precosProdutos[i]);
      print('\n"${nomesProdutos[i]}" adicionado ao carrinho!');
      print('Itens no carrinho: ${carrinhoNomes.length}/3');
      achou = true;
      break;
    }
  }

  if (!achou) {
    print('\nCodigo nao encontrado!');
  }
}

// ============================================================
//  FUNCAO: adiciona um servico ao carrinho pelo codigo
// ============================================================
void adicionarServicoAoCarrinho(String? codStr) {
  if (carrinhoNomes.length >= 3) {
    print('\nSeu carrinho ja esta cheio! (maximo 3 itens)');
    return;
  }

  int? codDigitado = int.tryParse(codStr ?? '');
  if (codDigitado == null) {
    print('\nCodigo invalido!');
    return;
  }

  bool achou = false;
  for (int i = 0; i < codigosServicos.length; i++) {
    if (codigosServicos[i] == codDigitado) {
      carrinhoNomes.add(nomesServicos[i]);
      carrinhoPrecos.add(precosServicos[i]);
      print('\n"${nomesServicos[i]}" adicionado ao carrinho!');
      print('Itens no carrinho: ${carrinhoNomes.length}/3');
      achou = true;
      break;
    }
  }

  if (!achou) {
    print('\nCodigo nao encontrado!');
  }
}

// ============================================================
//  FUNCAO: lista os itens do carrinho e retorna o total
// ============================================================
double listarCarrinho() {
  separador();
  print('                SEU CARRINHO');
  separador();

  if (carrinhoNomes.isEmpty) {
    print('Seu carrinho esta vazio!');
    return 0.0;
  }

  double total = 0.0;
  for (int i = 0; i < carrinhoNomes.length; i++) {
    print('${i + 1}. ${carrinhoNomes[i]}');
    print('   R\$ ${carrinhoPrecos[i].toStringAsFixed(2)}');
    total += carrinhoPrecos[i];
  }
  separador();
  print('TOTAL: R\$ ${total.toStringAsFixed(2)}');
  return total;
}

// ============================================================
//  FUNCAO: finaliza a compra, aplica desconto e registra venda
// ============================================================
void finalizarCarrinho(String nomeCliente) {
  if (carrinhoNomes.isEmpty) {
    print('\nSeu carrinho esta vazio! Adicione itens antes de finalizar.');
    return;
  }

  double total = listarCarrinho();

  print('\nForma de pagamento:');
  print('  D - Dinheiro (10% de desconto)');
  print('  C - Cartao');
  stdout.write('Digite D ou C: ');
  String? pagamento = stdin.readLineSync()?.toUpperCase();

  if (pagamento == 'D') {
    double desconto    = total * 0.10;
    double totalFinal  = total - desconto;
    print('\nDesconto 10%: -R\$ ${desconto.toStringAsFixed(2)}');
    print('VALOR FINAL: R\$ ${totalFinal.toStringAsFixed(2)}');
    print('\nCompra finalizada! Obrigado, $nomeCliente!');
    totalVendas++;
    valorTotalDia += totalFinal;
    carrinhoNomes.clear();
    carrinhoPrecos.clear();
  } else if (pagamento == 'C') {
    print('\nVALOR FINAL: R\$ ${total.toStringAsFixed(2)}');
    print('\nCompra finalizada! Obrigado, $nomeCliente!');
    totalVendas++;
    valorTotalDia += total;
    carrinhoNomes.clear();
    carrinhoPrecos.clear();
  } else {
    print('\nForma de pagamento invalida! Tente novamente.');
  }
}

// ============================================================
//  FUNCAO: area restrita para funcionarios
// ============================================================
void acessoRestrito() {
  separador();
  print('       AREA RESTRITA - FUNCIONARIOS');
  separador();

  stdout.write('Nome do cliente: ');
  String? nomeClienteFunc = stdin.readLineSync();

  stdout.write('Valor gasto na loja: R\$ ');
  String? valorStr    = stdin.readLineSync();
  double? valorFunc   = double.tryParse(valorStr ?? '');

  if (valorFunc == null || valorFunc <= 0) {
    print('Valor invalido!');
    return;
  }

  print('\nForma de pagamento:');
  print('  D - Dinheiro (10% de desconto)');
  print('  C - Cartao');
  stdout.write('Digite D ou C: ');
  String? pagFunc = stdin.readLineSync()?.toUpperCase();

  separador();
  print('Cliente: $nomeClienteFunc');

  if (pagFunc == 'D') {
    double desconto   = valorFunc * 0.10;
    double totalFinal = valorFunc - desconto;
    print('Desconto 10%: -R\$ ${desconto.toStringAsFixed(2)}');
    print('VALOR FINAL: R\$ ${totalFinal.toStringAsFixed(2)}');
    totalVendas++;
    valorTotalDia += totalFinal;
  } else if (pagFunc == 'C') {
    print('VALOR FINAL: R\$ ${valorFunc.toStringAsFixed(2)}');
    totalVendas++;
    valorTotalDia += valorFunc;
  } else {
    print('Forma de pagamento invalida!');
  }
}

// ============================================================
//  FUNCAO: exibe o resumo de vendas ao encerrar o sistema
// ============================================================
void resumoDoDia() {
  print('\n--------------------------------------------------');
  print('              RESUMO DO DIA');
  print('--------------------------------------------------');
  print('Total de vendas realizadas: $totalVendas');
  print('Valor total arrecadado: R\$ ${valorTotalDia.toStringAsFixed(2)}');
  print('--------------------------------------------------');
  print('Obrigado por usar o Cuidapet! Ate a proxima!');
}

// ============================================================
//  FUNCAO: imprime uma linha separadora
// ============================================================
void separador() {
  print('--------------------------------------------------');
}
