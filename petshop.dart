import 'dart:io';

void main() {
  // ---- DADOS DA LOJA ----
  const String telefone = '(11) 1234-5678';
  const String endereco = 'Rua dos Petshop, 123 - Bairro dos Animais - Cidade dos Bichos';

  // ---- PRODUTOS (arrays paralelos) ----
  List<int> codigosProdutos    = [101,   102,    103,    104];
  List<String> nomesProdutos   = [
    'Racao Royal Canin Indoor Para Caes Adultos 7,5kg',
    'Racao Royal Canin Sterilised para Gatos Adultos Castrados',
    'Bifinho Keldog para Caes Sabor Carne e Cereais',
    'Fraldas Descartaveis Super Secao para Caes Machos 12un'
  ];
  List<double> precosProdutos  = [290.00, 492.00, 23.92, 38.61];

  // ---- SERVICOS (arrays paralelos) ----
  List<int> codigosServicos    = [201,        202,             203];
  List<String> nomesServicos   = ['Banho e tosa', 'Tosa higienica', 'Hidratacao dos pelos'];
  List<double> precosServicos  = [55.99,       12.99,           20.99];

  // ---- CARRINHO (arrays paralelos, maximo 3 itens) ----
  List<String> carrinhoNomes  = [];
  List<double> carrinhoPrecos = [];

  // ---- CONTROLE DE VENDAS DO DIA ----
  int totalVendas      = 0;
  double valorTotalDia = 0.0;

  // ---- TELA INICIAL ----
  print('--------------------------------------------------');
  print('    BEM VINDO AO AUTOATENDIMENTO DO CUIDAPET');
  print('--------------------------------------------------');
  print('Localizacao: $endereco');
  print('Telefone: $telefone');

  stdout.write('\nDigite seu nome: ');
  String? nomeCliente = stdin.readLineSync();

  if (nomeCliente == null || nomeCliente.trim().isEmpty) {
    print('Nome invalido. Encerrando...');
    return;
  }

  // ---- ACESSO RESTRITO ----
  if (nomeCliente.trim().toLowerCase() == 'cuidapetrestrito') {
    print('\n--------------------------------------------------');
    print('       AREA RESTRITA - FUNCIONARIOS');
    print('--------------------------------------------------');

    stdout.write('Nome do cliente: ');
    String? nomeClienteFunc = stdin.readLineSync();

    stdout.write('Valor gasto na loja: R\$ ');
    String? valorStr = stdin.readLineSync();
    double? valorFunc = double.tryParse(valorStr ?? '');

    if (valorFunc == null || valorFunc <= 0) {
      print('Valor invalido!');
    } else {
      print('\nForma de pagamento:');
      print('  D - Dinheiro (10% de desconto)');
      print('  C - Cartao');
      stdout.write('Digite D ou C: ');
      String? pagFunc = stdin.readLineSync()?.toUpperCase();

      if (pagFunc == 'D') {
        double desconto   = valorFunc * 0.10;
        double totalFinal = valorFunc - desconto;
        print('\nCliente: $nomeClienteFunc');
        print('Desconto 10%: -R\$ ${desconto.toStringAsFixed(2)}');
        print('VALOR FINAL: R\$ ${totalFinal.toStringAsFixed(2)}');
        totalVendas++;
        valorTotalDia += totalFinal;
      } else if (pagFunc == 'C') {
        print('\nCliente: $nomeClienteFunc');
        print('VALOR FINAL: R\$ ${valorFunc.toStringAsFixed(2)}');
        totalVendas++;
        valorTotalDia += valorFunc;
      } else {
        print('Forma de pagamento invalida!');
      }
    }

    // resumo do dia e encerra
    print('\n--------------------------------------------------');
    print('Total de vendas do dia: $totalVendas');
    print('Valor total do dia: R\$ ${valorTotalDia.toStringAsFixed(2)}');
    print('--------------------------------------------------');
    return;
  }

  // ---- AUTOATENDIMENTO ----
  print('\nSeja bem-vindo(a), $nomeCliente!');

  bool rodando = true;
  while (rodando) {

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
    String? opcao = stdin.readLineSync();

    // ---- OPCAO 1: PROMOCOES ----
    if (opcao == '1') {
      bool emPromocoes = true;
      while (emPromocoes) {
        print('\n--------------------------------------------------');
        print('                  PROMOCOES');
        print('--------------------------------------------------');
        for (int i = 0; i < nomesProdutos.length; i++) {
          print('Codigo ${codigosProdutos[i]} - ${nomesProdutos[i]}');
          print('   Preco: R\$ ${precosProdutos[i].toStringAsFixed(2)}\n');
        }
        print('  8 - Adicionar ao carrinho');
        print('  0 - Voltar');
        stdout.write('Digite sua opcao: ');
        String? opProd = stdin.readLineSync();

        if (opProd == '0') {
          emPromocoes = false;

        } else if (opProd == '8') {
          if (carrinhoNomes.length >= 3) {
            print('\nSeu carrinho de compras ja esta cheio! (maximo 3 itens)');
          } else {
            stdout.write('Digite o codigo do produto: ');
            String? codStr = stdin.readLineSync();
            int? codDigitado = int.tryParse(codStr ?? '');

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
        } else {
          print('\nOpcao invalida!');
        }
      }

    // ---- OPCAO 2: SERVICOS ----
    } else if (opcao == '2') {
      bool emServicos = true;
      while (emServicos) {
        print('\n--------------------------------------------------');
        print('             SERVICOS DISPONIVEIS');
        print('--------------------------------------------------');
        for (int i = 0; i < nomesServicos.length; i++) {
          print('Codigo ${codigosServicos[i]} - ${nomesServicos[i]}');
          print('   Preco: R\$ ${precosServicos[i].toStringAsFixed(2)}\n');
        }
        print('  8 - Adicionar ao carrinho');
        print('  0 - Voltar');
        stdout.write('Digite sua opcao: ');
        String? opServ = stdin.readLineSync();

        if (opServ == '0') {
          emServicos = false;

        } else if (opServ == '8') {
          if (carrinhoNomes.length >= 3) {
            print('\nSeu carrinho de compras ja esta cheio! (maximo 3 itens)');
          } else {
            stdout.write('Digite o codigo do servico: ');
            String? codStr = stdin.readLineSync();
            int? codDigitado = int.tryParse(codStr ?? '');

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
        } else {
          print('\nOpcao invalida!');
        }
      }

    // ---- OPCAO 3: LISTAR CARRINHO ----
    } else if (opcao == '3') {
      print('\n--------------------------------------------------');
      print('                SEU CARRINHO');
      print('--------------------------------------------------');
      if (carrinhoNomes.isEmpty) {
        print('Seu carrinho esta vazio!');
      } else {
        double totalCarrinho = 0;
        for (int i = 0; i < carrinhoNomes.length; i++) {
          print('${i + 1}. ${carrinhoNomes[i]}');
          print('   R\$ ${carrinhoPrecos[i].toStringAsFixed(2)}');
          totalCarrinho += carrinhoPrecos[i];
        }
        print('--------------------------------------------------');
        print('TOTAL: R\$ ${totalCarrinho.toStringAsFixed(2)}');
      }

    // ---- OPCAO 4: FINALIZAR ----
    } else if (opcao == '4') {
      if (carrinhoNomes.isEmpty) {
        print('\nSeu carrinho esta vazio! Adicione itens antes de finalizar.');
      } else {
        // mostra carrinho
        print('\n--------------------------------------------------');
        print('                SEU CARRINHO');
        print('--------------------------------------------------');
        double totalFinal = 0;
        for (int i = 0; i < carrinhoNomes.length; i++) {
          print('${i + 1}. ${carrinhoNomes[i]}');
          print('   R\$ ${carrinhoPrecos[i].toStringAsFixed(2)}');
          totalFinal += carrinhoPrecos[i];
        }
        print('--------------------------------------------------');
        print('TOTAL: R\$ ${totalFinal.toStringAsFixed(2)}');

        // pagamento
        print('\nForma de pagamento:');
        print('  D - Dinheiro (10% de desconto)');
        print('  C - Cartao');
        stdout.write('Digite D ou C: ');
        String? pagamento = stdin.readLineSync()?.toUpperCase();

        if (pagamento == 'D') {
          double desconto  = totalFinal * 0.10;
          totalFinal       = totalFinal - desconto;
          print('\nDesconto 10%: -R\$ ${desconto.toStringAsFixed(2)}');
          print('VALOR FINAL: R\$ ${totalFinal.toStringAsFixed(2)}');
          print('\nCompra finalizada! Obrigado, $nomeCliente!');
          totalVendas++;
          valorTotalDia += totalFinal;
          carrinhoNomes.clear();
          carrinhoPrecos.clear();
        } else if (pagamento == 'C') {
          print('\nVALOR FINAL: R\$ ${totalFinal.toStringAsFixed(2)}');
          print('\nCompra finalizada! Obrigado, $nomeCliente!');
          totalVendas++;
          valorTotalDia += totalFinal;
          carrinhoNomes.clear();
          carrinhoPrecos.clear();
        } else {
          print('\nForma de pagamento invalida! Tente novamente.');
        }
      }

    // ---- OPCAO 0: SAIR ----
    } else if (opcao == '0') {
      rodando = false;

    } else {
      print('\nOpcao invalida! Escolha uma opcao do menu.');
    }
  }

  // ---- RESUMO DO DIA ----
  print('\n--------------------------------------------------');
  print('              RESUMO DO DIA');
  print('--------------------------------------------------');
  print('Total de vendas realizadas: $totalVendas');
  print('Valor total arrecadado: R\$ ${valorTotalDia.toStringAsFixed(2)}');
  print('--------------------------------------------------');
  print('Obrigado por usar o Cuidapet! Ate a proxima!');
}
