import 'dart:convert';

class PaisModel {
  int? id;
  int? ddi;
  int? codigo;
  int? codigoBacen;

  String descricao;
  String sigla2;
  String sigla3;
  String mascaraTelefone;
  String mascaraCelular;

  PaisModel({
    this.id,
    this.ddi,
    this.codigo,
    this.codigoBacen,

    this.descricao = "",
    this.sigla2 = "",
    this.sigla3 = "",
    this.mascaraTelefone = "",
    this.mascaraCelular = "",
  }); 
  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ddi': ddi,
      'codigo': codigo,
      'codigoBacen': codigoBacen,
      'descricao': descricao,
      'sigla2': sigla2,
      'sigla3': sigla3,
      'mascaraTelefone': mascaraTelefone,
      'mascaraCelular': mascaraCelular,
    };
  }

  static PaisModel fromMap(Map<String, dynamic> map) {
    return PaisModel(
      id: map['id'],
      ddi: map['ddi'],
      codigo: map['codigo'],
      codigoBacen: map['codigoBacen'],
      descricao: map['descricao'] ?? "",
      sigla2: map['sigla2'] ?? "",
      sigla3: map['sigla3'] ?? "",
      mascaraTelefone: map['mascaraTelefone'] ?? "",
      mascaraCelular: map['mascaraCelular'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory PaisModel.fromJson(String source) => PaisModel.fromMap(json.decode(source) as Map<String, dynamic>);
}