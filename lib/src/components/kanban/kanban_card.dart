import 'package:flutter/material.dart';
import 'package:zezis_widget/src/models/models.dart';

/// Widget que representa um card no quadro Kanban.
/// 
/// Este widget exibe as informações de um card com suporte a drag and drop,
/// animações e feedback visual.
class CardKanbanModelWidget extends StatelessWidget {
  final bool isDragging;
  final CardKanbanModel card;
  final VoidCallback onTap;

  const CardKanbanModelWidget({
    super.key,
    required this.card,
    required this.onTap,
    this.isDragging = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 200),
      margin: card.selected ? const EdgeInsets.symmetric(horizontal: 18, vertical: 12) : const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [                
          BoxShadow(
            color: card.selected ? (card.colorStatus?.withAlpha(255) ?? theme.primaryColor.withAlpha(255)) : Colors.black.withAlpha(13),
            offset: const Offset(2, 4),
            blurRadius: 8,
          ),
        ],
        border: Border.all(
          color: theme.colorScheme.outline.withAlpha(77),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: card.colorStatus?.withAlpha(215),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Body do card
                    if (card.bodyCard?.isNotEmpty ?? false) ...[
                      ...card.bodyCard!,
                      const SizedBox(height: 8),
                    ],
                    
                    // Footer do card
                    if (card.footerCard?.isNotEmpty ?? false) ...[
                      const Divider(height: 1),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: card.footerCard!,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}