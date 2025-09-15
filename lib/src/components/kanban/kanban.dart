library;

/// Componente Kanban para gerenciamento visual de tarefas e fluxos de trabalho.
/// 
/// Este componente permite a organização de tarefas em colunas, com suporte a
/// drag and drop, personalização visual e interatividade.
/// 
/// Exemplo de uso:
/// ```dart
/// KanbanBoardWidget(
///   board: myBoard,
///   onAddColumn: () => handleAddColumn(),
///   onCardTap: (card) => handleCardTap(card),
///   onCardDropped: (sourceColumnId, targetColumnId, index) => 
///     handleCardDrop(sourceColumnId, targetColumnId, index),
/// )
/// ```

export 'kanban_board.dart';
export 'kanban_card.dart';
export 'kanban_column.dart';