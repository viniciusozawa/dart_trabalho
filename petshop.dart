import 'dart:io';
void main(){
  const String telefone = '(11) 1234-5678';
  const String endereco = 'Rua dos Petshop, 123 - Bairro dos Animais - Cidade dos Bichos';

  String? usuario;

  print("Digite seu nome: ");
  usuario = stdin.readLineSync();



  print("\n\n\tSeja bem-vindo(a) $usuario a loja Cuidapet!");

  print("\nLocalização da loja: \n\t$endereco");
  print("\nTelefone: \n\t$telefone");
  print("\n\n\t1 - Ver ofertas de Produtos  \n\t2 - Ver ofertas de Serviços.\n\nDigite o número da opção desejada: ");
  String? opcao = stdin.readLineSync();

  switch (opcao) {
    case '1':
      print("Ração Royal Canin Indor 7,5kg com o valor promocional de R\$280,00");
      break;
    case '2':
      print("Banho e tosa na promoção pelo preço do banho R\$ 54,00");
      break;
    default:
      print("\nOpção inválida. Por favor, escolha 1 ou 2.");
  }

  print("\n\nOferecemos e nossa loja produtos e serviços para seu pet. Para venda de produtos, procure o coloborador junior e, para serviços como banho ou tosa, procure a colaboradora Ana. Obrigado e esperamos que tenha uma ótima experiência em nossa loja!");

}

