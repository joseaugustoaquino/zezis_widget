import 'package:zezis_widget/src/models/kanban/column_kanban_model.dart';

/// Representa um quadro Kanban com colunas e cartões.
class KanbanBoard {
  /// Identificador único do quadro
  final String id;
  
  /// Título do quadro
  final String title;
  
  /// Lista de colunas do quadro
  final List<ColumnKanbanModel> columns;

  /// Construtor do quadro Kanban
  KanbanBoard({
    required this.id,
    required this.title,
    required this.columns,
  }) : assert(id.isNotEmpty, 'O ID não pode estar vazio'),
       assert(title.isNotEmpty, 'O título não pode estar vazio'),
       assert(columns.isNotEmpty, 'O quadro deve ter pelo menos uma coluna');

  /// Cria um novo quadro Kanban com colunas padrão
  factory KanbanBoard.create(String title) {
    if (title.isEmpty) {
      throw ArgumentError('O título não pode estar vazio');
    }

    return KanbanBoard(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      columns: [
        ColumnKanbanModel.create('Em Negociação'),
        ColumnKanbanModel.create('Pagamento'),
        ColumnKanbanModel.create('Pausado'),
        ColumnKanbanModel.create('Perdido'),
      ],
    );
  }

  /// Cria uma cópia do quadro com campos opcionais atualizados
  KanbanBoard copyWith({
    String? title,
    List<ColumnKanbanModel>? columns,
  }) {
    return KanbanBoard(
      id: id,
      title: title ?? this.title,
      columns: columns ?? List.from(this.columns),
    );
  }

  /// Converte o quadro para um mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'columns': columns.map((column) => column.toJson()).toList(),
    };
  }

  /// Cria um quadro a partir de um mapa JSON
  factory KanbanBoard.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('id') || !json.containsKey('title') || !json.containsKey('columns')) {
      throw const FormatException('JSON inválido: campos obrigatórios ausentes');
    }

    return KanbanBoard(
      id: json['id'] as String,
      title: json['title'] as String,
      columns: (json['columns'] as List)
          .map((column) => ColumnKanbanModel.fromJson(column as String))
          .toList(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is KanbanBoard &&
        other.id == id &&
        other.title == title &&
        other.columns.length == columns.length &&
        other.columns.every((column) => columns.contains(column));
  }

  @override
  int get hashCode => Object.hash(id, title, columns);
}