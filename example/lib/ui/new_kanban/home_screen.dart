// ignore_for_file: implementation_imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zezis_widget/zezis_widget.dart';
import 'package:zezis_widget/src/models/models.dart';
import 'package:example/ui/new_kanban/kanban_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _columnTitleController = TextEditingController();
  late FocusNode _boardTitleFocusNode;
  bool _isEditingBoardTitle = false;
  final TextEditingController _boardTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
    _boardTitleFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _columnTitleController.dispose();
    _boardTitleController.dispose();
    _boardTitleFocusNode.dispose();
    super.dispose();
  }

  void _showAddCardDialog(int columnId, BuildContext context) {
    showSnackBar("Novo card criado");
  }

  void _showEditCardDialog(CardKanbanModel card) {
    // Find which column contains this card
    final provider = Provider.of<KanbanProvider>(context, listen: false);
    int? foundColumnId;
    
    for (final column in provider.columns) {
      if (column.cards.any((c) => c.id == card.id)) {
        foundColumnId = column.id;
        break;
      }
    }
    
    if (foundColumnId == null) return;
    showSnackBar("Card editado");
  }

  void _showAddColumnDialog() {
    _columnTitleController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Column'),
        content: TextField(
          controller: _columnTitleController,
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Column Title',
            hintText: 'Enter a title for the new column',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final title = _columnTitleController.text.trim();
              if (title.isNotEmpty) {
                final provider = Provider.of<KanbanProvider>(context, listen: false);
                provider.addColumn(title);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  void _startEditingBoardTitle(String currentTitle) {
    setState(() {
      _boardTitleController.text = currentTitle;
      _isEditingBoardTitle = true;
    });
    
    // Focus on the text field after the state has been rebuilt
    Future.delayed(const Duration(milliseconds: 50), () {
      _boardTitleFocusNode.requestFocus();
    });
  }

  void _saveBoardTitle() {
    final newTitle = _boardTitleController.text.trim();
    if (newTitle.isNotEmpty) {
      final provider = Provider.of<KanbanProvider>(context, listen: false);
      provider.updateBoardTitle(newTitle);
    }
    
    setState(() {
      _isEditingBoardTitle = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<KanbanProvider>(
      builder: (context, kanbanProvider, child) {
        final board = kanbanProvider.board;
        
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,

            title: _isEditingBoardTitle
              ? TextField(
                  controller: _boardTitleController,
                  focusNode: _boardTitleFocusNode,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    hintText: 'Board Title',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary.withAlpha(179),
                    ),
                  ),
                  onSubmitted: (_) => _saveBoardTitle(),
                )
              : GestureDetector(
                  onTap: () {
                    if (board != null) {
                      _startEditingBoardTitle(board.title);
                    }
                  },
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          board?.title ?? 'Loading...',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (board != null) ...[                          
                        const SizedBox(width: 8),
                        Icon(
                          Icons.edit,
                          color: Theme.of(context).colorScheme.onPrimary.withAlpha(179),
                          size: 16,
                        ),
                      ],
                    ],
                  ),
                ),
            
            actions: [
              if (_isEditingBoardTitle)
                IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: _saveBoardTitle,
                ),
              
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () async {
                  await kanbanProvider.resetBoard().then((value) {
                    showSnackBar("Board reset with sample data");
                    setState(() {});
                  });
                },
                tooltip: 'Reset board',
              ),
            ],
          ),

          body: kanbanProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : FadeTransition(
                opacity: _fadeAnimation,
                child: KanbanBoardWidget(
                  board: board,
                  onCardTap: _showEditCardDialog,
                  onAddCard: _showAddCardDialog,
                  onCardDropped: kanbanProvider.moveCard,
                  onColumnTitleEdit: kanbanProvider.updateColumnTitle,
                  onAddColumn: _showAddColumnDialog,

                  sortIconColumn: Icons.sort_rounded,
                  sortColumn: () {},
                ),
              ),
        );
      },
    );
  }
}