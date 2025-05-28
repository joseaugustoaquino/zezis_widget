// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/material.dart';

/// Modelo que representa um card no Kanban.
/// 
/// Este modelo contém todas as informações necessárias para exibir e gerenciar
/// um card no sistema de Kanban, incluindo informações do curso, turma, pessoa,
/// status e dados de esquecimento.
class CardKanbanModel {
  /// Identificador único do card
  int? id;

  /// Informações do curso
  String? courseDescription;
  int? idCourse;

  /// Informações da turma
  String? classDescription;
  int? idTurma;

  /// Informações da pessoa
  String? personDescription;
  int? idPersonal;

  /// Informações do kanban
  String? kanbanDescription;
  int? idKanban;

  /// Informações da fonte de indicação
  String? sourceIndicationDescription;
  int? idIndicatesFont;

  /// Informações do município
  String? municipalityDescription;
  int? idMunicipality;

  /// Informações do usuário
  String? userDescription;
  int? idUser;

  /// Dados básicos do card
  String? title;
  String? origin;
  String? observation;
  double currency;
  bool selected;
  DateTime? registrationDate;

  /// Status do card
  Color? colorStatus;
  String? descriptionStatus;

  /// Informações de esquecimento
  int? dayForgotten;
  Color? colorForgotten;

  /// Widgets personalizados
  List<Widget>? bodyCard;
  List<Widget>? footerCard;

  /// Construtor principal do modelo
  CardKanbanModel({
    this.id,
    this.courseDescription,
    this.idCourse,
    this.classDescription,
    this.idTurma,
    this.personDescription,
    this.idPersonal,
    this.kanbanDescription,
    this.idKanban,
    this.sourceIndicationDescription,
    this.idIndicatesFont,
    this.municipalityDescription,
    this.idMunicipality,
    this.userDescription,
    this.idUser,
    this.title,
    this.origin,
    this.observation,
    this.currency = 0.0,
    this.selected = false,
    this.registrationDate,
    this.colorStatus,
    this.descriptionStatus,
    this.dayForgotten,
    this.colorForgotten,
    this.bodyCard,
    this.footerCard,
  });

  /// Cria uma cópia do modelo com campos atualizados
  CardKanbanModel copyWith({
    int? id,
    String? courseDescription,
    int? idCourse,
    String? classDescription,
    int? idTurma,
    String? personDescription,
    int? idPersonal,
    String? kanbanDescription,
    int? idKanban,
    String? sourceIndicationDescription,
    int? idIndicatesFont,
    String? municipalityDescription,
    int? idMunicipality,
    String? userDescription,
    int? idUser,
    String? title,
    String? origin,
    String? observation,
    double? currency,
    bool? selected,
    DateTime? registrationDate,
    Color? colorStatus,
    String? descriptionStatus,
    int? dayForgotten,
    Color? colorForgotten,
    List<Widget>? bodyCard,
    List<Widget>? footerCard,
  }) {
    return CardKanbanModel(
      id: id ?? this.id,
      courseDescription: courseDescription ?? this.courseDescription,
      idCourse: idCourse ?? this.idCourse,
      classDescription: classDescription ?? this.classDescription,
      idTurma: idTurma ?? this.idTurma,
      personDescription: personDescription ?? this.personDescription,
      idPersonal: idPersonal ?? this.idPersonal,
      kanbanDescription: kanbanDescription ?? this.kanbanDescription,
      idKanban: idKanban ?? this.idKanban,
      sourceIndicationDescription: sourceIndicationDescription ?? this.sourceIndicationDescription,
      idIndicatesFont: idIndicatesFont ?? this.idIndicatesFont,
      municipalityDescription: municipalityDescription ?? this.municipalityDescription,
      idMunicipality: idMunicipality ?? this.idMunicipality,
      userDescription: userDescription ?? this.userDescription,
      idUser: idUser ?? this.idUser,
      title: title ?? this.title,
      origin: origin ?? this.origin,
      observation: observation ?? this.observation,
      currency: currency ?? this.currency,
      selected: selected ?? this.selected,
      registrationDate: registrationDate ?? this.registrationDate,
      colorStatus: colorStatus ?? this.colorStatus,
      descriptionStatus: descriptionStatus ?? this.descriptionStatus,
      dayForgotten: dayForgotten ?? this.dayForgotten,
      colorForgotten: colorForgotten ?? this.colorForgotten,
      bodyCard: bodyCard ?? this.bodyCard,
      footerCard: footerCard ?? this.footerCard,
    );
  }

