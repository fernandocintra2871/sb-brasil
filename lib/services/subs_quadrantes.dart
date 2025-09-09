import 'package:app_odonto/models/questionario.dart';

void substituirParesDentesEmLista(List<Questionario> questionarios) {
  // Definir os pares de dentes para cada quadrante
  final paresQuadrantes = {
    'quadrante1': [
      ['55', '15'],
      ['54', '14'],
      ['53', '13'],
      ['52', '12'],
      ['51', '11'],
    ],
    'quadrante2': [
      ['61', '21'],
      ['62', '22'],
      ['63', '23'],
      ['64', '24'],
      ['65', '25'],
    ],
    'quadrante3': [
      ['71', '31'],
      ['72', '32'],
      ['73', '33'],
      ['74', '34'],
      ['75', '35'],
    ],
    'quadrante4': [
      ['85', '45'],
      ['84', '44'],
      ['83', '43'],
      ['82', '42'],
      ['81', '41'],
    ],
  };

  // Função auxiliar para verificar se um valor é nulo ou vazio
  bool _isNullOrEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  // Processar cada questionário
  for (final questionario in questionarios) {
    // Processar cada quadrante
    for (final entry in paresQuadrantes.entries) {
      final quadranteNome = entry.key;
      final pares = entry.value;

      // Obter o quadrante correspondente
      Map<String, Map<String, String?>> quadrante;
      switch (quadranteNome) {
        case 'quadrante1':
          quadrante = questionario.quadrante1;
          break;
        case 'quadrante2':
          quadrante = questionario.quadrante2;
          break;
        case 'quadrante3':
          quadrante = questionario.quadrante3;
          break;
        case 'quadrante4':
          quadrante = questionario.quadrante4;
          break;
        default:
          continue;
      }

      // Processar cada par
      for (final par in pares) {
        final denteOrigem = par[0];
        final denteDestino = par[1];

        // Verificar se ambos existem
        if (quadrante.containsKey(denteOrigem) && quadrante.containsKey(denteDestino)) {
          final dadosOrigem = quadrante[denteOrigem]!;
          final dadosDestino = quadrante[denteDestino]!;

          // Substituir apenas campos não-nulos e não-vazios
          if (!_isNullOrEmpty(dadosOrigem['coroa'])) {
            dadosDestino['coroa'] = dadosOrigem['coroa'];
          }
          if (!_isNullOrEmpty(dadosOrigem['raiz'])) {
            dadosDestino['raiz'] = dadosOrigem['raiz'];
          }
          if (!_isNullOrEmpty(dadosOrigem['trat'])) {
            dadosDestino['trat'] = dadosOrigem['trat'];
          }
          if (!_isNullOrEmpty(dadosOrigem['pufa'])) {
            dadosDestino['pufa'] = dadosOrigem['pufa'];
          }
        }
      }
    }
  }
}