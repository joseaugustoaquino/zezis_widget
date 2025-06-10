// ignore_for_file: public_member_api_docs
import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:zezis_widget/src/models/kanban/card_kanban_model.dart';

/// Modelo que representa uma coluna no Kanban.
/// 
/// Uma coluna contém uma lista de cards e possui propriedades como título,
/// cor e prioridade para organização visual.
class ColumnKanbanModel {
  /// Identificador único da coluna
  int id;
  
  /// Prioridade da coluna para ordenação
  int priority;
  bool orderBy;
  
  /// Cor de destaque da coluna
  Color color;
  
  /// Título da coluna
  String title;
  
  /// Lista de cards contidos na coluna
  List<CardKanbanModel> cards;

  /// Selecionar itens da coluna
  bool? selectionColumn;

  /// Construtor da coluna Kanban
  /// 
  /// [id] - Identificador único da coluna
  /// [priority] - Prioridade para ordenação (padrão: 0)
  /// [color] - Cor de destaque (padrão: Colors.blue)
  /// [title] - Título da coluna
  /// [cards] - Lista inicial de cards (padrão: lista vazia)
  /// [selectionColumn] - Selecionar itens da coluna (padrão: desmarcado)
  ColumnKanbanModel({
    required this.id,
    this.priority = 0,
    this.orderBy = false,
    this.color = Colors.blue,
    required this.title,
    List<CardKanbanModel>? cards,
    this.selectionColumn
  }) : cards = cards ?? [];

  /// Cria uma cópia do modelo com campos opcionais atualizados
  ColumnKanbanModel copyWith({
    int? id,
    int? priority,
    bool? orderBy,
    Color? color,
    String? title,
    List<CardKanbanModel>? cards,
    bool? selectionColumn,
  }) {
    return ColumnKanbanModel(
      id: id ?? this.id,
      priority: priority ?? this.priority,
      orderBy: orderBy ?? this.orderBy,
      color: color ?? this.color,
      title: title ?? this.title,
      cards: cards ?? this.cards,
      selectionColumn: selectionColumn ?? this.selectionColumn,
    );
  }

  /// Converte o modelo para um Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'priority': priority,
      'orderBy': orderBy,
      'color': color.toARGB32(),
      'title': title,
      'cards': cards.map((x) => x.toMap()).toList(),
      'selectionColumn': selectionColumn,
    };
  }

  /// Cria um modelo a partir de um Map
  factory ColumnKanbanModel.fromMap(Map<String, dynamic> map) {
    return ColumnKanbanModel(
      id: map['id'] as int,
      priority: map['priority'] as int? ?? 0,
      orderBy: map['orderBy'] as bool? ?? false,
      color: map['color'] != null 
          ? Color(map['color'] as int) 
          : Colors.blue,
      title: map['title'] as String,
      selectionColumn: map['selectionColumn'],
      cards: map['cards'] != null 
          ? List<CardKanbanModel>.from(
              (map['cards'] as List<dynamic>).map<CardKanbanModel>(
                (x) => CardKanbanModel.fromMap(x as Map<String,dynamic>),
              ),
            )
          : null,
    );
  }

  /// Cria uma nova coluna com título especificado
  /// 
  /// Gera um ID único baseado em timestamp e número aleatório
  factory ColumnKanbanModel.create(String title) {
    final id = Random().nextInt(100) + DateTime.now().microsecond;
    
    return ColumnKanbanModel(
      id: id,
      title: title,
    );
  }

  /// Converte o modelo para JSON
  String toJson() => json.encode(toMap());

  /// Cria um modelo a partir de uma string JSON
  factory ColumnKanbanModel.fromJson(String source) => 
      ColumnKanbanModel.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Adiciona um card à coluna
  ColumnKanbanModel addCard(CardKanbanModel card) {
    return copyWith(cards: [...cards, card]);
  }

  /// Remove um card da coluna pelo ID
  ColumnKanbanModel removeCard(int cardId) {
    return copyWith(
      cards: cards.where((card) => card.id != cardId).toList(),
    );
  }

  /// Atualiza um card existente
  ColumnKanbanModel updateCard(CardKanbanModel updatedCard) {
    return copyWith(
      cards: cards.map((card) => 
        card.id == updatedCard.id ? updatedCard : card
      ).toList(),
    );
  }

  /// Reordena os cards na coluna
  ColumnKanbanModel reorderCards(int oldIndex, int newIndex) {
    final newCards = List<CardKanbanModel>.from(cards);
    final card = newCards.removeAt(oldIndex);
    newCards.insert(newIndex, card);
    return copyWith(cards: newCards);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ColumnKanbanModel &&
        other.id == id &&
        other.priority == priority &&
        other.orderBy == orderBy &&
        other.color == color &&
        other.title == title &&
        other.selectionColumn == selectionColumn &&
        listEquals(other.cards, cards);
  }

  @override
  int get hashCode {
    return Object.hash(id, priority, orderBy, color, title, Object.hashAll(cards), selectionColumn);
  }
}
