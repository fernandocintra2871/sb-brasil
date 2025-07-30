import 'package:app_odonto/widgets/section_bar.dart';
import 'package:app_odonto/widgets/sub_section.dart';
import 'package:flutter/material.dart';
import '../listas.dart';
import '../models/questionario.dart'; // ajuste o path conforme necessário

class CondicaoOclusaoDentariaSection extends StatelessWidget {
  final Questionario questionario;
  final void Function()? onChanged;

  const CondicaoOclusaoDentariaSection({
    super.key,
    required this.questionario,
    this.onChanged,
  });

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> itens,
    required void Function(String?) onChangedLocal,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
      value: value,
      isExpanded: true,
      items: itens
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  style: const TextStyle(fontSize: 14),
                ),
              ))
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
        // Título e subtítulo fora do Padding
        SecaoTitulo('CONDIÇÃO DA OCLUSÃO DENTÁRIA'),
        SubSecaoTitulo('Foster Humilton (1969)'),

        // Parte com padding
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chave de caninos
              _buildDropdown(
                label: 'Chave de caninos',
                value: questionario.chaveCaninos,
                itens: listaChaveCaninos,
                onChangedLocal: (val) => questionario.chaveCaninos = val,
              ),
              const SizedBox(height: 16),

              // Sobressaliência
              _buildDropdown(
                label: 'Sobressaliência',
                value: questionario.sobressaliencia,
                itens: listaSobressaliencia,
                onChangedLocal: (val) => questionario.sobressaliencia = val,
              ),
              const SizedBox(height: 16),

              // Sobremordida
              _buildDropdown(
                label: 'Sobremordida',
                value: questionario.sobremordida,
                itens: listaSobremordida,
                onChangedLocal: (val) => questionario.sobremordida = val,
              ),
              const SizedBox(height: 16),

              // Mordida cruzada posterior
              _buildDropdown(
                label: 'Mordida cruzada posterior',
                value: questionario.mordidaCruzadaPosterior,
                itens: listaMordidaCruzadaPosterior,
                onChangedLocal: (val) => questionario.mordidaCruzadaPosterior = val,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }

}
