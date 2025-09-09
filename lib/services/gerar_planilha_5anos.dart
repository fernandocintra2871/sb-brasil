import 'dart:io';
import 'package:app_odonto/models/questionario.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

Future<void> criarExcelFaixa5(List<Questionario> questionarios) async {
  final excel = Excel.createExcel();
  final Sheet sheet = excel.sheets.values.first;

  final headerStyle = CellStyle(
    bold: true,
    fontSize: 12,
    horizontalAlign: HorizontalAlign.Center,
    verticalAlign: VerticalAlign.Center,
    backgroundColorHex: '#CCCCCC',
  );

  // Função auxiliar para merge e texto com estilo
  void mergeAndSet(int colStart, int colEnd, int rowStart, int rowEnd, String text) {
    sheet.merge(
      CellIndex.indexByColumnRow(columnIndex: colStart, rowIndex: rowStart),
      CellIndex.indexByColumnRow(columnIndex: colEnd, rowIndex: rowEnd),
    );
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: colStart, rowIndex: rowStart), text);
    for (var r = rowStart; r <= rowEnd; r++) {
      for (var c = colStart; c <= colEnd; c++) {
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: c, rowIndex: r)).cellStyle = headerStyle;
      }
    }
  }

  int currentRow = 0;

  // Lista de dentes por quadrante (apenas os dentes especificados)
  List<String> dentesQ1 = ['15', '14', '13', '12', '11'];
  List<String> dentesQ2 = ['21', '22', '23', '24', '25'];
  List<String> dentesQ3 = ['35', '34', '33', '32', '31'];
  List<String> dentesQ4 = ['41', '42', '43', '44', '45'];

  // 1) Linha 0 - Categorias principais
  mergeAndSet(0, 3, currentRow, currentRow, 'Localização');
  mergeAndSet(4, 7, currentRow, currentRow, 'Informações Gerais');
  mergeAndSet(8, 27, currentRow, currentRow, 'Coroa'); // Reduzido para 20 colunas (5 dentes x 4 quadrantes)
  mergeAndSet(28, 47, currentRow, currentRow, 'Nec. Tratamento');
  mergeAndSet(48, 67, currentRow, currentRow, 'PUFA');
  mergeAndSet(68, 71, currentRow, currentRow, 'Oclusão dentária');
  mergeAndSet(72, 72, currentRow, currentRow, 'Urgência');

  currentRow++;

  // 2) Linha 1 - Subcategorias
  // Localização col 0-3
  mergeAndSet(0, 3, currentRow, currentRow, '');

  // Informações Gerais col 4-7
  mergeAndSet(4, 7, currentRow, currentRow, '');

  // Coroa - dividido em 4 quadrantes (5 colunas cada)
  mergeAndSet(8, 12, currentRow, currentRow, '1º quadrante');
  mergeAndSet(13, 17, currentRow, currentRow, '2º quadrante');
  mergeAndSet(18, 22, currentRow, currentRow, '3º quadrante');
  mergeAndSet(23, 27, currentRow, currentRow, '4º quadrante');

  // Nec. Tratamento - dividido em 4 quadrantes (5 colunas cada)
  mergeAndSet(28, 32, currentRow, currentRow, '1º quadrante');
  mergeAndSet(33, 37, currentRow, currentRow, '2º quadrante');
  mergeAndSet(38, 42, currentRow, currentRow, '3º quadrante');
  mergeAndSet(43, 47, currentRow, currentRow, '4º quadrante');

  // PUFA - dividido em 4 quadrantes (5 colunas cada)
  mergeAndSet(48, 52, currentRow, currentRow, '1º quadrante');
  mergeAndSet(53, 57, currentRow, currentRow, '2º quadrante');
  mergeAndSet(58, 62, currentRow, currentRow, '3º quadrante');
  mergeAndSet(63, 67, currentRow, currentRow, '4º quadrante');

  // Oclusão dentária
  mergeAndSet(68, 71, currentRow, currentRow, '');

  // Urgência
  mergeAndSet(72, 72, currentRow, currentRow, '');

  currentRow++;

  // 3) Linha 2 - Sub-subcategorias e dentes
  // Localização
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: currentRow), 'Cod. Município');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: currentRow), 'Estado');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: currentRow), 'Data Exame');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: currentRow), 'Endereço');

  // Informações Gerais
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: currentRow), 'Idade');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: currentRow), 'Data de Nascimento');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: currentRow), 'Sexo');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: currentRow), 'Cor/Raça');

  // Coroa - 4 quadrantes (5 dentes cada)
  int col = 8;
  for (var dente in dentesQ1) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), dente);
  }
  for (var dente in dentesQ2) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), dente);
  }
  for (var dente in dentesQ3) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), dente);
  }
  for (var dente in dentesQ4) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), dente);
  }

  // Nec. Tratamento - 4 quadrantes (5 dentes cada)
  for (var dente in dentesQ1) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), dente);
  }
  for (var dente in dentesQ2) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), dente);
  }
  for (var dente in dentesQ3) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), dente);
  }
  for (var dente in dentesQ4) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), dente);
  }

  // PUFA - 4 quadrantes (5 dentes cada)
  for (var dente in dentesQ1) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), dente);
  }
  for (var dente in dentesQ2) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), dente);
  }
  for (var dente in dentesQ3) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), dente);
  }
  for (var dente in dentesQ4) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), dente);
  }

  // Oclusão dentária (68-71)
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 68, rowIndex: currentRow), 'Chave Caninos');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 69, rowIndex: currentRow), 'Sobressaliência');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 70, rowIndex: currentRow), 'Sobremordida');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 71, rowIndex: currentRow), 'Mordida Cruzada Post.');

  // Urgência (coluna 72)
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 72, rowIndex: currentRow), '');

  // Estilizar essa linha de cabeçalho detalhado
  for (int c = 0; c <= 72; c++) {
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: c, rowIndex: currentRow)).cellStyle = headerStyle;
  }

  currentRow++;

  // --- Preencher os dados dos questionarios ---
  for (int i = 0; i < questionarios.length; i++) {
    var q = questionarios[i];
    int col = 0;

    // Localização
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.codigoMunicipio ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.estado ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.dataExame ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.endereco ?? '');

    // Informações Gerais
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.idade ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.dataNascimento ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.sexo ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.corRaca ?? '');

    // Coroa - 4 quadrantes (apenas os dentes especificados)
    for (var dente in dentesQ1) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.quadrante1[dente]?['coroa'] ?? '');
    }
    for (var dente in dentesQ2) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.quadrante2[dente]?['coroa'] ?? '');
    }
    for (var dente in dentesQ3) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.quadrante3[dente]?['coroa'] ?? '');
    }
    for (var dente in dentesQ4) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.quadrante4[dente]?['coroa'] ?? '');
    }

    // Nec. Tratamento - 4 quadrantes (apenas os dentes especificados)
    for (var dente in dentesQ1) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.quadrante1[dente]?['trat'] ?? '');
    }
    for (var dente in dentesQ2) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.quadrante2[dente]?['trat'] ?? '');
    }
    for (var dente in dentesQ3) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.quadrante3[dente]?['trat'] ?? '');
    }
    for (var dente in dentesQ4) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.quadrante4[dente]?['trat'] ?? '');
    }

    // PUFA - 4 quadrantes (apenas os dentes especificados)
    for (var dente in dentesQ1) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.quadrante1[dente]?['pufa'] ?? '');
    }
    for (var dente in dentesQ2) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.quadrante2[dente]?['pufa'] ?? '');
    }
    for (var dente in dentesQ3) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.quadrante3[dente]?['pufa'] ?? '');
    }
    for (var dente in dentesQ4) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.quadrante4[dente]?['pufa'] ?? '');
    }

    // Oclusão dentária (68-71)
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 68, rowIndex: currentRow), q.chaveCaninos ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 69, rowIndex: currentRow), q.sobressaliencia ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 70, rowIndex: currentRow), q.sobremordida ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 71, rowIndex: currentRow), q.mordidaCruzadaPosterior ?? '');

    // Urgência
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 72, rowIndex: currentRow), q.urgencia ?? '');

    currentRow++;
  }

  // Salvar arquivo
  final dir = await getExternalStorageDirectory();
  final filePath = '${dir!.path}/planilha_5.xlsx';
  final fileBytes = excel.save();
  File(filePath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(fileBytes!);
}