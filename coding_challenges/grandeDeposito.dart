import 'dart:io';

void main() {
  double valor = double.parse(stdin.readLineSync()!);

  if (valor > 0) {
    //TODO: Imprimir a mensagem de sucesso, formatando o saldo atual (vide Exemplos).
    String valorFormatado = valor.toStringAsFixed(2);
    print("Deposito realizado com sucesso!\n Saldo atual: R\$ $valorFormatado");
  } else if (valor == 0) {
    //TODO: Imprimir a mensagem de valor inválido.
    print("Encerrando o programa...");
    exit(0);
  } else {
    print("Valor invalido! Digite um valor maior que zero.");
  }
}
