import 'package:app_odonto/widgets/section_bar.dart';
import 'package:flutter/material.dart';
import '../listas.dart';
import '../models/questionario.dart'; // ajuste conforme o local do seu arquivo

class LocalizacaoSection extends StatelessWidget {
  final Questionario questionario;
  final void Function()? onChanged;

  const LocalizacaoSection({
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
        SecaoTitulo('LOCALIZAÇÃO'),

        // Conteúdo com padding
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Código do município
              TextFormField(
                initialValue: questionario.codigoMunicipio,
                decoration: const InputDecoration(labelText: 'Código do município'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o código do município';
                  }
                  final n = int.tryParse(value);
                  if (n == null || n < 0) {
                    return 'Código de município inválido';
                  }
                  return null;
                },
                onChanged: (value) {
                  questionario.codigoMunicipio = value;
                  onChanged?.call();
                },
              ),
              const SizedBox(height: 16),

              // Estado
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Estado'),
                value: questionario.estado,
                items: listaEstados
                    .map((uf) => DropdownMenuItem(value: uf, child: Text(uf)))
                    .toList(),
                validator: (value) => value == null ? 'Selecione um estado' : null,
                onChanged: (value) {
                  questionario.estado = value;
                  onChanged?.call();
                },
              ),
              const SizedBox(height: 16),

              // Data do exame
              TextFormField(
                controller: TextEditingController(text: questionario.dataExame),
                decoration: const InputDecoration(
                  labelText: 'Data do exame (dd/mm/aaaa)',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    final formatted = '${picked.day.toString().padLeft(2, '0')}/'
                        '${picked.month.toString().padLeft(2, '0')}/'
                        '${picked.year}';
                    questionario.dataExame = formatted;
                    onChanged?.call();
                  }
                },
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe a data do exame' : null,
              ),
              const SizedBox(height: 16),

              // Endereço
              TextFormField(
                initialValue: questionario.endereco,
                decoration: const InputDecoration(labelText: 'Endereço'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o endereço' : null,
                onChanged: (value) {
                  questionario.endereco = value;
                  onChanged?.call();
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

}
