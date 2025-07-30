class Questionario {
  // Localização
  String? codigoMunicipio;
  String? estado;
  String? dataExame;
  String? endereco;

  // Informações gerais
  String? idade;
  String? dataNascimento;
  String? sexo;
  String? corRaca;

  // Uso e necessidade de prótese
  String? usoProteseSup;
  String? usoProteseInf;
  String? necProteseSup;
  String? necProteseInf;

  // Traumatismo dentário
  String? trauDentario12;
  String? trauDentario11;
  String? trauDentario21;
  String? trauDentario22;
  String? trauDentario32;
  String? trauDentario31;
  String? trauDentario41;
  String? trauDentario42;

  // Condição da oclusão dentária
  String? chaveCaninos;
  String? sobressaliencia;
  String? sobremordida;
  String? mordidaCruzadaPosterior;

  // DAI - Dentição
  String? condDenticaoSup;
  String? condDenticaoInf;

  // Overjet
  String? overjetMax;
  String? overjetMand;
  String? mordidaAberta;

  // Relação Molar
  String? relacaoMolar;

  // Espaço
  String? apinhamentoIncisal;
  String? espacamentoIncisal;
  String? diastemaIncisal;
  String? desalinhamentoMax;
  String? desalinhamentoMand;

  // Cárie
  Map<String, Map<String, String?>> quadrante1 = {};
  Map<String, Map<String, String?>> quadrante2 = {};
  Map<String, Map<String, String?>> quadrante3 = {};
  Map<String, Map<String, String?>> quadrante4 = {};

  // Condição Periodontal
  Map<String, Map<String, String?>> condicaoPeriodontal = {};

  // Urgência
  String? urgencia;

  // Construtor
  Questionario() {
    // Inicializa quadrantes para cárie com as chaves e valores vazios
    quadrante1 = _criarMapaQuadrante(['18', '17', '16', '55', '15', '54', '14', '53', '13', '52', '12', '51', '11']);
    quadrante2 = _criarMapaQuadrante(['61', '21', '62', '22', '63', '23', '64', '24', '65', '25', '26', '27', '28']);
    quadrante3 = _criarMapaQuadrante(['71', '31', '72', '32', '73', '33', '74', '34', '75', '35', '36', '37', '38']);
    quadrante4 = _criarMapaQuadrante(['48', '47', '46', '85', '45', '84', '44', '82', '42', '81', '41']);

    // Inicializar condicaoPeriodontal
    condicaoPeriodontal = _criarMapaCondicaoPeriodontal(['16/17', '11', '26/27', '46/47', '31', '36/37']);
  }

  Map<String, Map<String, String?>> _criarMapaQuadrante(List<String> dentes) {
    final Map<String, Map<String, String?>> mapa = {};
    for (final dente in dentes) {
      mapa[dente] = {
        'coroa': null,
        'raiz': null,
        'trat': null,
      };
    }
    return mapa;
  }

    Map<String, Map<String, String?>> _criarMapaCondicaoPeriodontal(List<String> dentes) {
    final Map<String, Map<String, String?>> mapa = {};
    for (final dente in dentes) {
      mapa[dente] = {
        'Sangramento': null, 
        'Calculo': null, 
        'Bolsa': null, 
        'PIP': null
      };
    }
    return mapa;
  }
}
