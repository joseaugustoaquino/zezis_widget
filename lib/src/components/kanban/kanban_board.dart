import 'package:flutter/material.dart';
import 'package:zezis_widget/src/models/models.dart';
import 'package:zezis_widget/src/components/kanban/kanban_column.dart';

/// Widget que representa um quadro Kanban completo.
/// 
/// Este widget gerencia um conjunto de colunas com seus respectivos cards,
/// permitindo a organização visual de tarefas e fluxos de trabalho.
class KanbanBoardWidget extends StatelessWidget {
  final KanbanBoard? board;
  final VoidCallback onAddColumn;

  final bool enableNewColumn;
  final Color? backgroundColor;

  final Function(CardKanbanModel) onCardTap;
  final Function(int, int, int) onCardDropped;
  final Function(int, String) onColumnTitleEdit;

  final String titleAddCard;
  final Function(int, BuildContext) onAddCard;
  
  final double sizedColumn;
  final String isEmptyColumn;
  final IconData? sortIconColumn;
  final void Function()? sortColumn;

  const KanbanBoardWidget({
    super.key,
    required this.board,
    required this.onAddColumn,

    this.enableNewColumn = false,
    this.backgroundColor,

    required this.onCardTap,
    required this.onCardDropped,
    required this.onColumnTitleEdit,

    this.titleAddCard = "Adicionar",
    required this.onAddCard,

    this.sizedColumn = 300,
    this.isEmptyColumn = "Nenhum Card Localizado",
    this.sortIconColumn,
    this.sortColumn,
  });

  @override
  Widget build(BuildContext context) {
    if (board == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final size = MediaQuery.of(context).size.width / (board?.columns.length ?? 1);

    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: board!.columns.length + (enableNewColumn ? 1 : 0), 
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              itemBuilder: (context, index) {
                if (index == board!.columns.length && enableNewColumn) {
                  return _buildAddColumnButton(context);
                }

                final column = board!.columns[index];
                return ColumnKanbanModelWidget(
                  key: ValueKey(column.id),
                  column: column,
                  onCardTap: onCardTap,
                  onCardDropped: onCardDropped,
                  onColumnTitleEdit: onColumnTitleEdit,

                  titleAddCard: titleAddCard,
                  onAddCard: onAddCard,

                  sortColumn: sortColumn,
                  sortIconColumn: sortIconColumn,
                  isEmptyColumn: isEmptyColumn,
                  sizedColumn: size < 300 ? 325 : (size - (5 * (board?.columns.length ?? 0))),
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
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onAddColumn,
            borderRadius: BorderRadius.circular(16),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
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
                    'Adicionar Nova Coluna',
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