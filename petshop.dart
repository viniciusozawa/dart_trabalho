import 'dart:io';

import 'loja.dart';
import 'catalogo.dart';
import 'carrinho.dart';
import 'item.dart';
import 'pagamento.dart';
import 'pagamento_dinheiro.dart';
import 'pagamento_cartao.dart';
import 'cliente.dart';
import 'funcionario.dart';


void main() {

  
  Loja loja = Loja(
    nome:     'Cuidapet',
    telefone: '(11) 1234-5678',
    endereco: 'Rua dos Petshop, 123 - Bairro dos Animais - Cidade dos Bichos',
  );


  Catalogo catalogo = Catalogo();

  
  Funcionario funcionario = Funcionario('Pedro', 'Atendente', 'cuidapetrestrito');

  loja.exibirBoasVindas();

  stdout.write('\nDigite seu nome: ');
  String? entrada = stdin.readLineSync();

  if (entrada == null || entrada.trim().isEmpty) {
    print('Entrada invalida. Encerrando...');
    return;
  }

  
  if (funcionario.validarSenha(entrada.trim().toLowerCase())) {
    print('\n--------------------------------------------------');
    print('       AREA RESTRITA - FUNCIONARIOS');
    print('--------------------------------------------------');
    print(funcionario.apresentar());   

    acessoRestrito(funcionario, loja);
    loja.exibirResumo();
    return;
  }

  
  Cliente cliente = Cliente(entrada.trim());
  Carrinho carrinho = Carrinho();

  print('\nSeja bem-vindo(a), ${cliente.nome}!');
  print(cliente.apresentar());  

  bool rodando = true;
  while (rodando) {
    exibirMenuPrincipal();
    String? opcao = stdin.readLineSync();

    if (opcao == '1') {
      menuProdutos(catalogo, carrinho);
    } else if (opcao == '2') {
      menuServicos(catalogo, carrinho);
    } else if (opcao == '3') {
      carrinho.listar();
    } else if (opcao == '4') {
      finalizarCarrinho(carrinho, loja, cliente);
    } else if (opcao == '0') {
      rodando = false;
    } else {
      print('\nOpcao invalida! Escolha uma opcao do menu.');
    }
  }

  
  exibirDespedidaCliente(cliente);
  loja.exibirResumo();
}

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


void menuProdutos(Catalogo catalogo, Carrinho carrinho) {
  bool emProdutos = true;
  while (emProdutos) {
    print('\n--------------------------------------------------');
    print('                  PROMOCOES');
    print('--------------------------------------------------');
    for (var p in catalogo.produtos) {
      p.exibir();   
    }
    print('  8 - Adicionar ao carrinho');
    print('  0 - Voltar');
    stdout.write('Digite sua opcao: ');
    String? op = stdin.readLineSync();

    if (op == '0') {
      emProdutos = false;
    } else if (op == '8') {
      stdout.write('Digite o codigo do produto: ');
      String? codStr = stdin.readLineSync();
      int? cod = int.tryParse(codStr ?? '');
      if (cod == null) {
        print('\nCodigo invalido!');
      } else {
        Item? item = catalogo.buscarProduto(cod);
        if (item == null) {
          print('\nCodigo nao encontrado!');
        } else {
          carrinho.adicionar(item);
        }
      }
    } else {
      print('\nOpcao invalida!');
    }
  }
}


void menuServicos(Catalogo catalogo, Carrinho carrinho) {
  bool emServicos = true;
  while (emServicos) {
    print('\n--------------------------------------------------');
    print('             SERVICOS DISPONIVEIS');
    print('--------------------------------------------------');
    for (var s in catalogo.servicos) {
      s.exibir();   
    }
    print('  8 - Adicionar ao carrinho');
    print('  0 - Voltar');
    stdout.write('Digite sua opcao: ');
    String? op = stdin.readLineSync();

    if (op == '0') {
      emServicos = false;
    } else if (op == '8') {
      stdout.write('Digite o codigo do servico: ');
      String? codStr = stdin.readLineSync();
      int? cod = int.tryParse(codStr ?? '');
      if (cod == null) {
        print('\nCodigo invalido!');
      } else {
        Item? item = catalogo.buscarServico(cod);
        if (item == null) {
          print('\nCodigo nao encontrado!');
        } else {
          carrinho.adicionar(item);
        }
      }
    } else {
      print('\nOpcao invalida!');
    }
  }
}


