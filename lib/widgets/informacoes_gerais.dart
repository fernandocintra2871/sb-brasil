import 'package:app_odonto/widgets/section_bar.dart';
import 'package:flutter/material.dart';
import '../listas.dart';
import '../models/questionario.dart'; // ajuste o path conforme seu projeto

class InformacoesGeraisSection extends StatelessWidget {
  final Questionario questionario;
  final void Function()? onChanged;

  const InformacoesGeraisSection({
    super.key,
    required this.questionario,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título da seção fora do padding
        SecaoTitulo('INFORMAÇÕES GERAIS'),

        // Campos com padding
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Idade
              TextFormField(
                initialValue: questionario.idade,
                decoration: const InputDecoration(labelText: 'Idade'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a idade';
                  }
                  final n = int.tryParse(value);
                  if (n == null || n < 0) {
                    return 'Informe um número inteiro não negativo';
                  }
                  return null;
                },
                onChanged: (value) {
                  questionario.idade = value;
                  onChanged?.call();
                },
              ),
              const SizedBox(height: 16),

              // Data de nascimento
              TextFormField(
                controller: TextEditingController(text: questionario.dataNascimento),
                decoration: const InputDecoration(
                  labelText: 'Data de Nascimento (dd/mm/aaaa)',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    final formattedDate = '${pickedDate.day.toString().padLeft(2, '0')}/'
                        '${pickedDate.month.toString().padLeft(2, '0')}/'
                        '${pickedDate.year}';
                    questionario.dataNascimento = formattedDate;
                    onChanged?.call();
                  }
                },
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe a data de nascimento' : null,
              ),
              const SizedBox(height: 16),

              // Sexo
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Sexo'),
                value: questionario.sexo,
                items: listaSexo
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                validator: (value) => value == null ? 'Selecione um sexo' : null,
                onChanged: (value) {
                  questionario.sexo = value;
                  onChanged?.call();
                },
              ),
              const SizedBox(height: 16),

              // Cor/Raça
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Cor/Raça'),
                value: questionario.corRaca,
                items: listaCorRaca
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                validator: (value) => value == null ? 'Selecione uma cor/raça' : null,
                onChanged: (value) {
                  questionario.corRaca = value;
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
