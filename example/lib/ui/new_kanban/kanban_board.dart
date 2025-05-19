import 'package:flutter/material.dart';
import 'package:example/ui/new_kanban/kanban_column.dart';
import 'package:example/ui/new_kanban/kanban_models.dart';

class KanbanBoardWidget extends StatelessWidget {
  final KanbanBoard? board;
  final Function(KanbanCard) onCardTap;
  final Function(KanbanCard) onCardEdit;
  final Function(KanbanCard) onCardDelete;
  final Function(String, BuildContext) onAddCard;
  final Function(String, String, int) onCardDropped;
  final Function(String, String) onColumnTitleEdit;
  final VoidCallback onAddColumn;
  
  const KanbanBoardWidget({
    super.key,
    required this.board,
    required this.onCardTap,
    required this.onCardEdit,
    required this.onCardDelete,
    required this.onAddCard,
    required this.onCardDropped,
    required this.onColumnTitleEdit,
    required this.onAddColumn,
  });

  @override
  Widget build(BuildContext context) {
    if (board == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Horizontal ListView for columns
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              itemCount: board!.columns.length + 1, // +1 for the add column button
              itemBuilder: (context, index) {
                // If we're at the last index, show the 'Add Column' button
                if (index == board!.columns.length) {
                  return _buildAddColumnButton(context);
                }

                // Otherwise, show a column
                final column = board!.columns[index];
                return KanbanColumnWidget(
                  key: ValueKey(column.id),
                  column: column,
                  onCardTap: onCardTap,
                  onCardEdit: onCardEdit,
                  onCardDelete: onCardDelete,
                  onAddCard: onAddCard,
                  onCardDropped: onCardDropped,
                  onColumnTitleEdit: onColumnTitleEdit,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddColumnButton(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: Container(
          width: 250,
          height: 120,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withAlpha(204),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.outline.withAlpha(77),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(3),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onAddColumn,
              borderRadius: BorderRadius.circular(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline_rounded,
                    size: 48,
                    color: theme.primaryColor,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Add New Column',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}