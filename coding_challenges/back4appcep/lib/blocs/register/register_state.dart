class RegisterCEPState extends RegisterState {
  final String cep;
  final String logradouro;
  final String bairro;
  final String cidade;
  final String estado;

  RegisterCEPState({
    this.cep,
    this.logradouro,
    this.bairro,
    this.cidade,
    this.estado,
  });

  @override
  List<Object> get props => [
        cep,
        logradouro,
        bairro,
        cidade,
        estado,
      ];

  @override
  String toString() => 'RegisterCEPState';
}