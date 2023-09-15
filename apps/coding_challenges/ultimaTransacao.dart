import 'dart:io';

void main() {
  final scanner = stdin;

  final entrada = scanner.readLineSync()!;
  final partes = entrada.split(',');

  final transacao =
      Transacao(partes[0], partes[1], partes[2], double.tryParse(partes[3])!);

  transacao.imprimir();
}

class Transacao {
  final String data;
  final String hora;
  final String descricao;
  final double valor;

  Transacao(this.data, this.hora, this.descricao, this.valor);

  void imprimir() {
    print(descricao);
    print(data);
    print(hora);
    print(valor.toStringAsFixed(2));
  }
}
