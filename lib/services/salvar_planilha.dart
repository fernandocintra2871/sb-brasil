import 'package:app_odonto/models/questionario.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

Future<void> salvarQuestionarioCSVAppend(Questionario q) async {
  final directory = await getExternalStorageDirectory();
  final path = directory!.path;
  final file = File('$path/dados_formulario.csv');

  List<List<dynamic>> rows = [];

  if (await file.exists()) {
    final csvString = await file.readAsString();
    rows = const CsvToListConverter().convert(csvString);
  }

  if (rows.isEmpty) {
    List<String> header = [
      'Codigo Municipio', 'Estado', 'Data Exame', 'Endereco',
      'Idade', 'Data Nasc.', 'Sexo', 'Cor/Raca',
      'Uso Protese Sup', 'Uso Protese Inf', 'Nec. Protese Sup', 'Nec. Protese Inf',
      'TrauDent 12', 'TrauDent 11', 'TrauDent 21', 'TrauDent 22', 'TrauDent 32', 'TrauDent 31', 'TrauDent 41', 'TrauDent 42',
      'Chave Caninos', 'Sobressalencia', 'Sobremordida', 'Mord. Cruz. Post.',
      'Denticao Sup', 'Denticao Inf',
      'Overjet Max', 'Overjet Mand', 'Mordida Aberta',
      'Relacao Molar',
      'Apinhamento', 'Espacamento', 'Diastema', 'Desalinh. Max', 'Desalinh. Mand',
      ..._gerarCabecalhoMapa(q.quadrante1, 'Q1'),
      ..._gerarCabecalhoMapa(q.quadrante2, 'Q2'),
      ..._gerarCabecalhoMapa(q.quadrante3, 'Q3'),
      ..._gerarCabecalhoMapa(q.quadrante4, 'Q4'),
      ..._gerarCabecalhoPeriodontal(q.condicaoPeriodontal), // Changed to specialized function
      'Urgencia',
    ];
    rows.add(header);
  }

  List<dynamic> values = [
    q.codigoMunicipio ?? '',
    q.estado ?? '',
    q.dataExame ?? '',
    q.endereco ?? '',
    q.idade ?? '',
    q.dataNascimento ?? '',
    _extrairCodigo(q.sexo),
    _extrairCodigo(q.corRaca),
    _extrairCodigo(q.usoProteseSup),
    _extrairCodigo(q.usoProteseInf),
    _extrairCodigo(q.necProteseSup),
    _extrairCodigo(q.necProteseInf),
    _extrairCodigo(q.trauDentario12),
    _extrairCodigo(q.trauDentario11),
    _extrairCodigo(q.trauDentario21),
    _extrairCodigo(q.trauDentario22),
    _extrairCodigo(q.trauDentario32),
    _extrairCodigo(q.trauDentario31),
    _extrairCodigo(q.trauDentario41),
    _extrairCodigo(q.trauDentario42),
    _extrairCodigo(q.chaveCaninos),
    _extrairCodigo(q.sobressaliencia),
    _extrairCodigo(q.sobremordida),
    _extrairCodigo(q.mordidaCruzadaPosterior),
    q.condDenticaoSup ?? '',
    q.condDenticaoInf ?? '',
    q.overjetMax ?? '',
    q.overjetMand ?? '',
    q.mordidaAberta ?? '',
    _extrairCodigo(q.relacaoMolar),
    _extrairCodigo(q.apinhamentoIncisal),
    _extrairCodigo(q.espacamentoIncisal),
    q.diastemaIncisal ?? '0',
    q.desalinhamentoMax ?? '0',
    q.desalinhamentoMand ?? '0',
    ..._gerarValoresMapa(q.quadrante1),
    ..._gerarValoresMapa(q.quadrante2),
    ..._gerarValoresMapa(q.quadrante3),
    ..._gerarValoresMapa(q.quadrante4),
    ..._gerarValoresPeriodontal(q.condicaoPeriodontal), // Changed to specialized function
    _extrairCodigo(q.urgencia),
  ];

  rows.add(values);

  String csvData = const ListToCsvConverter().convert(rows);

  final bomUtf8 = utf8.encode('\uFEFF');
  final csvBytes = utf8.encode(csvData);
  final bytesWithBom = <int>[]..addAll(bomUtf8)..addAll(csvBytes);

  await file.writeAsBytes(bytesWithBom);
}

/// Gera cabeçalhos fixos para os campos padrão, incluindo PUFA
List<String> _gerarCabecalhoMapa(Map<String, Map<String, String?>> mapa, String prefixo) {
  const camposPadrao = ['coroa', 'raiz', 'trat', 'pufa'];
  return mapa.entries.expand((e) {
    return camposPadrao.map((campo) => '$prefixo-${e.key}-$campo');
  }).toList();
}

/// Gera os valores em ordem dos campos, usando '0' quando ausente
List<String> _gerarValoresMapa(Map<String, Map<String, String?>> mapa) {
  const camposPadrao = ['coroa', 'raiz', 'trat', 'pufa'];
  return mapa.entries.expand((e) {
    return camposPadrao.map((campo) => _extrairCodigo(e.value[campo]));
  }).toList();
}

/// Gera cabeçalhos específicos para condição periodontal
List<String> _gerarCabecalhoPeriodontal(Map<String, Map<String, String?>> mapa) {
  const camposPeriodontal = ['Sangramento', 'Calculo', 'Bolsa', 'PIP'];
  return mapa.entries.expand((e) {
    return camposPeriodontal.map((campo) => 'Periodontal-${e.key}-$campo');
  }).toList();
}

/// Gera valores específicos para condição periodontal
List<String> _gerarValoresPeriodontal(Map<String, Map<String, String?>> mapa) {
  const camposPeriodontal = ['Sangramento', 'Calculo', 'Bolsa', 'PIP'];
  return mapa.entries.expand((e) {
    return camposPeriodontal.map((campo) => _extrairCodigo(e.value[campo]));
  }).toList();
}

/// Extrai o valor antes do primeiro " - ", ou retorna '0' se for null.
String _extrairCodigo(String? valor) {
  if (valor == null) return '';
  final partes = valor.split(RegExp(r'\s*-\s*'));
  return partes.first;
}