import 'package:app_odonto/widgets/section_bar.dart';
import 'package:flutter/material.dart';
import '../listas.dart'; // ajuste conforme necessário

class MatrixPeriodontal extends StatefulWidget {
  final Map<String, Map<String, String?>> dados; // Map<Dente, Map<Exame, Valor>>
  final List<String> dentes; // Exemplo: ['16/17', '11', '26/27', '36/37', '31', '46/47']
  final List<String> exames = ['Sangramento', 'Calculo', 'Bolsa', 'PIP'];

  MatrixPeriodontal({
    super.key,
    required this.dados,
    required this.dentes,
  });

  @override
  State<MatrixPeriodontal> createState() => _MatrixPeriodontalState();
}

class _MatrixPeriodontalState extends State<MatrixPeriodontal> {
  final Map<String, bool> ativos = {};

  @override
  void initState() {
    super.initState();
    for (var dente in widget.dentes) {
      widget.dados[dente] ??= {};
      for (var exame in widget.exames) {
        widget.dados[dente]![exame] ??= null;
      }
      // Inicializa checkbox ativo baseado em dados preenchidos
      final dados = widget.dados[dente]!;
      ativos[dente] = dados.values.any((valor) => valor != null);
    }
  }

  List<String> _getListaParaExame(String exame) {
    switch (exame) {
      case 'Sangramento':
      case 'Calculo':
        return listaSCBX;
      case 'Bolsa':
        return listaBolsa;
      case 'PIP':
        return listaPIP;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SecaoTitulo('CONDIÇÃO PERIODONTAL'),
        _buildCabecalho(),
        const SizedBox(height: 8),
        ...widget.dentes.map(_buildLinha).toList(),
      ],
    );
  }

  Widget _buildCabecalho() {
    return Row(
      children: [
        const SizedBox(width: 80),
        ...widget.exames.map(
          (exame) => Expanded(
            child: Text(
              exame,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLinha(String dente) {
    final ativo = ativos[dente] ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: Row(
              children: [
                Checkbox(
                  value: ativo,
                  onChanged: (val) {
                    setState(() {
                      ativos[dente] = val ?? false;
                      if (val == false) {
                        // Reseta valores quando desativar
                        for (var exame in widget.exames) {
                          widget.dados[dente]![exame] = null;
                        }
                      }
                    });
                  },
                ),
                Flexible(child: Text(dente)),
              ],
            ),
          ),
          ...widget.exames.map((exame) {
            final listaOpcoes = _getListaParaExame(exame);

            return Expanded(
              child: DropdownButtonFormField<String>(
                value: widget.dados[dente]?[exame],
                isExpanded: true,
                items: listaOpcoes
                    .map((opcao) => DropdownMenuItem(value: opcao, child: Text(opcao, textAlign: TextAlign.center)))
                    .toList(),
                onChanged: ativo
                    ? (val) {
                        setState(() {
                          widget.dados[dente]![exame] = val;
                        });
                      }
                    : null,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                ),
                disabledHint: const Text(""),
                validator: (_) {
                  if (ativo && widget.dados[dente]![exame] == null) {
                    return 'Obrigatório';
                  }
                  return null;
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
