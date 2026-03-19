void main(){
  const String telefone = '(11) 1234-5678';
  const String endereco = 'Rua dos Petshop, 123 - Bairro dos Animais - Cidade dos Bichos';

  String usuario;

  print("Digite seu nome: ");
  usuario = stdin.readLineSync();



  print("\tSeja bem-vindo(a) $usuario a loja Cuidapet! \n\tEm breve teremos um sistema de autoatendimento.");

  print("\nLocalização da loja: \n\t$endereco");
  print("\nTelefone: \n\t$telefone");

  print("Oferecemos e nossa loja produtos e serviços para seu pet. Para venda de produtos, procure o coloborador junior e, para serviços como banho ou tosa, procure a colaboradora Ana. Obrigado e esperamos que tenha uma ótima experiência em nossa loja!");
}

