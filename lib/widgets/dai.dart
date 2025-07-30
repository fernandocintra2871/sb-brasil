import 'package:app_odonto/widgets/section_bar.dart';
import 'package:flutter/material.dart';
import '../listas.dart';
import '../models/questionario.dart';

class DAISection extends StatelessWidget {
  final Questionario questionario;
  final void Function()? onChanged;

  const DAISection({
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
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                overflow: TextOverflow.visible,
                softWrap: true,
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

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
    child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SecaoTitulo('CONDIÇÃO DA OCLUSÃO DENTÁRIA'),
          // Subsubsessão: Dentição
          _sectionTitle('DAI: Dentição'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildDropdown(
                  label: 'Condições dentição: Superior',
                  value: questionario.condDenticaoSup,
                  itens: listaCondDenticao,
                  onChangedLocal: (val) => questionario.condDenticaoSup = val,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Condições dentição: Inferior',
                  value: questionario.condDenticaoInf,
                  itens: listaCondDenticao,
                  onChangedLocal: (val) => questionario.condDenticaoInf = val,
                ),
              ],
            ),
          ),

          // Subsubsessão: Oclusão
          const SizedBox(height: 16), // Espaço entre título e subtítulo
          _sectionTitle('DAI: Oclusão'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildDropdown(
                  label: 'Overjet: Maxilar (mm)',
                  value: questionario.overjetMax,
                  itens: listaOverjet,
                  onChangedLocal: (val) => questionario.overjetMax = val,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Overjet: Mandibular (mm)',
                  value: questionario.overjetMand,
                  itens: listaOverjet,
                  onChangedLocal: (val) => questionario.overjetMand = val,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Mordida aberta (mm)',
                  value: questionario.mordidaAberta,
                  itens: listaOverjet,
                  onChangedLocal: (val) => questionario.mordidaAberta = val,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Relação molar ântero-posterior',
                  value: questionario.relacaoMolar,
                  itens: listaRelacaoMolar,
                  onChangedLocal: (val) => questionario.relacaoMolar = val,
                ),
              ],
            ),
          ),

          // Subsubsessão: Espaço
          const SizedBox(height: 16),
          _sectionTitle('DAI: Espaço'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildDropdown(
                  label: 'Apinhamento incisal',
                  value: questionario.apinhamentoIncisal,
                  itens: listaApinhamento,
                  onChangedLocal: (val) => questionario.apinhamentoIncisal = val,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Espaçamento incisal',
                  value: questionario.espacamentoIncisal,
                  itens: listaEspacamento,
                  onChangedLocal: (val) => questionario.espacamentoIncisal = val,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Diastema incisal (mm)',
                  value: questionario.diastemaIncisal,
                  itens: listaMilimetrosOuX,
                  onChangedLocal: (val) => questionario.diastemaIncisal = val,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Desalinhamento: Maxila (mm)',
                  value: questionario.desalinhamentoMax,
                  itens: listaMilimetrosOuX,
                  onChangedLocal: (val) => questionario.desalinhamentoMax = val,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Desalinhamento: Mandíbula (mm)',
                  value: questionario.desalinhamentoMand,
                  itens: listaMilimetrosOuX,
                  onChangedLocal: (val) => questionario.desalinhamentoMand = val,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
