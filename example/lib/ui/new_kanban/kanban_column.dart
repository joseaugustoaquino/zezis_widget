import 'package:flutter/material.dart';
import 'package:example/ui/new_kanban/kanban_card.dart';
import 'package:example/ui/new_kanban/kanban_models.dart';

class KanbanColumnWidget extends StatefulWidget {
  final KanbanColumn column;
  final Function(KanbanCard) onCardTap;
  final Function(KanbanCard) onCardEdit;
  final Function(KanbanCard) onCardDelete;
  final Function(String, BuildContext) onAddCard;
  final Function(String, String, int) onCardDropped;
  final Function(String, String) onColumnTitleEdit;

  const KanbanColumnWidget({
    super.key,
    required this.column,
    required this.onCardTap,
    required this.onCardEdit,
    required this.onCardDelete,
    required this.onAddCard,
    required this.onCardDropped,
    required this.onColumnTitleEdit,
  });

  @override
  State<KanbanColumnWidget> createState() => _KanbanColumnWidgetState();
}

class _KanbanColumnWidgetState extends State<KanbanColumnWidget> {
  final TextEditingController _titleController = TextEditingController();
  bool _isEditingTitle = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.column.title;
  }

  @override
  void didUpdateWidget(KanbanColumnWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.column.title != widget.column.title) {
      _titleController.text = widget.column.title;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _startEditingTitle() {
    setState(() {
      _isEditingTitle = true;
    });
  }

  void _saveTitle() {
    if (_titleController.text.trim().isNotEmpty) {
      widget.onColumnTitleEdit(widget.column.id, _titleController.text.trim());
    } else {
      _titleController.text = widget.column.title;
    }
    setState(() {
      _isEditingTitle = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withAlpha(230),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withAlpha(77),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Column header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                // Column title (editable)
                Expanded(
                  child: _isEditingTitle
                      ? TextField(
                          controller: _titleController,
                          autofocus: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: theme.colorScheme.outline,
                              ),
                            ),
                          ),
                          style: theme.textTheme.titleMedium,
                          onSubmitted: (_) => _saveTitle(),
                        )
                      : GestureDetector(
                          onDoubleTap: _startEditingTitle,
                          child: Row(
                            children: [
                              Text(
                                widget.column.title,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '(${widget.column.cards.length})',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface.withAlpha(153),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                // Edit column title button
                if (!_isEditingTitle)
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      size: 18,
                      color: theme.primaryColor,
                    ),
                    onPressed: _startEditingTitle,
                    tooltip: 'Edit column title',
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(8),
                    visualDensity: VisualDensity.compact,
                  ),
                // Save column title button
                if (_isEditingTitle)
                  IconButton(
                    icon: Icon(
                      Icons.check,
                      size: 18,
                      color: theme.primaryColor,
                    ),
                    onPressed: _saveTitle,
                    tooltip: 'Save column title',
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(8),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
          ),
          
          // Droppable area for cards
          Expanded(
            child: DragTarget<Map<String, dynamic>>(
              builder: (context, candidateData, rejectedData) {
                return Stack(
                  children: [
                    // Cards list
                    _buildCardsList(context),
                    
                    // Highlight when dragging over
                    if (candidateData.isNotEmpty)
                      Container(
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withAlpha(26),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                      ),
                  ],
                );
              },
              onAcceptWithDetails: (details) {
                final sourceColumnId = details.data['sourceColumnId'] as String;
                widget.onCardDropped(sourceColumnId, widget.column.id, widget.column.cards.length);
              },
            ),
          ),
          
          // Add new card button
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              border: Border(
                top: BorderSide(
                  color: theme.colorScheme.outline.withAlpha(77),
                  width: 1,
                ),
              ),
            ),
            child: ElevatedButton.icon(
              onPressed: () => widget.onAddCard(widget.column.id, context),
              icon: Icon(
                Icons.add_rounded,
                color: theme.colorScheme.onPrimary,
              ),
              label: Text(
                'Add Card',
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardsList(BuildContext context) {
    if (widget.column.cards.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No cards yet',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(128),
                ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: widget.column.cards.length,
      itemBuilder: (context, index) {
        final card = widget.column.cards[index];
        
        return _buildDraggableCard(card, index);
      },
    );
  }

  Widget _buildDraggableCard(KanbanCard card, int index) {
    return LongPressDraggable<Map<String, dynamic>>(
      data: {
        'cardId': card.id,
        'sourceColumnId': widget.column.id,
      },
      feedback: SizedBox(
        width: 280,
        child: KanbanCardWidget(
          card: card,
          onTap: () {},
          onEdit: (_) {},
          onDelete: (_) {},
          isDragging: true,
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: KanbanCardWidget(
          card: card,
          onTap: () => widget.onCardTap(card),
          onEdit: widget.onCardEdit,
          onDelete: widget.onCardDelete,
        ),
      ),
      child: DragTarget<Map<String, dynamic>>(
        builder: (context, candidateData, rejectedData) {
          return Container(
            decoration: BoxDecoration(
              color: candidateData.isNotEmpty
                ? Theme.of(context).primaryColor.withAlpha(26)
                : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: KanbanCardWidget(
              card: card,
              onTap: () => widget.onCardTap(card),
              onEdit: widget.onCardEdit,
              onDelete: widget.onCardDelete,
            ),
          );
        },
        onAcceptWithDetails: (details) {
          final sourceColumnId = details.data['sourceColumnId'] as String;
          widget.onCardDropped(sourceColumnId, widget.column.id, index);
        },
      ),
    );
  }
}