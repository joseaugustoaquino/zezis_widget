// ignore_for_file: implementation_imports
import 'package:flutter/material.dart';
import 'package:zezis_widget/src/models/models.dart';
import 'package:zezis_widget/src/utils/z_extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zezis_widget/src/components/kanban/kanban_card.dart';

/// Widget que representa uma coluna no quadro Kanban.
/// 
/// Este widget exibe uma coluna com seus cards, suportando drag and drop,
/// ordenação e adição de novos cards.
class ColumnKanbanModelWidget extends StatefulWidget {
  final ColumnKanbanModel column;

  final Function(CardKanbanModel) onCardTap;
  final Function(int, int, int) onCardDropped;
  final Function(int, String) onColumnTitleEdit;

  final String titleAddCard;
  final Function(int, BuildContext) onAddCard;
  
  final double sizedColumn;
  final String isEmptyColumn;
  final bool? selectValueColumn;
  final Duration dragStartDelay;
  final Function(int)? sortColumn;
  final Function(int)? selectColumn;

  const ColumnKanbanModelWidget({
    super.key,
    required this.column,
    required this.onCardTap,
    required this.onCardDropped,
    required this.onColumnTitleEdit,

    required this.titleAddCard,
    required this.onAddCard,

    this.selectColumn,
    this.sizedColumn = 300,
    this.selectValueColumn,
    required this.sortColumn,
    this.isEmptyColumn = "Nenhum Card Localizado",
    this.dragStartDelay = const Duration(milliseconds: 500),
  });

  @override
  State<ColumnKanbanModelWidget> createState() => _ColumnKanbanModelWidgetState();
}

class _ColumnKanbanModelWidgetState extends State<ColumnKanbanModelWidget> {
  bool isOrderByColumn = false;

  @override
  void initState() {
    super.initState();
    isOrderByColumn = widget.column.orderBy;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = (widget.column.color.computeLuminance()) >= 0.5 ? Colors.black : const Color(0xFFF0F0F0);
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: widget.sizedColumn,
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
          // Cabeçalho da coluna
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: widget.column.color.withAlpha(215),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.column.title,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w600,
                                    color: backgroundColor
                                  )
                                ),

                                TextSpan(
                                  text: " (${widget.column.cards.length.toString()})",
                                  style: TextStyle(
                                    color: backgroundColor,
                                  )
                                ),
                              ]
                            ),
                          ),
                          
                          const SizedBox(height: 5),

                          Text(
                            widget.column.cards.sumBy((s) => s.currency).toCurrency(),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: backgroundColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (widget.sortColumn != null && widget.selectValueColumn == null) Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: InkWell(
                        onTap: () {
                          widget.sortColumn!(widget.column.id);
                          setState(() => isOrderByColumn = !isOrderByColumn);
                        },
                        child: Icon(
                          isOrderByColumn ? FontAwesomeIcons.arrowUp19 : FontAwesomeIcons.arrowDown91,
                          color: backgroundColor,
                          size: 20,
                        ),
                      ),
                    ),

                    if (widget.selectValueColumn != null) Container(
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: widget.selectValueColumn ?? false
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).colorScheme.outline.withAlpha(128),
                          width: 1,
                        ),
                      ),
                      child: Checkbox(
                        value: (widget.selectValueColumn ?? false),
                        activeColor: widget.column.color,
                        checkColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        side: BorderSide(
                          color: widget.selectValueColumn ?? false
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).colorScheme.outline.withAlpha(128),
                          width: 1.5,
                        ),
                        onChanged: (value) { 
                          widget.selectColumn!(widget.column.id); 
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Área de cards
          Expanded(
            child: DragTarget<Map<String, dynamic>>(
              builder: (context, candidateData, rejectedData) {
                return Stack(
                  children: [
                    _buildCardsList(context),
                    
                    if (candidateData.isNotEmpty)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
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
                final cardId = details.data['cardId'] as int;
                final sourceColumnId = details.data['sourceColumnId'] as int;
                widget.onCardDropped(sourceColumnId, widget.column.id, cardId);
              },
            ),
          ),
          
          // Botão de adicionar card
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
                color: backgroundColor,
              ),
              label: Text(
                widget.titleAddCard,
                style: TextStyle(color: backgroundColor),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                backgroundColor: widget.column.color.withAlpha(215),
                padding: const EdgeInsets.symmetric(vertical: 12),
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
            widget.isEmptyColumn,
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(128)
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: widget.column.cards.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) => _buildDraggableCard(widget.column.cards[index])
    );
  }

  Widget _buildDraggableCard(CardKanbanModel card) {
    return LongPressDraggable<Map<String, dynamic>>(
      data: {
        'cardId': card.id,
        'sourceColumnId': widget.column.id,
      },
      delay: widget.dragStartDelay,
      feedback: SizedBox(
        width: 280,
        child: CardKanbanModelWidget(
          card: card,
          onTap: () {},
          isDragging: true,
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: CardKanbanModelWidget(
          card: card,
          onTap: () => widget.onCardTap(card),
        ),
      ),
      child: DragTarget<Map<String, dynamic>>(
        builder: (context, candidateData, rejectedData) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: candidateData.isNotEmpty 
                ? Theme.of(context).primaryColor.withAlpha(26) 
                : Colors.transparent,
            ),
            child: CardKanbanModelWidget(
              card: card,
              onTap: () => widget.onCardTap(card),
            ),
          );
        },
        onAcceptWithDetails: (details) {
          final cardId = details.data['cardId'] as int;
          final sourceColumnId = details.data['sourceColumnId'] as int;
          widget.onCardDropped(sourceColumnId, widget.column.id, cardId);
        },
      ),
    );
  }
}