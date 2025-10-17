import 'package:app_odonto/widgets/foster_humilton.dart';
import 'package:flutter/material.dart';
import 'package:app_odonto/models/questionario.dart';
import 'package:app_odonto/services/salvar_planilha.dart';
import 'package:app_odonto/widgets/localizacao.dart';
import 'package:app_odonto/widgets/informacoes_gerais.dart';
import 'package:app_odonto/widgets/uso_necessidade_protese.dart';
import 'package:app_odonto/widgets/traumatismo_dentario.dart';
import 'package:app_odonto/widgets/condicao_periodontal.dart';
import 'package:app_odonto/widgets/dai.dart';
import 'package:app_odonto/widgets/matriz_dentaria.dart';
import 'package:app_odonto/widgets/urgencia.dart';

class QuestionarioPage extends StatefulWidget {
  const QuestionarioPage({super.key});

  @override
  State<QuestionarioPage> createState() => _QuestionarioPageState();
}

class _QuestionarioPageState extends State<QuestionarioPage> {
  final _formKey = GlobalKey<FormState>();
  late Questionario questionario;

  final PageController _pageController = PageController();
  int _paginaAtual = 0;
  int totalPaginas = 0; // Agora inicializado dinamicamente

  @override
  void initState() {
    super.initState();
    questionario = Questionario();

    _calcularTotalPaginas(); // calcula inicialmente
  }

  // Método que calcula o total de páginas baseado na idade
  void _calcularTotalPaginas() {
    final idade = int.tryParse(questionario.idade ?? '') ?? 0;

    // Sempre tem as duas primeiras seções
    int paginas = 2;

    // Seções por faixa etária:
    if (idade == 5) {
      paginas += 1; // CondicaoOclusaoDentariaSection
    } else if (idade == 12) {
      paginas += 3; // TraumatismoDentarioSection, DAISection, MatrixPeriodontal
    } else if (idade >= 15 && idade <= 19) {
      paginas += 3; // UsoNecessidadeProteseSection, DAISection, MatrixPeriodontal
    } else if ((idade >= 35 && idade <= 44) || (idade >= 65 && idade <= 74)) {
      paginas += 2; // UsoNecessidadeProteseSection, MatrixPeriodontal
    }

    // Sempre tem 4 MatrizDentaria + Urgencia (total 5)
    paginas += 5;

    setState(() {
      totalPaginas = paginas;

      // Ajusta página atual caso extrapole novo total
      if (_paginaAtual >= totalPaginas) {
        _paginaAtual = totalPaginas - 1;
        _pageController.jumpToPage(_paginaAtual);
      }
    });
  }

  Future<void> _proximaPagina() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_paginaAtual < totalPaginas - 1) {
        _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        setState(() => _paginaAtual++);
      } else {
        await salvarQuestionarioCSVAppend(questionario);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Questionário salvo na planilha com sucesso!')),
        );

        Navigator.pop(context, true);
      }
    }
  }

  void _paginaAnterior() {
    if (_paginaAtual > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() => _paginaAtual--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final sair = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Deseja sair?'),
            content: const Text('Você perderá os dados preenchidos até agora. Deseja voltar à lista de questionários?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Sim'),
              ),
            ],
          ),
        );

        if (sair == true && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Questionário de Saúde Bucal'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    // Seções sempre visíveis
                    LocalizacaoSection(
                      questionario: questionario,
                      onChanged: () {
                        setState(() {});
                        _calcularTotalPaginas(); // recalcula quando mudar idade (se alterar nessa seção)
                      },
                    ),
                    InformacoesGeraisSection(
                      questionario: questionario,
                      onChanged: () {
                        setState(() {});
                        _calcularTotalPaginas(); // recalcula quando mudar idade
                      },
                    ),

                    // Seções por faixa etária
                    if ((int.tryParse(questionario.idade ?? '') ?? 0) == 5)
                      CondicaoOclusaoDentariaSection(
                        questionario: questionario,
                        onChanged: () => setState(() {}),
                      ),

                    if ((int.tryParse(questionario.idade ?? '') ?? 0) == 12) ...[
                      TraumatismoDentarioSection(questionario: questionario, onChanged: () => setState(() {})),
                      DAISection(questionario: questionario, onChanged: () => setState(() {})),
                      MatrixPeriodontal(dados: questionario.condicaoPeriodontal, dentes: const ['16/17', '11', '26/27', '46/47', '31', '36/37']),
                    ],

                    if ((int.tryParse(questionario.idade ?? '') ?? 0) >= 15 &&
                        (int.tryParse(questionario.idade ?? '') ?? 0) <= 19) ...[
                      UsoNecessidadeProteseSection(questionario: questionario, onChanged: () => setState(() {})),
                      DAISection(questionario: questionario, onChanged: () => setState(() {})),
                      MatrixPeriodontal(dados: questionario.condicaoPeriodontal, dentes: const ['16/17', '11', '26/27', '46/47', '31', '36/37']),
                    ],

                    if (((int.tryParse(questionario.idade ?? '') ?? 0) >= 35 && (int.tryParse(questionario.idade ?? '') ?? 0) <= 44) ||
                        ((int.tryParse(questionario.idade ?? '') ?? 0) >= 65 && (int.tryParse(questionario.idade ?? '') ?? 0) <= 74)) ...[
                      UsoNecessidadeProteseSection(questionario: questionario, onChanged: () => setState(() {})),
                      MatrixPeriodontal(dados: questionario.condicaoPeriodontal, dentes: const ['16/17', '11', '26/27', '46/47', '31', '36/37']),
                    ],

                    // Sempre visíveis: MatrizDentaria e Urgência
                    MatrizDentaria(
                      quadrante: questionario.quadrante1,
                      linhasComDentes: const ['18', '17', '16', '55', '15', '54', '14', '53', '13', '52', '12', '51', '11'],
                      titulo: 'Quadrante 1',
                      idade: int.tryParse(questionario.idade ?? '') ?? 0,
                    ),
                    MatrizDentaria(
                      quadrante: questionario.quadrante2,
                      linhasComDentes: const ['61', '21', '62', '22', '63', '23', '64', '24', '65', '25', '26', '27', '28'],
                      titulo: 'Quadrante 2',
                      idade: int.tryParse(questionario.idade ?? '') ?? 0,
                    ),
                    MatrizDentaria(
                      quadrante: questionario.quadrante3,
                      linhasComDentes: const ['71', '31', '72', '32', '73', '33', '74', '34', '75', '35', '36', '37', '38'],
                      titulo: 'Quadrante 3',
                      idade: int.tryParse(questionario.idade ?? '') ?? 0,
                    ),
                    MatrizDentaria(
                      quadrante: questionario.quadrante4,
                      linhasComDentes: const ['48', '47', '46', '85', '45', '84', '44', '83', '43', '82', '42', '81', '41'],
                      titulo: 'Quadrante 4',
                      idade: int.tryParse(questionario.idade ?? '') ?? 0,
                    ),

                    DropdownUrgenciaSection(
                      questionario: questionario,
                      onChanged: () => setState(() {}),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    if (_paginaAtual > 0)
                      ElevatedButton(
                        onPressed: _paginaAnterior,
                        child: const Text('Voltar'),
                      ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _proximaPagina,
                      child: Text(_paginaAtual == totalPaginas - 1 ? 'Enviar' : 'Próximo'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
