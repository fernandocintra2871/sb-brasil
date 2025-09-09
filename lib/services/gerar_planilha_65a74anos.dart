import 'dart:io';
import 'package:app_odonto/models/questionario.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

Future<void> criarExcelFaixa65a74(List<Questionario> questionarios) async {
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

  // 1) Linha 0 - Categorias principais (ajustado para incluir todas as subcategorias periodontais)
  mergeAndSet(0, 3, currentRow, currentRow, 'Localização');
  mergeAndSet(4, 7, currentRow, currentRow, 'Informações Gerais');
  mergeAndSet(8, 11, currentRow, currentRow, 'Uso e Nec. de Prótese');
  mergeAndSet(12, 43, currentRow, currentRow, 'Coroa');
  mergeAndSet(44, 75, currentRow, currentRow, 'Raiz');
  mergeAndSet(76, 107, currentRow, currentRow, 'Nec. Tratamento');
  mergeAndSet(108, 139, currentRow, currentRow, 'PUFA');
  mergeAndSet(140, 163, currentRow, currentRow, 'Condição periodontal'); // Aumentado para incluir todas subcategorias
  mergeAndSet(164, 164, currentRow, currentRow, 'Urgência');

  currentRow++;

  // 2) Linha 1 - Subcategorias
  // Localização col 0-3
  mergeAndSet(0, 3, currentRow, currentRow, '');

  // Informações Gerais col 4-7
  mergeAndSet(4, 7, currentRow, currentRow, '');

  // Uso e Nec. de Prótese
  mergeAndSet(8, 9, currentRow, currentRow, 'Uso Prótese');
  mergeAndSet(10, 11, currentRow, currentRow, 'Nec. Prótese');

  // Coroa - dividido em 4 quadrantes
  mergeAndSet(12, 19, currentRow, currentRow, '1º quadrante');
  mergeAndSet(20, 27, currentRow, currentRow, '2º quadrante');
  mergeAndSet(28, 35, currentRow, currentRow, '3º quadrante');
  mergeAndSet(36, 43, currentRow, currentRow, '4º quadrante');

  // Raiz - dividido em 4 quadrantes
  mergeAndSet(44, 51, currentRow, currentRow, '1º quadrante');
  mergeAndSet(52, 59, currentRow, currentRow, '2º quadrante');
  mergeAndSet(60, 67, currentRow, currentRow, '3º quadrante');
  mergeAndSet(68, 75, currentRow, currentRow, '4º quadrante');

  // Nec. Tratamento - dividido em 4 quadrantes
  mergeAndSet(76, 83, currentRow, currentRow, '1º quadrante');
  mergeAndSet(84, 91, currentRow, currentRow, '2º quadrante');
  mergeAndSet(92, 99, currentRow, currentRow, '3º quadrante');
  mergeAndSet(100, 107, currentRow, currentRow, '4º quadrante');

  // PUFA - dividido em 4 quadrantes
  mergeAndSet(108, 115, currentRow, currentRow, '1º quadrante');
  mergeAndSet(116, 123, currentRow, currentRow, '2º quadrante');
  mergeAndSet(124, 131, currentRow, currentRow, '3º quadrante');
  mergeAndSet(132, 139, currentRow, currentRow, '4º quadrante');

  // Condição periodontal - agora com todas as subcategorias
  mergeAndSet(140, 145, currentRow, currentRow, 'Sangramento Gengival');
  mergeAndSet(146, 151, currentRow, currentRow, 'Cálculo Dentário'); // Adicionado
  mergeAndSet(152, 157, currentRow, currentRow, 'Bolsa Periodontal');
  mergeAndSet(158, 163, currentRow, currentRow, 'PIP'); // Adicionado

  // Urgência
  mergeAndSet(164, 164, currentRow, currentRow, '');

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

  // Uso e Nec. de Prótese
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: currentRow), 'Sup.');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: currentRow), 'Inf.');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: currentRow), 'Sup.');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: currentRow), 'Inf.');

  // Lista de dentes por quadrante
  List<String> dentesQ1 = ['18', '17', '16', '15', '14', '13', '12', '11'];
  List<String> dentesQ2 = ['21', '22', '23', '24', '25', '26', '27', '28'];
  List<String> dentesQ3 = ['38', '37', '36', '35', '34', '33', '32', '31'];
  List<String> dentesQ4 = ['41', '42', '43', '44', '45', '46', '47', '48'];

  // Coroa - 4 quadrantes
  int col = 12;
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

  // Raiz - 4 quadrantes
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

  // Nec. Tratamento - 4 quadrantes
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

  // PUFA - 4 quadrantes
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

  // Condição periodontal - agora com todas as subcategorias
  List<String> condDentes = ['16/17', '11', '26/27', '36/37', '31', '46/47'];
  
  // Sangramento Gengival (140-145)
  for (var dente in condDentes) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 140 + condDentes.indexOf(dente), rowIndex: currentRow), dente);
  }
  
  // Cálculo Dentário (146-151) - Adicionado
  for (var dente in condDentes) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 146 + condDentes.indexOf(dente), rowIndex: currentRow), dente);
  }
  
  // Bolsa Periodontal (152-157)
  for (var dente in condDentes) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 152 + condDentes.indexOf(dente), rowIndex: currentRow), dente);
  }
  
  // PIP (158-163) - Adicionado
  for (var dente in condDentes) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 158 + condDentes.indexOf(dente), rowIndex: currentRow), dente);
  }

  // Urgência (coluna 164)
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 164, rowIndex: currentRow), '');

  // Estilizar essa linha de cabeçalho detalhado
  for (int c = 0; c <= 164; c++) {
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

    // Uso e Nec. de Prótese
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.usoProteseSup ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.usoProteseInf ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.necProteseSup ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.necProteseInf ?? '');

    // Coroa - 4 quadrantes
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

    // Raiz - 4 quadrantes
    for (var dente in dentesQ1) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.quadrante1[dente]?['raiz'] ?? '');
    }
    for (var dente in dentesQ2) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.quadrante2[dente]?['raiz'] ?? '');
    }
    for (var dente in dentesQ3) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.quadrante3[dente]?['raiz'] ?? '');
    }
    for (var dente in dentesQ4) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.quadrante4[dente]?['raiz'] ?? '');
    }

    // Nec. Tratamento - 4 quadrantes
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

    // PUFA - 4 quadrantes
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

    // Condição periodontal - agora com todas as subcategorias
    // Sangramento Gengival (140-145)
    for (var dente in condDentes) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 140 + condDentes.indexOf(dente), rowIndex: currentRow),
          q.condicaoPeriodontal[dente]?['Sangramento'] ?? '');
    }
    
    // Cálculo Dentário (146-151) - Adicionado
    for (var dente in condDentes) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 146 + condDentes.indexOf(dente), rowIndex: currentRow),
          q.condicaoPeriodontal[dente]?['Calculo'] ?? '');
    }
    
    // Bolsa Periodontal (152-157)
    for (var dente in condDentes) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 152 + condDentes.indexOf(dente), rowIndex: currentRow),
          q.condicaoPeriodontal[dente]?['Bolsa'] ?? '');
    }
    
    // PIP (158-163) - Adicionado
    for (var dente in condDentes) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 158 + condDentes.indexOf(dente), rowIndex: currentRow),
          q.condicaoPeriodontal[dente]?['PIP'] ?? '');
    }

    // Urgência
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 164, rowIndex: currentRow), q.urgencia ?? '');

    currentRow++;
  }

  // Salvar arquivo
  final dir = await getExternalStorageDirectory();
  final filePath = '${dir!.path}/planilha_65a74.xlsx';
  final fileBytes = excel.save();
  File(filePath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(fileBytes!);
}