import 'dart:io';
void main(){
  const String telefone = '(11) 1234-5678';
  const String endereco = 'Rua dos Petshop, 123 - Bairro dos Animais - Cidade dos Bichos';

  String? usuario;

  stdout.write("Digite seu nome: ");
  usuario = stdin.readLineSync();



  print("\n\n\tSeja bem-vindo(a) $usuario a loja Cuidapet!");

  print("\nLocalização da loja: \n\t$endereco");
  print("\nTelefone: \n\t$telefone");
  stdout.write("\n\n\t1 - Ver ofertas de Produtos  \n\t2 - Ver ofertas de Serviços. \n\t3 - Ver ofertas de roupas \n\t4 - Ver novos serviços.\n\nDigite o número da opção desejada: ");
  String? opcao = stdin.readLineSync();

  switch (opcao) {
    case '1':
      print("Ração Royal Canin Indor 7,5kg com o valor promocional de R\$280,00");
      break;
    case '2':
      print("Banho e tosa na promoção pelo preço do banho R\$ 54,00");
      break;
    case '3':
      print("Roupas em oferta - Capa de chuva R\$59,99");
      break;
    case '4':
      print("\n\n\t| Hidratação de pelo R\$ 39,99 \n\t| Tosa higiênica por R\$ 10,99 \n\t| Tingimento dos pelo por R\$ 55,99.");
      break;

    default:
      print("\nOpção inválida. Por favor, escolha 1, 2, 3 ou 4.");
  }

  print("\n\nOferecemos e nossa loja produtos e serviços para seu pet. Para venda de produtos, procure o coloborador junior e, para serviços como banho ou tosa, procure a colaboradora Ana. Obrigado e esperamos que tenha uma ótima experiência em nossa loja!");

}

