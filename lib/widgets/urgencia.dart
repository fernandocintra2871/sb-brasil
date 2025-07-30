import 'package:app_odonto/widgets/section_bar.dart';
import 'package:flutter/material.dart';
import '../listas.dart';
import '../models/questionario.dart';

class DropdownUrgenciaSection extends StatelessWidget {
  final Questionario questionario;
  final void Function()? onChanged;

  const DropdownUrgenciaSection({
    super.key,
    required this.questionario,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título fora do Padding
        SecaoTitulo('URGÊNCIA'),

        // Campo com padding
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Urgência'),
            isExpanded: true,
            value: questionario.urgencia,
            items: listaUrgencia
                .map((urg) => DropdownMenuItem(
                      value: urg,
                      child: Text(
                        urg,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            validator: (value) =>
                value == null ? 'Selecione uma urgência' : null,
            onChanged: (value) {
              questionario.urgencia = value;
              if (onChanged != null) onChanged!();
            },
          ),
        ),
      ],
    );
  }

}
