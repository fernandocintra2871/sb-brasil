import 'package:flutter/material.dart';

class SubSecaoTitulo extends StatelessWidget {
  final String texto;

  const SubSecaoTitulo(this.texto, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Text(
        texto,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
