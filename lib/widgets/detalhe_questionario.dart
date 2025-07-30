import 'package:flutter/material.dart';
import 'package:app_odonto/models/questionario.dart';

class DetalheQuestionarioPage extends StatelessWidget {
  final Questionario questionario;

  const DetalheQuestionarioPage({super.key, required this.questionario});

  Widget _buildTitulo(String titulo) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        titulo,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildLinha(String rotulo, String? valor) {
    return Text('$rotulo: ${valor ?? 'N/A'}');
  }

  Widget _buildTabelaDentes(String titulo, Map<String, Map<String, String?>> mapa) {
    final campos = mapa.values.first.keys.toList(); // Ex: ['coroa', 'raiz', 'trat']
    final dentes = mapa.keys.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(titulo, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Table(
            border: TableBorder.all(color: Colors.grey),
            defaultColumnWidth: IntrinsicColumnWidth(),
            children: [
              // Cabeçalho
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[200]),
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Dente', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ...campos.map((campo) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(campo, style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                ],
              ),
              // Linhas
              ...dentes.map((dente) {
                final dados = mapa[dente]!;
                return TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(dente),
                    ),
                    ...campos.map((campo) => Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(dados[campo] ?? 'N/A'),
                        )),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Questionário')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTitulo('Localização'),
          _buildLinha('Código Município', questionario.codigoMunicipio),
          _buildLinha('Estado', questionario.estado),
          _buildLinha('Data do Exame', questionario.dataExame),
          _buildLinha('Endereço', questionario.endereco),

          _buildTitulo('Informações Gerais'),
          _buildLinha('Idade', questionario.idade),
          _buildLinha('Data de Nascimento', questionario.dataNascimento),
          _buildLinha('Sexo', questionario.sexo),
          _buildLinha('Cor/Raça', questionario.corRaca),

          _buildTitulo('Uso e Necessidade de Prótese'),
          _buildLinha('Uso Prótese Superior', questionario.usoProteseSup),
          _buildLinha('Uso Prótese Inferior', questionario.usoProteseInf),
          _buildLinha('Nec. Prótese Superior', questionario.necProteseSup),
          _buildLinha('Nec. Prótese Inferior', questionario.necProteseInf),

          _buildTitulo('Traumatismo Dentário'),
          _buildLinha('Dente 12', questionario.trauDentario12),
          _buildLinha('Dente 11', questionario.trauDentario11),
          _buildLinha('Dente 21', questionario.trauDentario21),
          _buildLinha('Dente 22', questionario.trauDentario22),
          _buildLinha('Dente 32', questionario.trauDentario32),
          _buildLinha('Dente 31', questionario.trauDentario31),
          _buildLinha('Dente 41', questionario.trauDentario41),
          _buildLinha('Dente 42', questionario.trauDentario42),

          _buildTitulo('Condição da Oclusão Dentária'),
          _buildLinha('Chave Caninos', questionario.chaveCaninos),
          _buildLinha('Sobressaliência', questionario.sobressaliencia),
          _buildLinha('Sobremordida', questionario.sobremordida),
          _buildLinha('Mordida Cruzada Posterior', questionario.mordidaCruzadaPosterior),

          _buildTitulo('DAI - Dentição'),
          _buildLinha('Dentição Superior', questionario.condDenticaoSup),
          _buildLinha('Dentição Inferior', questionario.condDenticaoInf),

          _buildTitulo('Overjet'),
          _buildLinha('Overjet Maxilar', questionario.overjetMax),
          _buildLinha('Overjet Mandibular', questionario.overjetMand),
          _buildLinha('Mordida Aberta', questionario.mordidaAberta),

          _buildTitulo('Relação Molar'),
          _buildLinha('Relação Molar', questionario.relacaoMolar),

          _buildTitulo('Espaço'),
          _buildLinha('Apinhamento Incisal', questionario.apinhamentoIncisal),
          _buildLinha('Espaçamento Incisal', questionario.espacamentoIncisal),
          _buildLinha('Diastema Incisal', questionario.diastemaIncisal),
          _buildLinha('Desalinhamento Maxilar', questionario.desalinhamentoMax),
          _buildLinha('Desalinhamento Mandibular', questionario.desalinhamentoMand),

          _buildTitulo('Quadro de Cárie por Quadrante'),
          _buildTabelaDentes('Quadrante 1', questionario.quadrante1),
          _buildTabelaDentes('Quadrante 2', questionario.quadrante2),
          _buildTabelaDentes('Quadrante 3', questionario.quadrante3),
          _buildTabelaDentes('Quadrante 4', questionario.quadrante4),

          _buildTitulo('Condição Periodontal'),
          _buildTabelaDentes('Periodontal', questionario.condicaoPeriodontal),

          _buildTitulo('Urgência'),
          _buildLinha('Urgência', questionario.urgencia),
        ],
      ),
    );
  }
}
