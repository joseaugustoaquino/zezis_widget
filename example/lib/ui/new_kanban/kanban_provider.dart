// ignore_for_file: implementation_imports
import 'package:flutter/material.dart';
import 'package:zezis_widget/src/models/models.dart';
import 'package:example/ui/new_kanban/storange_service.dart';

class KanbanProvider extends ChangeNotifier {
  KanbanBoard? _board;
  final StorageService _storageService = StorageService();
  bool _isLoading = true;

  KanbanProvider() {
    _loadBoard();
  }

  // Getters
  KanbanBoard? get board => _board;
  bool get isLoading => _isLoading;
  List<ColumnKanbanModel> get columns => _board?.columns ?? [];

  // Load board from storage
  Future<void> _loadBoard() async {
    _isLoading = true;
    notifyListeners();

    _board = await _storageService.getOrCreateBoard();
    
    _isLoading = false;
    notifyListeners();
  }

  // Save board to storage
  Future<void> _saveBoard() async {
    if (_board != null) {
      await _storageService.saveBoard(_board!);
    }
  }

  // Add a new card to a column
  Future<void> addCard(int columnId, CardKanbanModel card) async {
    if (_board == null) return;

    final columnIndex = _board!.columns.indexWhere((col) => col.id == columnId);
    if (columnIndex == -1) return;

    final column = _board!.columns[columnIndex];
    final updatedCards = [...column.cards, card];
    final updatedColumn = column.copyWith(cards: updatedCards);

    final updatedColumns = [..._board!.columns];
    updatedColumns[columnIndex] = updatedColumn;

    _board = _board!.copyWith(columns: updatedColumns);
    notifyListeners();
    await _saveBoard();
  }

  // Update an existing card
  Future<void> updateCard(int columnId, CardKanbanModel updatedCard) async {
    if (_board == null) return;

    final columnIndex = _board!.columns.indexWhere((col) => col.id == columnId);
    if (columnIndex == -1) return;

    final column = _board!.columns[columnIndex];
    final cardIndex = column.cards.indexWhere((card) => card.id == updatedCard.id);
    if (cardIndex == -1) return;

    final updatedCards = [...column.cards];
    updatedCards[cardIndex] = updatedCard;

    final updatedColumn = column.copyWith(cards: updatedCards);
    final updatedColumns = [..._board!.columns];
    updatedColumns[columnIndex] = updatedColumn;

    _board = _board!.copyWith(columns: updatedColumns);
    notifyListeners();
    await _saveBoard();
  }

  // Delete a card
  Future<void> deleteCard(int columnId, int cardId) async {
    if (_board == null) return;

    final columnIndex = _board!.columns.indexWhere((col) => col.id == columnId);
    if (columnIndex == -1) return;

    final column = _board!.columns[columnIndex];
    final updatedCards = column.cards.where((card) => card.id != cardId).toList();

    final updatedColumn = column.copyWith(cards: updatedCards);
    final updatedColumns = [..._board!.columns];
    updatedColumns[columnIndex] = updatedColumn;

    _board = _board!.copyWith(columns: updatedColumns);
    notifyListeners();
    await _saveBoard();
  }

  // Move a card between columns
  Future<void> moveCard(
    int sourceColumnId,
    int targetColumnId,
    int targetIndex,
  ) async {
    if (_board == null) return;
    
    // Find column indices
    final sourceColumnIndex = _board!.columns.indexWhere((col) => col.id == sourceColumnId);
    final targetColumnIndex = _board!.columns.indexWhere((col) => col.id == targetColumnId);

    if (sourceColumnIndex == -1 || targetColumnIndex == -1) return;

    // Get the source column
    final sourceColumn = _board!.columns[sourceColumnIndex];
    
    // Ensure there's a card to move
    if (sourceColumn.cards.isEmpty) return;
    
    // Get the first card from the source column (simplified for our drag implementation)
    final card = sourceColumn.cards[0];
    
    // Remove card from source column
    final sourceCards = [...sourceColumn.cards];
    sourceCards.removeAt(0); // Remove the first card
    final updatedSourceColumn = sourceColumn.copyWith(cards: sourceCards);

    // Add card to target column
    final targetColumn = _board!.columns[targetColumnIndex];
    final targetCards = [...targetColumn.cards];
    
    if (targetIndex < targetCards.length) {
      targetCards.insert(targetIndex, card);
    } else {
      targetCards.add(card);
    }
    
    final updatedTargetColumn = targetColumn.copyWith(cards: targetCards);

    // Update columns in the board
    final updatedColumns = [..._board!.columns];
    updatedColumns[sourceColumnIndex] = updatedSourceColumn;
    updatedColumns[targetColumnIndex] = updatedTargetColumn;

    _board = _board!.copyWith(columns: updatedColumns);
    notifyListeners();
    await _saveBoard();
  }

  // Update column title
  Future<void> updateColumnTitle(int columnId, String newTitle) async {
    if (_board == null) return;

    final columnIndex = _board!.columns.indexWhere((col) => col.id == columnId);
    if (columnIndex == -1) return;

    final column = _board!.columns[columnIndex];
    final updatedColumn = column.copyWith(title: newTitle);

    final updatedColumns = [..._board!.columns];
    updatedColumns[columnIndex] = updatedColumn;

    _board = _board!.copyWith(columns: updatedColumns);
    notifyListeners();
    await _saveBoard();
  }

  // Add a new column
  Future<void> addColumn(String title) async {
    if (_board == null) return;

    final newColumn = ColumnKanbanModel.create(title);
    final updatedColumns = [..._board!.columns, newColumn];

    _board = _board!.copyWith(columns: updatedColumns);
    notifyListeners();
    await _saveBoard();
  }

  // Delete a column
  Future<void> deleteColumn(int columnId) async {
    if (_board == null) return;

    final updatedColumns = _board!.columns.where((col) => col.id != columnId).toList();

    _board = _board!.copyWith(columns: updatedColumns);
    notifyListeners();
    await _saveBoard();
  }

  // Update board title
  Future<void> updateBoardTitle(String newTitle) async {
    if (_board == null) return;

    _board = _board!.copyWith(title: newTitle);
    notifyListeners();
    await _saveBoard();
  }

  // Reset board with default data
  Future<void> resetBoard() async {
    await _storageService.clearAllData();
    await _loadBoard();
  }
}