import 'package:uuid/uuid.dart';

class KanbanBoard {
  final String id;
  final String title;
  final List<KanbanColumn> columns;

  KanbanBoard({
    required this.id,
    required this.title,
    required this.columns,
  });

  factory KanbanBoard.create(String title) {
    return KanbanBoard(
      id: const Uuid().v4(),
      title: title,
      columns: [
        KanbanColumn.create('In Negotiation'),
        KanbanColumn.create('Payment'),
        KanbanColumn.create('Paused'),
        KanbanColumn.create('Lost'),
      ],
    );
  }

  KanbanBoard copyWith({
    String? title,
    List<KanbanColumn>? columns,
  }) {
    return KanbanBoard(
      id: id,
      title: title ?? this.title,
      columns: columns ?? this.columns,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'columns': columns.map((column) => column.toJson()).toList(),
    };
  }

  factory KanbanBoard.fromJson(Map<String, dynamic> json) {
    return KanbanBoard(
      id: json['id'] as String,
      title: json['title'] as String,
      columns: (json['columns'] as List)
          .map((column) => KanbanColumn.fromJson(column))
          .toList(),
    );
  }
}

class KanbanColumn {
  final String id;
  final String title;
  final List<KanbanCard> cards;

  KanbanColumn({
    required this.id,
    required this.title,
    required this.cards,
  });

  factory KanbanColumn.create(String title) {
    return KanbanColumn(
      id: const Uuid().v4(),
      title: title,
      cards: [],
    );
  }

  KanbanColumn copyWith({
    String? title,
    List<KanbanCard>? cards,
  }) {
    return KanbanColumn(
      id: id,
      title: title ?? this.title,
      cards: cards ?? this.cards,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'cards': cards.map((card) => card.toJson()).toList(),
    };
  }

  factory KanbanColumn.fromJson(Map<String, dynamic> json) {
    return KanbanColumn(
      id: json['id'] as String,
      title: json['title'] as String,
      cards: (json['cards'] as List)
          .map((card) => KanbanCard.fromJson(card))
          .toList(),
    );
  }
}

class KanbanCard {
  final String id;
  final String title;
  final String description;
  final String color;
  final DateTime createdAt;

  KanbanCard({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.createdAt,
  });

  factory KanbanCard.create({
    required String title,
    String description = '',
    String color = '#6F61EF',
  }) {
    return KanbanCard(
      id: const Uuid().v4(),
      title: title,
      description: description,
      color: color,
      createdAt: DateTime.now(),
    );
  }

  KanbanCard copyWith({
    String? title,
    String? description,
    String? color,
  }) {
    return KanbanCard(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      color: color ?? this.color,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'color': color,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory KanbanCard.fromJson(Map<String, dynamic> json) {
    return KanbanCard(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      color: json['color'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}