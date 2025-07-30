import 'package:app_odonto/widgets/section_bar.dart';
import 'package:flutter/material.dart';
import '../listas.dart';
import '../models/questionario.dart'; // ajuste o caminho conforme sua estrutura

class UsoNecessidadeProteseSection extends StatelessWidget {
  final Questionario questionario;
  final void Function()? onChanged;

  const UsoNecessidadeProteseSection({
    super.key,
    required this.questionario,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título fora do padding
        SecaoTitulo('USO E NECESSIDADE DE PRÓTESES'),

        // Conteúdo com padding
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Uso de prótese superior
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Uso prótese superior'),
                value: questionario.usoProteseSup,
                items: listaUsoProtese
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                validator: (value) => value == null ? 'Campo obrigatório' : null,
                onChanged: (value) {
                  questionario.usoProteseSup = value;
                  onChanged?.call();
                },
              ),
              const SizedBox(height: 16),

              // Uso de prótese inferior
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Uso prótese inferior'),
                value: questionario.usoProteseInf,
                items: listaUsoProtese
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                validator: (value) => value == null ? 'Campo obrigatório' : null,
                onChanged: (value) {
                  questionario.usoProteseInf = value;
                  onChanged?.call();
                },
              ),
              const SizedBox(height: 24),

              // Necessidade de prótese superior
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Necessidade prótese superior'),
                value: questionario.necProteseSup,
                items: listaNecProtese
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                validator: (value) => value == null ? 'Campo obrigatório' : null,
                onChanged: (value) {
                  questionario.necProteseSup = value;
                  onChanged?.call();
                },
              ),
              const SizedBox(height: 16),

              // Necessidade de prótese inferior
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Necessidade prótese inferior'),
                value: questionario.necProteseInf,
                items: listaNecProtese
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                validator: (value) => value == null ? 'Campo obrigatório' : null,
                onChanged: (value) {
                  questionario.necProteseInf = value;
                  onChanged?.call();
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }

}
