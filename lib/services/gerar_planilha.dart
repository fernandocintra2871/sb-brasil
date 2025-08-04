import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:app_odonto/models/questionario.dart';

Future<void> criarExcelComDados(List<Questionario> questionarios) async {
  var excel = Excel.createExcel();
  final Sheet sheet = excel.sheets.values.first;

  CellStyle headerStyle = CellStyle(
    backgroundColorHex: "#B3D7FF",
    bold: true,
    horizontalAlign: HorizontalAlign.Center,
    verticalAlign: VerticalAlign.Center,
  );

  // Cabeçalho - Linha 0
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), 'LUGAR-DATA');
  sheet.merge(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0),
      CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0)); // Agora até col 4
  for (int c = 0; c <= 4; c++) {
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: c, rowIndex: 0)).cellStyle = headerStyle;
  }

  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0), 'CPOD');
  sheet.merge(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0),
      CellIndex.indexByColumnRow(columnIndex: 24, rowIndex: 0));
  for (int c = 5; c <= 24; c++) {
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: c, rowIndex: 0)).cellStyle = headerStyle;
  }

  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 25, rowIndex: 0), 'CPOD COROA');
  sheet.merge(CellIndex.indexByColumnRow(columnIndex: 25, rowIndex: 0),
      CellIndex.indexByColumnRow(columnIndex: 29, rowIndex: 0));
  for (int c = 25; c <= 29; c++) {
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: c, rowIndex: 0)).cellStyle = headerStyle;
  }

  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 30, rowIndex: 0), 'NEC. TRATAMENTO');
  sheet.merge(CellIndex.indexByColumnRow(columnIndex: 30, rowIndex: 0),
      CellIndex.indexByColumnRow(columnIndex: 49, rowIndex: 0));
  for (int c = 30; c <= 49; c++) {
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: c, rowIndex: 0)).cellStyle = headerStyle;
  }

  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 50, rowIndex: 0), 'TRATAMENTO');
  sheet.merge(CellIndex.indexByColumnRow(columnIndex: 50, rowIndex: 0),
      CellIndex.indexByColumnRow(columnIndex: 58, rowIndex: 0));
  for (int c = 50; c <= 58; c++) {
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: c, rowIndex: 0)).cellStyle = headerStyle;
  }

  // Linha 1
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 1), '');
  sheet.merge(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 1),
      CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 1));
  for (int c = 0; c <= 4; c++) {
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: c, rowIndex: 1)).cellStyle = headerStyle;
  }

  const cpodQs = ['Q1', 'Q2', 'Q3', 'Q4'];
  int col = 5;
  for (var q in cpodQs) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 1), q);
    sheet.merge(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 1),
        CellIndex.indexByColumnRow(columnIndex: col + 4, rowIndex: 1));
    for (int c = col; c <= col + 4; c++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: c, rowIndex: 1)).cellStyle = headerStyle;
    }
    col += 5;
  }

  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 25, rowIndex: 1), '');
  sheet.merge(CellIndex.indexByColumnRow(columnIndex: 25, rowIndex: 1),
      CellIndex.indexByColumnRow(columnIndex: 29, rowIndex: 1));
  for (int c = 25; c <= 29; c++) {
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: c, rowIndex: 1)).cellStyle = headerStyle;
  }

  col = 30;
  for (var q in cpodQs) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 1), q);
    sheet.merge(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 1),
        CellIndex.indexByColumnRow(columnIndex: col + 4, rowIndex: 1));
    for (int c = col; c <= col + 4; c++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: c, rowIndex: 1)).cellStyle = headerStyle;
    }
    col += 5;
  }

  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 50, rowIndex: 1), '');
  sheet.merge(CellIndex.indexByColumnRow(columnIndex: 50, rowIndex: 1),
      CellIndex.indexByColumnRow(columnIndex: 58, rowIndex: 1));
  for (int c = 50; c <= 58; c++) {
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: c, rowIndex: 1)).cellStyle = headerStyle;
  }

  // Linha 2 - colunas detalhadas
  const lugarDataCols = ['Numero', 'Identificação', 'Idade', 'Sexo', 'Grupo Étnico'];
  for (int i = 0; i < lugarDataCols.length; i++) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 2), lugarDataCols[i]);
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 2)).cellStyle = headerStyle;
  }

  final dentesQ = [
    ['15', '14', '13', '12', '11'],
    ['21', '22', '23', '24', '25'],
    ['35', '34', '33', '32', '31'],
    ['41', '42', '43', '44', '45'],
  ];

  col = 5;
  for (var q in dentesQ) {
    for (int i = 0; i < q.length; i++) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col + i, rowIndex: 2), q[i]);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: col + i, rowIndex: 2)).cellStyle = headerStyle;
    }
    col += 5;
  }

  const cpodCoroaCols = ['C1', 'C2', 'P', 'O', 'CPOD'];
  for (int i = 0; i < cpodCoroaCols.length; i++) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 25 + i, rowIndex: 2), cpodCoroaCols[i]);
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 25 + i, rowIndex: 2)).cellStyle = headerStyle;
  }

  col = 30;
  for (var q in dentesQ) {
    for (int i = 0; i < q.length; i++) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col + i, rowIndex: 2), q[i]);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: col + i, rowIndex: 2)).cellStyle = headerStyle;
    }
    col += 5;
  }

  const tratamentos = ['0', '1', '2', '3', '4', '5', '6', '7', '8'];
  for (int i = 0; i < tratamentos.length; i++) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 50 + i, rowIndex: 2), tratamentos[i]);
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 50 + i, rowIndex: 2)).cellStyle = headerStyle;
  }

  // --- Preenchimento das linhas de dados a partir da linha 3 ---
  int linhaAtual = 3;

  for (int idx = 0; idx < questionarios.length; idx++) {
    final q = questionarios[idx];

    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: linhaAtual), (idx + 1).toString());
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: linhaAtual), (idx + 1).toString());
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: linhaAtual), q.idade ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: linhaAtual), q.sexo ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: linhaAtual), q.corRaca ?? '');

    final quadrantes = {0: q.quadrante1, 1: q.quadrante2, 2: q.quadrante3, 3: q.quadrante4};
    final dentesPorQuadrante = [
      ['55', '54', '53', '52', '51'],
      ['61', '62', '63', '64', '65'],
      ['75', '74', '73', '72', '71'],
      ['81', '82', '83', '84', '85'],
    ];

    col = 5;
    for (int qIdx = 0; qIdx < 4; qIdx++) {
      var quad = quadrantes[qIdx]!;
      var dentes = dentesPorQuadrante[qIdx];
      for (int i = 0; i < dentes.length; i++) {
        sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col + i, rowIndex: linhaAtual),
            quad[dentes[i]]?['coroa'] ?? '');
      }
      col += 5;
    }

    // Deixa os campos CPOD COROA (C1, C2, P, O, CPOD) em branco
    for (int i = 25; i <= 29; i++) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: linhaAtual), '');
    }

    col = 30;
    for (int qIdx = 0; qIdx < 4; qIdx++) {
      var quad = quadrantes[qIdx]!;
      var dentes = dentesPorQuadrante[qIdx];
      for (int i = 0; i < dentes.length; i++) {
        sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col + i, rowIndex: linhaAtual),
            quad[dentes[i]]?['trat'] ?? '');
      }
      col += 5;
    }

    for (int i = 0; i < 9; i++) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 50 + i, rowIndex: linhaAtual), '');
    }

    linhaAtual++; // <<--- ESSENCIAL!
  }

  final dir = await getExternalStorageDirectory();
  final path = '${dir!.path}/dados_odonto_completo.xlsx';
  final fileBytes = excel.encode();
  final file = File(path)
    ..createSync(recursive: true)
    ..writeAsBytesSync(fileBytes!);

  print('Arquivo salvo em: $path');
}
