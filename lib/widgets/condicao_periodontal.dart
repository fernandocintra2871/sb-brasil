import 'package:app_odonto/widgets/section_bar.dart';
import 'package:flutter/material.dart';
import '../listas.dart'; // ajuste conforme necessário

class MatrixPeriodontal extends StatefulWidget {
  final Map<String, Map<String, String?>> dados; // Map<Dente, Map<Exame, Valor>>
  final List<String> dentes; // Exemplo: ['16/17', '11', '26/27', '36/37', '31', '46/47']
  final int idade; // Idade do paciente
  
  // Lista original de exames
  final List<String> examesBase = const ['Sangramento', 'Calculo', 'Bolsa', 'PIP'];
  // Adiciona um parâmetro onChanged para notificar o pai quando houver alteração
  final VoidCallback? onChanged; 

  const MatrixPeriodontal({
    super.key,
    required this.dados,
    required this.dentes,
    required this.idade,
    this.onChanged, // Adicionado para manter a funcionalidade externa
  });

  @override
  State<MatrixPeriodontal> createState() => _MatrixPeriodontalState();
}

class _MatrixPeriodontalState extends State<MatrixPeriodontal> {
  late List<String> examesExibidos; // Lista de exames filtrada

  // Função auxiliar para checar se a idade requer o exame PIP
  bool _deveExibirPIP(int idade) {
    return (idade >= 35 && idade <= 44) || (idade >= 65 && idade <= 74);
  }

  @override
  void initState() {
    super.initState();

    // 1. FILTRA OS EXAMES
    if (_deveExibirPIP(widget.idade)) {
      examesExibidos = widget.examesBase;
    } else {
      // Remove 'PIP' se a idade não estiver nas faixas 35-44 ou 65-74
      examesExibidos = widget.examesBase.where((exame) => exame != 'PIP').toList();
    }

    // 2. Inicializa o estado
    for (var dente in widget.dentes) {
      widget.dados[dente] ??= {};
      
      // Inicializa TODOS os exames na matriz de dados, inclusive PIP
      for (var exame in widget.examesBase) {
        widget.dados[dente]![exame] ??= null;
      }
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
        // Usa a lista filtrada de exames
        ...examesExibidos.map(
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            // ALTERAÇÃO: Usando Center para alinhar o nome do dente verticalmente com os Dropdowns
            child: Center(
              child: Text(dente, style: const TextStyle(fontWeight: FontWeight.w500)),
            ),
          ),
          
          // Itera apenas sobre os exames que devem ser exibidos
          ...examesExibidos.map((exame) {
            final listaOpcoes = _getListaParaExame(exame);

            return Expanded(
              child: DropdownButtonFormField<String>(
                // Lê o valor da matriz de dados original
                value: widget.dados[dente]?[exame],
                isExpanded: true,
                items: listaOpcoes
                    .map((opcao) => DropdownMenuItem(value: opcao, child: Text(opcao, textAlign: TextAlign.center)))
                    .toList(),
                // onChanged é sempre ativo
                onChanged: (val) {
                    setState(() {
                      widget.dados[dente]![exame] = val;
                      widget.onChanged?.call(); // Notifica o widget pai
                    });
                },
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                ),
                disabledHint: const Text(""),
                validator: (_) {
                  // A validação agora é simples: o campo exibido NÃO pode ser nulo.
                  if (widget.dados[dente]![exame] == null) {
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