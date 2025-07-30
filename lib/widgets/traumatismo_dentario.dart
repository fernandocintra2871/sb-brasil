import 'package:app_odonto/widgets/section_bar.dart';
import 'package:flutter/material.dart';
import '../listas.dart';
import '../models/questionario.dart'; // ajuste o caminho se necessário

class TraumatismoDentarioSection extends StatelessWidget {
  final Questionario questionario;
  final void Function()? onChanged;

  const TraumatismoDentarioSection({
    super.key,
    required this.questionario,
    this.onChanged,
  });

  Widget _buildDropdown(String label, String? value, void Function(String?) onChangedLocal) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
      value: value,
      isExpanded: true, // <---- ESSENCIAL
      items: listaTrauDentario
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                softWrap: true,
                overflow: TextOverflow.visible,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          )
          .toList(),
      validator: (val) => val == null ? 'Campo obrigatório' : null,
      onChanged: (val) {
        onChangedLocal(val);
        onChanged?.call();
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título fora do Padding
        SecaoTitulo('TRAUMATISMO DENTÁRIO'),

        // Conteúdo com padding
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdown('12', questionario.trauDentario12, (val) => questionario.trauDentario12 = val),
              const SizedBox(height: 16),
              _buildDropdown('11', questionario.trauDentario11, (val) => questionario.trauDentario11 = val),
              const SizedBox(height: 16),
              _buildDropdown('21', questionario.trauDentario21, (val) => questionario.trauDentario21 = val),
              const SizedBox(height: 16),
              _buildDropdown('22', questionario.trauDentario22, (val) => questionario.trauDentario22 = val),
              const SizedBox(height: 16),
              _buildDropdown('32', questionario.trauDentario32, (val) => questionario.trauDentario32 = val),
              const SizedBox(height: 16),
              _buildDropdown('31', questionario.trauDentario31, (val) => questionario.trauDentario31 = val),
              const SizedBox(height: 16),
              _buildDropdown('41', questionario.trauDentario41, (val) => questionario.trauDentario41 = val),
              const SizedBox(height: 16),
              _buildDropdown('42', questionario.trauDentario42, (val) => questionario.trauDentario42 = val),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }

}
