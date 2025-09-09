import 'dart:io';
import 'package:app_odonto/models/questionario.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

Future<void> criarExcelFaixa12(List<Questionario> questionarios) async {
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

  // 1) Linha 0 - Categorias principais (com Traumatismo dentário adicionado)
  mergeAndSet(0, 3, currentRow, currentRow, 'Localização');
  mergeAndSet(4, 7, currentRow, currentRow, 'Informações Gerais');
  mergeAndSet(8, 15, currentRow, currentRow, 'Traumatismo dentário'); // Nova categoria
  mergeAndSet(16, 47, currentRow, currentRow, 'Coroa');
  mergeAndSet(48, 79, currentRow, currentRow, 'Raiz');
  mergeAndSet(80, 111, currentRow, currentRow, 'Nec. Tratamento');
  mergeAndSet(112, 143, currentRow, currentRow, 'PUFA');
  mergeAndSet(144, 155, currentRow, currentRow, 'Condição periodontal'); // Reduzido (sem PIP)
  mergeAndSet(156, 166, currentRow, currentRow, 'DAI');
  mergeAndSet(167, 167, currentRow, currentRow, 'Urgência');

  currentRow++;

  // 2) Linha 1 - Subcategorias
  // Localização col 0-3
  mergeAndSet(0, 3, currentRow, currentRow, '');

  // Informações Gerais col 4-7
  mergeAndSet(4, 7, currentRow, currentRow, '');

  // Traumatismo dentário col 8-15 (sem subcategoria)
  mergeAndSet(8, 15, currentRow, currentRow, '');

  // Coroa - dividido em 4 quadrantes
  mergeAndSet(16, 23, currentRow, currentRow, '1º quadrante');
  mergeAndSet(24, 31, currentRow, currentRow, '2º quadrante');
  mergeAndSet(32, 39, currentRow, currentRow, '3º quadrante');
  mergeAndSet(40, 47, currentRow, currentRow, '4º quadrante');

  // Raiz - dividido em 4 quadrantes
  mergeAndSet(48, 55, currentRow, currentRow, '1º quadrante');
  mergeAndSet(56, 63, currentRow, currentRow, '2º quadrante');
  mergeAndSet(64, 71, currentRow, currentRow, '3º quadrante');
  mergeAndSet(72, 79, currentRow, currentRow, '4º quadrante');

  // Nec. Tratamento - dividido em 4 quadrantes
  mergeAndSet(80, 87, currentRow, currentRow, '1º quadrante');
  mergeAndSet(88, 95, currentRow, currentRow, '2º quadrante');
  mergeAndSet(96, 103, currentRow, currentRow, '3º quadrante');
  mergeAndSet(104, 111, currentRow, currentRow, '4º quadrante');

  // PUFA - dividido em 4 quadrantes
  mergeAndSet(112, 119, currentRow, currentRow, '1º quadrante');
  mergeAndSet(120, 127, currentRow, currentRow, '2º quadrante');
  mergeAndSet(128, 135, currentRow, currentRow, '3º quadrante');
  mergeAndSet(136, 143, currentRow, currentRow, '4º quadrante');

  // Condição periodontal (sem PIP)
  mergeAndSet(144, 149, currentRow, currentRow, 'Sangramento Gengival');
  mergeAndSet(150, 155, currentRow, currentRow, 'Cálculo Dentário');
  
  // DAI - Nova categoria com subcategorias
  mergeAndSet(156, 157, currentRow, currentRow, 'Dentição');
  mergeAndSet(158, 161, currentRow, currentRow, 'Oclusão');
  mergeAndSet(162, 166, currentRow, currentRow, 'Espaço');

  // Urgência
  mergeAndSet(167, 167, currentRow, currentRow, '');

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

  // Traumatismo dentário (colunas 8-15)
  List<String> traumatismoDentes = ['12', '11', '21', '22', '42', '41', '31', '32'];
  for (var dente in traumatismoDentes) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 8 + traumatismoDentes.indexOf(dente), rowIndex: currentRow), dente);
  }

  // Lista de dentes por quadrante
  List<String> dentesQ1 = ['18', '17', '16', '15', '14', '13', '12', '11'];
  List<String> dentesQ2 = ['21', '22', '23', '24', '25', '26', '27', '28'];
  List<String> dentesQ3 = ['38', '37', '36', '35', '34', '33', '32', '31'];
  List<String> dentesQ4 = ['41', '42', '43', '44', '45', '46', '47', '48'];

  // Coroa - 4 quadrantes
  int col = 16; // Início ajustado para 16 (anteriormente 8)
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

  // Condição periodontal (sem PIP)
  List<String> condDentes = ['16/17', '11', '26/27', '36/37', '31', '46/47'];
  
  // Sangramento Gengival (144-149)
  for (var dente in condDentes) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 144 + condDentes.indexOf(dente), rowIndex: currentRow), dente);
  }
  
  // Cálculo Dentário (150-155)
  for (var dente in condDentes) {
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 150 + condDentes.indexOf(dente), rowIndex: currentRow), dente);
  }

  // DAI - Nova categoria
  // Dentição (156-157)
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 156, rowIndex: currentRow), 'Sup.');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 157, rowIndex: currentRow), 'Inf.');
  
  // Oclusão (158-161)
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 158, rowIndex: currentRow), 'Overjet Max.');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 159, rowIndex: currentRow), 'Overjet Mand.');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 160, rowIndex: currentRow), 'Mordida Aberta');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 161, rowIndex: currentRow), 'Relação Molar');
  
  // Espaço (162-166)
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 162, rowIndex: currentRow), 'Apinhamento Inc.');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 163, rowIndex: currentRow), 'Espaçamento Inc.');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 164, rowIndex: currentRow), 'Diastema Inc.');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 165, rowIndex: currentRow), 'Desalinhamento Max.');
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 166, rowIndex: currentRow), 'Desalinhamento Mand.');

  // Urgência (coluna 167)
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 167, rowIndex: currentRow), '');

  // Estilizar essa linha de cabeçalho detalhado
  for (int c = 0; c <= 167; c++) {
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

    // Traumatismo dentário (colunas 8-15)
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.trauDentario12 ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.trauDentario11 ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.trauDentario21 ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.trauDentario22 ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.trauDentario42 ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.trauDentario41 ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.trauDentario31 ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: currentRow), q.trauDentario32 ?? '');

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

    // Condição periodontal (sem PIP)
    // Sangramento Gengival (144-149)
    for (var dente in condDentes) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 144 + condDentes.indexOf(dente), rowIndex: currentRow),
          q.condicaoPeriodontal[dente]?['Sangramento'] ?? '');
    }
    
    // Cálculo Dentário (150-155)
    for (var dente in condDentes) {
      sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 150 + condDentes.indexOf(dente), rowIndex: currentRow),
          q.condicaoPeriodontal[dente]?['Calculo'] ?? '');
    }

    // DAI - Nova categoria
    // Dentição (156-157)
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 156, rowIndex: currentRow), q.condDenticaoSup ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 157, rowIndex: currentRow), q.condDenticaoInf ?? '');
    
    // Oclusão (158-161)
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 158, rowIndex: currentRow), q.overjetMax ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 159, rowIndex: currentRow), q.overjetMand ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 160, rowIndex: currentRow), q.mordidaAberta ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 161, rowIndex: currentRow), q.relacaoMolar ?? '');
    
    // Espaço (162-166)
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 162, rowIndex: currentRow), q.apinhamentoIncisal ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 163, rowIndex: currentRow), q.espacamentoIncisal ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 164, rowIndex: currentRow), q.diastemaIncisal ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 165, rowIndex: currentRow), q.desalinhamentoMax ?? '');
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 166, rowIndex: currentRow), q.desalinhamentoMand ?? '');

    // Urgência
    sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: 167, rowIndex: currentRow), q.urgencia ?? '');

    currentRow++;
  }

  // Salvar arquivo
  final dir = await getExternalStorageDirectory();
  final filePath = '${dir!.path}/planilha_12.xlsx';
  final fileBytes = excel.save();
  File(filePath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(fileBytes!);
}