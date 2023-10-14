import 'dart:io';

class Bancaria {
  int numeroConta;
  String nomeTitular;
  double saldo;

  Bancaria(this.numeroConta, this.nomeTitular, this.saldo);

  int getNumeroConta() {
    return numeroConta;
  }

  String getNomeTitular() {
    return nomeTitular;
  }

  double getSaldo() {
    return saldo;
  }
}

void main() {
  int numeroConta = int.parse(stdin.readLineSync()!);
  String nomeTitular = stdin.readLineSync()!;
  double saldo = double.parse(stdin.readLineSync()!);

  Bancaria conta = Bancaria(numeroConta, nomeTitular, saldo);

  print("Informacoes:\n");
  print("Conta: ${conta.getNumeroConta()}\n");
  print("Titular: ${conta.getNomeTitular()}\n");
  print("Saldo: R\$ ${conta.getSaldo()}\n");
}