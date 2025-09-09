import 'package:app_odonto/widgets/section_bar.dart';
import 'package:app_odonto/widgets/sub_section.dart';
import 'package:flutter/material.dart';
import '../listas.dart'; // listaPUFA, listaPUFADec, listaCoroaDec devem estar aqui

class MatrizDentaria extends StatefulWidget {
  final Map<String, Map<String, String?>> quadrante;
  final List<String> linhasComDentes;
  final String titulo;
  final int idade;

  const MatrizDentaria({
    super.key,
    required this.quadrante,
    required this.linhasComDentes,
    required this.titulo,
    required this.idade,
  });

  @override
  State<MatrizDentaria> createState() => _MatrizDentariaState();
}

class _MatrizDentariaState extends State<MatrizDentaria> {
  final Map<String, bool> ativos = {};
  late List<String> dentesFiltrados;
  
  // Lista dos dentes deciduos
  final List<String> dentesDeciduos = [
    '55', '54', '53', '52', '51',
    '61', '62', '63', '64', '65',
    '75', '74', '73', '72', '71',
    '81', '82', '83', '84', '85',
  ];

  // Dentes que terão checkbox (os demais serão sempre ativos)
  final List<String> dentesComCheckbox = [
    '55', '15', '54', '14', '53', '13', '52', '12', '51', '11',
    '61', '21', '62', '22', '63', '23', '64', '24', '65', '25',
    '45', '85', '44', '84', '43', '83', '42', '82', '41', '81',
    '31', '71', '32', '72', '33', '73', '34', '74', '35', '75',
    '18', '17', '16', '26', '27', '28', '48', '47', '46', '36', '37', '38'
  ];

  @override
  void initState() {
    super.initState();

    // Filtra dentes dependendo da idade
    if (widget.idade <= 5) {
      dentesFiltrados = widget.linhasComDentes
          .where((dente) => dentesDeciduos.contains(dente))
          .toList();
    } else if (widget.idade <= 12) {
      dentesFiltrados = widget.linhasComDentes;
    } else {
      dentesFiltrados = widget.linhasComDentes
          .where((dente) => !dentesDeciduos.contains(dente))
          .toList();
    }

    // Inicializa os estados dos checkboxes
    for (var dente in dentesFiltrados) {
      final dados = widget.quadrante[dente];
      if (dentesComCheckbox.contains(dente)) {
        // Dentes com checkbox - podem ser desativados
        ativos[dente] = dados != null &&
            (dados['coroa'] != null || dados['raiz'] != null || dados['trat'] != null || dados['pufa'] != null);
      } else {
        // Dentes sem checkbox - sempre ativos
        ativos[dente] = true;
      }
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
          ...dentesFiltrados.map(_buildLinha),
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
    final isDeciduo = dentesDeciduos.contains(dente);
    final temCheckbox = dentesComCheckbox.contains(dente);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: temCheckbox 
                ? Row(
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
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 48.0),
                    child: Text(dente),
                  ),
          ),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: widget.quadrante[dente]!['coroa'],
              isExpanded: true,
              items: (isDeciduo ? listaCoroaDec : listaCoroa)
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
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
            child: isDeciduo
                ? const TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "-",
                    ),
                  )
                : DropdownButtonFormField<String>(
                    value: widget.quadrante[dente]!['raiz'],
                    isExpanded: true,
                    items: listaRaiz.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: ativo
                        ? (val) => setState(() => widget.quadrante[dente]!['raiz'] = val)
                        : null,
                    decoration: const InputDecoration(isDense: true),
                    disabledHint: const Text(""),
                    validator: (_) {
                      if (ativos[dente] == true && widget.quadrante[dente]!['raiz'] == null && !isDeciduo) {
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
              items: (isDeciduo ? listaPUFADec : listaPUFA)
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
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