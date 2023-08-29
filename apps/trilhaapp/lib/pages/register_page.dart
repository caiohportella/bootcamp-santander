import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final String text;
  final List<String> data;
  const RegisterPage({Key? key, required this.text, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(title: Text(text)),
          body: Center(child: Text(data.length.toString()))),
    );
  }
}
