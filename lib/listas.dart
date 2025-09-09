// lib/listas.dart

const List<String> listaEstados = [
  'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA',
  'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN',
  'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
];


final List<String> listaSexo = ['1 - Masculino', '2 - Feminino'];

final List<String> listaCorRaca = [
  '1 - Branca',
  '2 - Preta',
  '3 - Amarela',
  '4 - Parda',
  '5 - Indigena',
  '6 - Não sabe/Não Respondeu'
];

final List<String> listaUsoProtese = [
  '0 - Não usa',
  '1 - Uma ponte fixa',
  '2 - Mais de uma ponte fixa',
  '3 - Prótese Parcial Removível',
  '4 - Prótese Fixa + Removível',
  '5 - Prótese Total',
  '9 - Sem Informação'
];

final List<String> listaNecProtese = [
  '0 - Não necessita',
  '1 - Prótese de 1 elemento',
  '2 - Mais de 1 elemento',
  '3 - Combinação de Próteses',
  '4 - Prótese Total',
  '9 - Sem Informação'
];

final List<String> listaTrauDentario = [
  '0 - Nenhum traumatismo',
  '1 - Fratura de esmalte',
  '2 - Fratura de esmalte e dentina',
  '3 - Fratura de esmalte e dentina com exposição pulpar',
  '4 - Ausência do dente devido a traumatismo',
  '9 - Sem Informação'
];

final List<String> listaChaveCaninos = [
  '0 - Classe I',
  '1 - Classe II',
  '2 - Classe III',
  '9 - Sem Informação'
];

final List<String> listaSobressaliencia = [
  '0 - Normal',
  '1 - Aumentado',
  '2 - Topo a topo',
  '3 - Cruzada Anterior',
  '9 - Sem Informação'
];

final List<String> listaSobremordida = [
  '0 - Normal',
  '1 - Reduzida',
  '2 - Aberta',
  '3 - Profunda',
  '9 - Sem Informação'
];

final List<String> listaMordidaCruzadaPosterior = [
  '0 - Presença',
  '1 - Ausência',
  '9 - Sem Informação'
];

final List<String> listaCondDenticao = ['0','1','2','3','4','5','6','7','8','9','T','X'];

final List<String> listaOverjet = ['0','1','2','3','4','5','6','7','8','9','X'];

final List<String> listaRelacaoMolar = [
  '0 - Normal',
  '1 - Meia Cúspide',
  '2 - Cúspide Inteira',
  'X - Sem Informação'
];

final List<String> listaApinhamento = [
  '0 - Sem Apinhamento',
  '1 - Apinhamento em um segmento',
  '2 - Apinhamento nos dois segmentos',
  'X - Sem Informação'
];

final List<String> listaEspacamento = [
  '0 - Sem Espaçamento',
  '1 - Espaçamento em um segmento',
  '2 - Espaçamento nos dois segmentos',
  'X - Sem Informação'
];

final List<String> listaMilimetrosOuX = ['0','1','2','3','4','5','6','7','8','9','X'];

final List<String> listaCoroa = [
  '0 - Hígido',
  '1 - Cariado',
  '2 - Restaurado mas com cárie',
  '3 - Restaurado e sem cárie',
  '4 - Não se aplica Perdido devido à cárie',
  '5 - Não se aplica Perdido por outras razões',
  '6 - Não se aplica Apresenta selante',
  '7 - Apoio de ponte ou coroa',
  '8 - Não erupcionado - raiz não exposta',
  'T - Não se aplica Trauma (fratura)',
  '9 - Dente excluído'
];

final List<String> listaCoroaDec = [
  'A - Hígido',
  'B - Cariado',
  'C - Restaurado mas com cárie',
  'D - Restaurado e sem cárie',
  'E - Não se aplica Perdido devido à cárie',
  'F - Não se aplica Apresenta selante',
  'G - Apoio de ponte ou coroa'
];

final List<String> listaRaiz = [
  '0 - Hígido',
  '1 - Cariado',
  '2 - Restaurado mas com cárie',
  '3 - Restaurado e sem cárie',
  '7 - Apoio de ponte ou coroa',
  '8 - Não erupcionado - raiz não exposta',
  '9 - Dente excluído'
];

final List<String> listaTrat = [
  '0 - Nenhum',
  '1 - Restauração de 1 superfície',
  '2 - Restauração de 2 ou mais superfícies',
  '3 - Coroa por qualquer razão',
  '4 - Faceta estética',
  '5 - Tratamento pulpar e restauração',
  '6 - Extração',
  '7 - Remineralização de mancha branca',
  '8 - Selante',
  '9 - Sem informação'
];



final List<String> listaPUFA = [
  '0 - Nenhuma consequência clínica de cárie não tratada ',
  'P - Envolvimento pulpar ',
  'U - Ulceração',
  'F - Fístula ',
  'A - Abscesso',
  '9 - Dente excluído'
];

final List<String> listaPUFADec = [
  '0 - Nenhuma consequência clínica de cárie não tratada ',
  'p - Envolvimento pulpar ',
  'u - Ulceração',
  'f - Fístula ',
  'a - Abscesso',
  '9 - Dente excluído'
];

final List<String> listaSCBX = [
  '0 - Ausência',
  '1 - Presença',
  'X - Excluído',
  '9 - Não Examinado'
];

final List<String> listaBolsa = [
  '0 - Ausência',
  '1 - Presença de Bolsa Rasa',
  '2 - Presença de Bolsa Profunda',
  'X - Excluído',
  '9 - Não Examinado'
];

final List<String> listaPIP = [
  '0 - Perda entre 0 a 3 mm',
  '1 - Perda entre 4 e 5 mm',
  '2 - Perda entre 6 e 8 mm',
  '3 - Perda entre 9 e 11 mm',
  '4 - Perda de 12 mm ou mais',
  'X - Excluído',
  '9 - Não Examinado'
];

final List<String> listaUrgencia = [
  '0 - Sem necessidade de tratamento',
  '1 - Necessidade de tratamento preventivo ou de rotina.',
  '2 - Necessidade de tratamento imediato',
  '3 - Necessidade urgente de tratamento devido à dor ou infecção dentária/de origem bucal',
  '4 - Encaminhamento para avaliação abrangente ou tratamento médico/odontológico'
];