  /// Converte o modelo para um Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'courseDescription': courseDescription,
      'idCourse': idCourse,
      'classDescription': classDescription,
      'idTurma': idTurma,
      'personDescription': personDescription,
      'idPersonal': idPersonal,
      'kanbanDescription': kanbanDescription,
      'idKanban': idKanban,
      'sourceIndicationDescription': sourceIndicationDescription,
      'idIndicatesFont': idIndicatesFont,
      'municipalityDescription': municipalityDescription,
      'idMunicipality': idMunicipality,
      'userDescription': userDescription,
      'idUser': idUser,
      'title': title,
      'origin': origin,
      'observation': observation,
      'currency': currency,
      'selected': selected,
      'registrationDate': registrationDate?.toIso8601String(),
      'colorStatus': colorStatus?.toARGB32(),
      'descriptionStatus': descriptionStatus,
      'dayForgotten': dayForgotten,
      'colorForgotten': colorForgotten?.toARGB32(),
    };
  }

  /// Cria um modelo a partir de um Map
  factory CardKanbanModel.fromMap(Map<String, dynamic> map) {
    return CardKanbanModel(
      id: map['id'] as int?,
      courseDescription: map['courseDescription'] as String?,
      idCourse: map['idCourse'] as int?,
      classDescription: map['classDescription'] as String?,
      idTurma: map['idTurma'] as int?,
      personDescription: map['personDescription'] as String?,
      idPersonal: map['idPersonal'] as int?,
      kanbanDescription: map['kanbanDescription'] as String?,
      idKanban: map['idKanban'] as int?,
      sourceIndicationDescription: map['sourceIndicationDescription'] as String?,
      idIndicatesFont: map['idIndicatesFont'] as int?,
      municipalityDescription: map['municipalityDescription'] as String?,
      idMunicipality: map['idMunicipality'] as int?,
      userDescription: map['userDescription'] as String?,
      idUser: map['idUser'] as int?,
      title: map['title'] as String?,
      origin: map['origin'] as String?,
      observation: map['observation'] as String?,
      currency: (map['currency'] as num?)?.toDouble() ?? 0.0,
      selected: map['selected'] as bool? ?? false,
      registrationDate: map['registrationDate'] != null 
          ? DateTime.parse(map['registrationDate'] as String)
          : null,
      colorStatus: map['colorStatus'] != null 
          ? Color(map['colorStatus'] as int)
          : null,
      descriptionStatus: map['descriptionStatus'] as String?,
      dayForgotten: map['dayForgotten'] as int?,
      colorForgotten: map['colorForgotten'] != null 
          ? Color(map['colorForgotten'] as int)
          : null,
    );
  }

  /// Cria um modelo com dados de exemplo
  factory CardKanbanModel.create({
    required int id,
    String? title,
    Color? colorStatus,
    String? descriptionStatus,
    int? dayForgotten,
    Color? colorForgotten,
    List<Widget>? bodyCard,
    List<Widget>? footerCard,
    bool selected = false,
  }) {
    return CardKanbanModel(
      id: id,
      courseDescription: "Lorem Course",
      idCourse: id,
      classDescription: "Lorem Class",
      idTurma: id,
      personDescription: "Lorem Person",
      idPersonal: id,
      kanbanDescription: "Lorem Kanban",
      idKanban: id,
      sourceIndicationDescription: "Lorem Source",
      idIndicatesFont: id,
      municipalityDescription: "Lorem Municipality",
      idMunicipality: id,
      userDescription: "Lorem User",
      idUser: id,
      title: title,
      origin: "Lorem Lorem",
      observation: "Lorem Lorem",
      currency: id.toDouble(),
      selected: selected,
      registrationDate: DateTime.now(),
      colorStatus: colorStatus,
      descriptionStatus: descriptionStatus,
      dayForgotten: dayForgotten,
      colorForgotten: colorForgotten,
      bodyCard: bodyCard,
      footerCard: footerCard,
    );
  }

  /// Converte o modelo para JSON
  String toJson() => json.encode(toMap());

  /// Cria um modelo a partir de JSON
  factory CardKanbanModel.fromJson(String source) => 
      CardKanbanModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CardKanbanModel &&
      other.id == id &&
      other.courseDescription == courseDescription &&
      other.idCourse == idCourse &&
      other.classDescription == classDescription &&
      other.idTurma == idTurma &&
      other.personDescription == personDescription &&
      other.idPersonal == idPersonal &&
      other.kanbanDescription == kanbanDescription &&
      other.idKanban == idKanban &&
      other.sourceIndicationDescription == sourceIndicationDescription &&
      other.idIndicatesFont == idIndicatesFont &&
      other.municipalityDescription == municipalityDescription &&
      other.idMunicipality == idMunicipality &&
      other.userDescription == userDescription &&
      other.idUser == idUser &&
      other.title == title &&
      other.origin == origin &&
      other.observation == observation &&
      other.currency == currency &&
      other.selected == selected &&
      other.registrationDate == registrationDate &&
      other.colorStatus == colorStatus &&
      other.descriptionStatus == descriptionStatus &&
      other.dayForgotten == dayForgotten &&
      other.colorForgotten == colorForgotten;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      courseDescription.hashCode ^
      idCourse.hashCode ^
      classDescription.hashCode ^
      idTurma.hashCode ^
      personDescription.hashCode ^
      idPersonal.hashCode ^
      kanbanDescription.hashCode ^
      idKanban.hashCode ^
      sourceIndicationDescription.hashCode ^
      idIndicatesFont.hashCode ^
      municipalityDescription.hashCode ^
      idMunicipality.hashCode ^
      userDescription.hashCode ^
      idUser.hashCode ^
      title.hashCode ^
      origin.hashCode ^
      observation.hashCode ^
      currency.hashCode ^
      selected.hashCode ^
      registrationDate.hashCode ^
      colorStatus.hashCode ^
      descriptionStatus.hashCode ^
      dayForgotten.hashCode ^
      colorForgotten.hashCode;
  }
}
