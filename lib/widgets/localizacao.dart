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
              // Nome do município
              TextFormField(
                initialValue: questionario.codigoMunicipio, 
                decoration: const InputDecoration(labelText: 'Nome do município'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome do município';
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
                    // É importante garantir que o controlador do TextEditingController
                    // seja atualizado ou que o widget seja reconstruído para refletir o valor.
                    // Como não estamos usando um StatefulWidget, vamos confiar no onChanged
                    // do widget pai para forçar uma reconstrução.
                    onChanged?.call(); 
                  }
                },
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe a data do exame' : null,
              ),
              // O SizedBox de 16 abaixo não é mais necessário aqui.
              // const SizedBox(height: 16), // REMOVIDO

              // O campo Endereço e seu SizedBox foram removidos.
            ],
          ),
        ),
      ],
    );
  }
}