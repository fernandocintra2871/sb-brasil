import 'package:app_odonto/services/gerar_planilha.dart';
import 'package:app_odonto/widgets/pagina_questionario.dart';
import 'package:flutter/material.dart';
import 'package:app_odonto/models/questionario.dart';
import 'package:app_odonto/widgets/detalhe_questionario.dart';
import 'package:app_odonto/services/ler_planilha.dart';


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

  Future<void> _gerarExcel() async {
    List<Questionario> questionarios = await carregarQuestionariosDoCSV();
    await criarExcelComDados(questionarios);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Arquivo Excel criado com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionários Salvos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            tooltip: 'Gerar Excel',
            onPressed: _gerarExcel,
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
                return ListTile(
                  title: Text('Exame em: ${q.dataExame}'),
                  subtitle: Text('UF: ${q.estado}, Idade: ${q.idade}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetalheQuestionarioPage(questionario: q),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
