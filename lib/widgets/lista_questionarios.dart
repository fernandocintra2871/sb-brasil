import 'package:app_odonto/services/gerar_planilha_15a19anos.dart';
import 'package:app_odonto/services/gerar_planilha_35a44anos.dart';
import 'package:app_odonto/services/gerar_planilha_5anos.dart';
import 'package:app_odonto/services/gerar_planilha_65a74anos.dart';
import 'package:app_odonto/services/gerar_planilhar_12anos.dart';
import 'package:app_odonto/services/subs_quadrantes.dart';
import 'package:app_odonto/widgets/pagina_questionario.dart';
import 'package:flutter/material.dart';
import 'package:app_odonto/models/questionario.dart';
import 'package:app_odonto/widgets/detalhe_questionario.dart';
import 'package:app_odonto/services/ler_planilha.dart';

import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ListaQuestionariosPage extends StatefulWidget {
  const ListaQuestionariosPage({super.key});

  @override
  State<ListaQuestionariosPage> createState() => _ListaQuestionariosPageState();
}

class _ListaQuestionariosPageState extends State<ListaQuestionariosPage> {
  List<Questionario> questionarios = [];

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _compartilharPlanilhas() async {
    final dir =
        await getExternalStorageDirectory(); // <- mesmo usado no criarExcel

    final arquivos = [
      File('${dir!.path}/planilha_5.xlsx'),
      File('${dir.path}/planilha_12.xlsx'),
      File('${dir.path}/planilha_15a19.xlsx'),
      File('${dir.path}/planilha_35a44.xlsx'),
      File('${dir.path}/planilha_65a74.xlsx'),
    ];

    final existentes = arquivos.where((f) => f.existsSync()).toList();

    if (existentes.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nenhuma planilha encontrada para compartilhar.'),
        ),
      );
      return;
    }

    await Share.shareXFiles(
      existentes.map((f) => XFile(f.path)).toList(),
      text: 'Aqui estão as planilhas geradas pelo app Odonto 🦷📊',
    );
  }

  Future<void> _carregarDados() async {
    final lista = await carregarQuestionariosDoCSV();
    setState(() {
      questionarios = lista;
    });
  }

  void _abrirQuestionario() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const QuestionarioPage()),
    ).then((_) {
      _carregarDados(); // Recarrega ao voltar
    });
  }

  Future<bool> _removerQuestionario(
    Questionario questionario,
    int index,
  ) async {
    // Mostrar diálogo de confirmação
    bool confirmado = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text(
          'Tem certeza que deseja excluir este questionário?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmado == true) {
      setState(() {
        questionarios.removeAt(index);
      });

      // TODO: Implementar a remoção do questionário do arquivo CSV

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Questionário removido.'),
          backgroundColor: Colors.green,
        ),
      );

      return true;
    }

    return false;
  }

  Future<void> _gerarExcel() async {
    // Lê todos os questionários do CSV
    List<Questionario> questionarios = await carregarQuestionariosDoCSV();

    // Filtra por faixa etária
    List<Questionario> faixa5anos = questionarios
        .where((q) => int.tryParse(q.idade ?? '0') == 5)
        .toList();

    List<Questionario> faixa12anos = questionarios
        .where((q) => int.tryParse(q.idade ?? '0') == 12)
        .toList();

    List<Questionario> faixa15a19 = questionarios.where((q) {
      int idade = int.tryParse(q.idade ?? '0') ?? 0;
      return idade >= 15 && idade <= 19;
    }).toList();

    List<Questionario> faixa35a44 = questionarios.where((q) {
      int idade = int.tryParse(q.idade ?? '0') ?? 0;
      return idade >= 35 && idade <= 44;
    }).toList();

    List<Questionario> faixa65a74 = questionarios.where((q) {
      int idade = int.tryParse(q.idade ?? '0') ?? 0;
      return idade >= 65 && idade <= 74;
    }).toList();

    print('Qtd 5 anos: ${faixa5anos.length}');
    print('Qtd 12 anos: ${faixa12anos.length}');
    print('Qtd 15 a 19 anos: ${faixa15a19.length}');
    print('Qtd 35 a 44 anos: ${faixa35a44.length}');
    print('Qtd 65 a 74 anos: ${faixa65a74.length}');

    // Chama as funções específicas (ainda não criadas)
    substituirParesDentesEmLista(faixa5anos);
    await criarExcelFaixa5(faixa5anos);
    substituirParesDentesEmLista(faixa12anos);
    await criarExcelFaixa12(faixa12anos);
    await criarExcelFaixa15a19(faixa15a19);
    await criarExcelFaixa35a44(faixa35a44);
    await criarExcelFaixa65a74(faixa65a74);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Planilhas Excel criadas com sucesso!')),
    );
  }

  Future<void> _sincronizarDados() async {
    await _gerarExcel();
    await _compartilharPlanilhas();
  }

  String _gerarChaveUnica(Questionario q) {
    return '${q.dataExame ?? ''}_${q.idade ?? ''}_${q.estado ?? ''}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionários Salvos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_upload),
            tooltip: 'Gerar planilhas e Sincronizar',
            onPressed: _sincronizarDados,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Novo Questionário',
            onPressed: _abrirQuestionario,
          ),
        ],
      ),
      body: questionarios.isEmpty
          ? const Center(child: Text('Nenhum questionário encontrado.'))
          : ListView.builder(
              itemCount: questionarios.length,
              itemBuilder: (context, index) {
                final q = questionarios[index];
                return Dismissible(
                  key: Key(_gerarChaveUnica(q)), // Chave única
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    return await _removerQuestionario(q, index);
                  },
                  child: ListTile(
                    title: Text('Exame em: ${q.dataExame}'),
                    subtitle: Text('UF: ${q.estado}, Idade: ${q.idade}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removerQuestionario(q, index),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DetalheQuestionarioPage(questionario: q),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
