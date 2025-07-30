import 'package:app_odonto/widgets/section_bar.dart';
import 'package:app_odonto/widgets/sub_section.dart';
import 'package:flutter/material.dart';
import '../listas.dart'; // listaPUFA deve estar aqui

class MatrizDentaria extends StatefulWidget {
  final Map<String, Map<String, String?>> quadrante;
  final List<String> linhasComDentes;
  final String titulo;

  const MatrizDentaria({
    super.key,
    required this.quadrante,
    required this.linhasComDentes,
    required this.titulo,
  });

  @override
  State<MatrizDentaria> createState() => _MatrizDentariaState();
}

class _MatrizDentariaState extends State<MatrizDentaria> {
  final Map<String, bool> ativos = {};

  @override
  void initState() {
    super.initState();
    for (var dente in widget.linhasComDentes) {
      final dados = widget.quadrante[dente];
      ativos[dente] = dados != null &&
          (dados['coroa'] != null || dados['raiz'] != null || dados['trat'] != null || dados['pufa'] != null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SecaoTitulo('CÁRIE E NECESSIDADE DE TRATAMENTO'),
          SubSecaoTitulo(widget.titulo),
          _buildCabecalho(),
          const SizedBox(height: 8),
          ...widget.linhasComDentes.map(_buildLinha),
        ],
      ),
    );
  }

  Widget _buildCabecalho() {
    return Row(
      children: const [
        SizedBox(width: 80),
        Expanded(child: Text("Coroa", style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text("Raiz", style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text("Tratamento", style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text("PUFA", style: TextStyle(fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget _buildLinha(String dente) {
    widget.quadrante[dente] ??= {'coroa': null, 'raiz': null, 'trat': null, 'pufa': null};
    final ativo = ativos[dente] ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        widget.quadrante[dente] = {
                          'coroa': null,
                          'raiz': null,
                          'trat': null,
                          'pufa': null,
                        };
                      }
                    });
                  },
                ),
                Flexible(child: Text(dente)),
              ],
            ),
          ),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: widget.quadrante[dente]!['coroa'],
              isExpanded: true,
              items: listaCoroa.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: ativo
                  ? (val) => setState(() => widget.quadrante[dente]!['coroa'] = val)
                  : null,
              decoration: const InputDecoration(isDense: true),
              disabledHint: const Text(""),
              validator: (_) {
                if (ativos[dente] == true && widget.quadrante[dente]!['coroa'] == null) {
                  return 'Obrigatório';
                }
                return null;
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: widget.quadrante[dente]!['raiz'],
              isExpanded: true,
              items: listaRaiz.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: ativo
                  ? (val) => setState(() => widget.quadrante[dente]!['raiz'] = val)
                  : null,
              decoration: const InputDecoration(isDense: true),
              disabledHint: const Text(""),
              validator: (_) {
                if (ativos[dente] == true && widget.quadrante[dente]!['raiz'] == null) {
                  return 'Obrigatório';
                }
                return null;
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: widget.quadrante[dente]!['trat'],
              isExpanded: true,
              items: listaTrat.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: ativo
                  ? (val) => setState(() => widget.quadrante[dente]!['trat'] = val)
                  : null,
              decoration: const InputDecoration(isDense: true),
              disabledHint: const Text(""),
              validator: (_) {
                if (ativos[dente] == true && widget.quadrante[dente]!['trat'] == null) {
                  return 'Obrigatório';
                }
                return null;
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: widget.quadrante[dente]!['pufa'],
              isExpanded: true,
              items: listaPUFA.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: ativo
                  ? (val) => setState(() => widget.quadrante[dente]!['pufa'] = val)
                  : null,
              decoration: const InputDecoration(isDense: true),
              disabledHint: const Text(""),
              validator: (_) {
                if (ativos[dente] == true && widget.quadrante[dente]!['pufa'] == null) {
                  return 'Obrigatório';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
