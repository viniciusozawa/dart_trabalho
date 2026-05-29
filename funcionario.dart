import 'pessoa.dart';


class Funcionario extends Pessoa {

  String cargo;

  // atributo privado — so a classe conhece
  final String _senha;   

  
  Funcionario(String nome, this.cargo, String senha)
      : _senha = senha,
        super(nome);

  
  bool validarSenha(String tentativa) {
    return tentativa == _senha;
  }

  
  @override
  String apresentar() {
    return 'Funcionario: $nome | Cargo: $cargo';
  }
}