void finalizarCarrinho(Carrinho carrinho, Loja loja, Cliente cliente) {
  if (carrinho.vazio) {
    print('\nSeu carrinho esta vazio! Adicione itens antes de finalizar.');
    return;
  }

  carrinho.listar();

  print('\nForma de pagamento:');
  print('  D - Dinheiro (10% de desconto)');
  print('  C - Cartao');
  stdout.write('Digite D ou C: ');
  String? pag = stdin.readLineSync()?.toUpperCase();

  // POLIMORFISMO de Pagamento
  Pagamento? pagamento;
  if (pag == 'D') {
    pagamento = PagamentoDinheiro();
  } else if (pag == 'C') {
    pagamento = PagamentoCartao();
  } else {
    print('\nForma de pagamento invalida!');
    return;
  }

  double total      = carrinho.calcularTotal();
  double totalFinal = pagamento.calcularTotal(total);
  double desconto   = total - totalFinal;

  if (desconto > 0) {
    print('\nDesconto 10%: -R\$ ${desconto.toStringAsFixed(2)}');
  }
  print('VALOR FINAL: R\$ ${totalFinal.toStringAsFixed(2)}');
  print('\nCompra finalizada! Obrigado, ${cliente.nome}!');

 
  cliente.registrarCompra(totalFinal);
  loja.registrarVenda(totalFinal);
  carrinho.limpar();
}


void acessoRestrito(Funcionario funcionario, Loja loja) {
  stdout.write('\nNome do cliente: ');
  String? nomeClienteFunc = stdin.readLineSync();

  stdout.write('Valor gasto na loja: R\$ ');
  String? valorStr = stdin.readLineSync();
  double? valor    = double.tryParse(valorStr ?? '');

  if (valor == null || valor <= 0) {
    print('Valor invalido!');
    return;
  }

  print('\nForma de pagamento:');
  print('  D - Dinheiro (10% de desconto)');
  print('  C - Cartao');
  stdout.write('Digite D ou C: ');
  String? pag = stdin.readLineSync()?.toUpperCase();

  Pagamento? pagamento;
  if (pag == 'D') {
    pagamento = PagamentoDinheiro();
  } else if (pag == 'C') {
    pagamento = PagamentoCartao();
  } else {
    print('Forma de pagamento invalida!');
    return;
  }

  double totalFinal = pagamento.calcularTotal(valor);
  double desconto   = valor - totalFinal;

  print('\nAtendido por: ${funcionario.apresentar()}');
  print('Cliente: $nomeClienteFunc');
  if (desconto > 0) {
    print('Desconto 10%: -R\$ ${desconto.toStringAsFixed(2)}');
  }
  print('VALOR FINAL: R\$ ${totalFinal.toStringAsFixed(2)}');

  loja.registrarVenda(totalFinal);
}


void exibirDespedidaCliente(Cliente cliente) {
  print('\n--------------------------------------------------');
  print('         OBRIGADO PELA VISITA, ${cliente.nome.toUpperCase()}!');
  print('--------------------------------------------------');
  if (cliente.quantidadeCompras == 0) {
    print('Voce nao realizou compras hoje.');
  } else {
    print('Compras realizadas nesta visita: ${cliente.quantidadeCompras}');
    for (int i = 0; i < cliente.historicoCompras.length; i++) {
      print('  Compra ${i + 1}: R\$ ${cliente.historicoCompras[i].toStringAsFixed(2)}');
    }
    print('Total gasto: R\$ ${cliente.totalGasto.toStringAsFixed(2)}');
  }
  print('--------------------------------------------------');
}
