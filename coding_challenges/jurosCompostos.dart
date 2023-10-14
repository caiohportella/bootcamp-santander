import 'dart:io';

void main() {
  var valorInicial = double.parse(stdin.readLineSync()!);
  var taxaJuros = double.parse(stdin.readLineSync()!);
  var periodo = int.parse(stdin.readLineSync()!);

  var valorFinal = valorInicial;

  //TODO: Iterar, baseado no período em anos, para calculo do valorFinal com os juros.
  double valorInvestimento(double valorInicial, double taxaJuros, int periodo) {
    var valorFinal = valorInicial;
    for (var i = 0; i < periodo; i++) {
      valorFinal += valorFinal * taxaJuros;
    }
  return double.parse(valorFinal.toStringAsFixed(2));
}

  valorFinal = valorInvestimento(valorInicial, taxaJuros, periodo);

  print("Valor final do investimento: R\$ $valorFinal");
}
