
import 'package:flutter/material.dart';

class SecaoTitulo extends StatelessWidget {
  final String texto;

  const SecaoTitulo(this.texto, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: Colors.grey[300],
      child: Text(
        texto,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
