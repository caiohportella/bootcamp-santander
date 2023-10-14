import 'dart:io';

void main() {
  // Entrada de dados
  int saldoTotal = int.parse(stdin.readLineSync()!);
  int valorSaque = int.parse(stdin.readLineSync()!);
  int saldoDisponivel = 0;

  //TODO: Criar as condições necessárias para impressão da saída, vide tabela de exemplos.
  if (saldoTotal >= valorSaque) {
    saldoDisponivel = saldoTotal - valorSaque;
    print('Saque realizado com sucesso. Novo saldo: $saldoDisponivel');
  } else {
    print('Saldo insuficiente. Saque nao realizado!');
  }
}
