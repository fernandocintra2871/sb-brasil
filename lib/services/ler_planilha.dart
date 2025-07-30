import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:app_odonto/models/questionario.dart';

Future<List<Questionario>> carregarQuestionariosDoCSV() async {
  final directory = await getExternalStorageDirectory();
  final path = '${directory!.path}/dados_formulario.csv';
  final file = File(path);

  if (!await file.exists()) return [];

  final csvString = await file.readAsString();
  final csv = const CsvToListConverter().convert(csvString);

  final data = csv.skip(1); // ignora o cabeçalho
  return data.map((linha) => _fromCSV(linha)).toList();
}

Questionario _fromCSV(List<dynamic> linha) {
  final q = Questionario();
  int i = 0;

  q.codigoMunicipio = linha[i++].toString();
  q.estado = linha[i++].toString();
  q.dataExame = linha[i++].toString();
  q.endereco = linha[i++].toString();
  q.idade = linha[i++].toString();
  q.dataNascimento = linha[i++].toString();
  q.sexo = linha[i++].toString();
  q.corRaca = linha[i++].toString();

  q.usoProteseSup = linha[i++].toString();
  q.usoProteseInf = linha[i++].toString();
  q.necProteseSup = linha[i++].toString();
  q.necProteseInf = linha[i++].toString();

  q.trauDentario12 = linha[i++].toString();
  q.trauDentario11 = linha[i++].toString();
  q.trauDentario21 = linha[i++].toString();
  q.trauDentario22 = linha[i++].toString();
  q.trauDentario32 = linha[i++].toString();
  q.trauDentario31 = linha[i++].toString();
  q.trauDentario41 = linha[i++].toString();
  q.trauDentario42 = linha[i++].toString();

  q.chaveCaninos = linha[i++].toString();
  q.sobressaliencia = linha[i++].toString();
  q.sobremordida = linha[i++].toString();
  q.mordidaCruzadaPosterior = linha[i++].toString();

  q.condDenticaoSup = linha[i++].toString();
  q.condDenticaoInf = linha[i++].toString();
  q.overjetMax = linha[i++].toString();
  q.overjetMand = linha[i++].toString();
  q.mordidaAberta = linha[i++].toString();

  q.relacaoMolar = linha[i++].toString();
  q.apinhamentoIncisal = linha[i++].toString();
  q.espacamentoIncisal = linha[i++].toString();
  q.diastemaIncisal = linha[i++].toString();
  q.desalinhamentoMax = linha[i++].toString();
  q.desalinhamentoMand = linha[i++].toString();

  final dentesQ1 = ['18', '17', '16', '55', '15', '54', '14', '53', '13', '52', '12', '51', '11'];
  final dentesQ2 = ['61', '21', '62', '22', '63', '23', '64', '24', '65', '25', '26', '27', '28'];
  final dentesQ3 = ['71', '31', '72', '32', '73', '33', '74', '34', '75', '35', '36', '37', '38'];
  final dentesQ4 = ['48', '47', '46', '85', '45', '84', '44', '82', '42', '81', '41'];
  final dentesPeriodontal = ['16/17', '11', '26/27', '46/47', '31', '36/37'];

  for (final d in dentesQ1) {
    q.quadrante1[d]!['coroa'] = linha[i++].toString();
    q.quadrante1[d]!['raiz'] = linha[i++].toString();
    q.quadrante1[d]!['trat'] = linha[i++].toString();
  }
  for (final d in dentesQ2) {
    q.quadrante2[d]!['coroa'] = linha[i++].toString();
    q.quadrante2[d]!['raiz'] = linha[i++].toString();
    q.quadrante2[d]!['trat'] = linha[i++].toString();
  }
  for (final d in dentesQ3) {
    q.quadrante3[d]!['coroa'] = linha[i++].toString();
    q.quadrante3[d]!['raiz'] = linha[i++].toString();
    q.quadrante3[d]!['trat'] = linha[i++].toString();
  }
  for (final d in dentesQ4) {
    q.quadrante4[d]!['coroa'] = linha[i++].toString();
    q.quadrante4[d]!['raiz'] = linha[i++].toString();
    q.quadrante4[d]!['trat'] = linha[i++].toString();
  }

  for (final d in dentesPeriodontal) {
    q.condicaoPeriodontal[d]!['Sangramento'] = linha[i++].toString();
    q.condicaoPeriodontal[d]!['Calculo'] = linha[i++].toString();
    q.condicaoPeriodontal[d]!['Bolsa'] = linha[i++].toString();
    q.condicaoPeriodontal[d]!['PIP'] = linha[i++].toString();
  }

  q.urgencia = linha[i++].toString();

  return q;
}
