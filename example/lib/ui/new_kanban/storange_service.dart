import 'dart:convert';
import 'package:example/ui/new_kanban/kanban_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _boardKey = 'kanban_board';

  // Save board to shared preferences
  Future<bool> saveBoard(KanbanBoard board) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final boardJson = jsonEncode(board.toJson());
      return await prefs.setString(_boardKey, boardJson);
    } catch (e) {
      return false;
    }
  }

  // Load board from shared preferences
  Future<KanbanBoard?> loadBoard() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final boardJson = prefs.getString(_boardKey);
      
      if (boardJson == null) {
        return null;
      }
      
      return KanbanBoard.fromJson(jsonDecode(boardJson));
    } catch (e) {
      return null;
    }
  }

  // Create default board if none exists
  Future<KanbanBoard> getOrCreateBoard() async {
    final existingBoard = await loadBoard();
    if (existingBoard != null) {
      return existingBoard;
    }
    
    // Create a default board with sample data
    final defaultBoard = KanbanBoard.create('My Kanban Board');
    
    final inNegotiationCards = [
      KanbanCard.create(
        title: 'In Negotiation',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vehicula euismod velit, nec tristique nisi lobortis ut. Sed convallis, justo at viverra consequat, augue tellus fermentum metus, non suscipit purus augue at metus. Integer commodo, nisi sed sodales feugiat, augue metus dapibus turpis, sed fringilla justo arcu vitae sapien.',
      ),
      KanbanCard.create(
        title: 'In Negotiation',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vehicula euismod velit, nec tristique nisi lobortis ut. Sed convallis, justo at viverra consequat, augue tellus fermentum metus, non suscipit purus augue at metus. Integer commodo, nisi sed sodales feugiat, augue metus dapibus turpis, sed fringilla justo arcu vitae sapien.',
      ),
      KanbanCard.create(
        title: 'In Negotiation',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vehicula euismod velit, nec tristique nisi lobortis ut. Sed convallis, justo at viverra consequat, augue tellus fermentum metus, non suscipit purus augue at metus. Integer commodo, nisi sed sodales feugiat, augue metus dapibus turpis, sed fringilla justo arcu vitae sapien.',
      ),
      KanbanCard.create(
        title: 'In Negotiation',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vehicula euismod velit, nec tristique nisi lobortis ut. Sed convallis, justo at viverra consequat, augue tellus fermentum metus, non suscipit purus augue at metus. Integer commodo, nisi sed sodales feugiat, augue metus dapibus turpis, sed fringilla justo arcu vitae sapien.',
      ),
      KanbanCard.create(
        title: 'In Negotiation',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vehicula euismod velit, nec tristique nisi lobortis ut. Sed convallis, justo at viverra consequat, augue tellus fermentum metus, non suscipit purus augue at metus. Integer commodo, nisi sed sodales feugiat, augue metus dapibus turpis, sed fringilla justo arcu vitae sapien.',
      ),
      KanbanCard.create(
        title: 'In Negotiation',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vehicula euismod velit, nec tristique nisi lobortis ut. Sed convallis, justo at viverra consequat, augue tellus fermentum metus, non suscipit purus augue at metus. Integer commodo, nisi sed sodales feugiat, augue metus dapibus turpis, sed fringilla justo arcu vitae sapien.',
      ),
    ];
    
    final paymentCards = [
      KanbanCard.create(
        title: 'Payment',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vehicula euismod velit, nec tristique nisi lobortis ut. Sed convallis, justo at viverra consequat, augue tellus fermentum metus, non suscipit purus augue at metus. Integer commodo, nisi sed sodales feugiat, augue metus dapibus turpis, sed fringilla justo arcu vitae sapien.',
      ),
      KanbanCard.create(
        title: 'Payment',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vehicula euismod velit, nec tristique nisi lobortis ut. Sed convallis, justo at viverra consequat, augue tellus fermentum metus, non suscipit purus augue at metus. Integer commodo, nisi sed sodales feugiat, augue metus dapibus turpis, sed fringilla justo arcu vitae sapien.',
      ),
      KanbanCard.create(
        title: 'Payment',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vehicula euismod velit, nec tristique nisi lobortis ut. Sed convallis, justo at viverra consequat, augue tellus fermentum metus, non suscipit purus augue at metus. Integer commodo, nisi sed sodales feugiat, augue metus dapibus turpis, sed fringilla justo arcu vitae sapien.',
      ),
      KanbanCard.create(
        title: 'Payment',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vehicula euismod velit, nec tristique nisi lobortis ut. Sed convallis, justo at viverra consequat, augue tellus fermentum metus, non suscipit purus augue at metus. Integer commodo, nisi sed sodales feugiat, augue metus dapibus turpis, sed fringilla justo arcu vitae sapien.',
      ),
      KanbanCard.create(
        title: 'Payment',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vehicula euismod velit, nec tristique nisi lobortis ut. Sed convallis, justo at viverra consequat, augue tellus fermentum metus, non suscipit purus augue at metus. Integer commodo, nisi sed sodales feugiat, augue metus dapibus turpis, sed fringilla justo arcu vitae sapien.',
      ),
      KanbanCard.create(
        title: 'Payment',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vehicula euismod velit, nec tristique nisi lobortis ut. Sed convallis, justo at viverra consequat, augue tellus fermentum metus, non suscipit purus augue at metus. Integer commodo, nisi sed sodales feugiat, augue metus dapibus turpis, sed fringilla justo arcu vitae sapien.',
      ),
    ];
    
    final pausedCards = [
      KanbanCard.create(
        title: 'Paused',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vehicula euismod velit, nec tristique nisi lobortis ut. Sed convallis, justo at viverra consequat, augue tellus fermentum metus, non suscipit purus augue at metus. Integer commodo, nisi sed sodales feugiat, augue metus dapibus turpis, sed fringilla justo arcu vitae sapien.',
      ),
      KanbanCard.create(
        title: 'Paused',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vehicula euismod velit, nec tristique nisi lobortis ut. Sed convallis, justo at viverra consequat, augue tellus fermentum metus, non suscipit purus augue at metus. Integer commodo, nisi sed sodales feugiat, augue metus dapibus turpis, sed fringilla justo arcu vitae sapien.',
      ),
      KanbanCard.create(
        title: 'Paused',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vehicula euismod velit, nec tristique nisi lobortis ut. Sed convallis, justo at viverra consequat, augue tellus fermentum metus, non suscipit purus augue at metus. Integer commodo, nisi sed sodales feugiat, augue metus dapibus turpis, sed fringilla justo arcu vitae sapien.',
      ),
    ];

    final lostCards = [
      KanbanCard.create(
        title: 'Loss',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vehicula euismod velit, nec tristique nisi lobortis ut. Sed convallis, justo at viverra consequat, augue tellus fermentum metus, non suscipit purus augue at metus. Integer commodo, nisi sed sodales feugiat, augue metus dapibus turpis, sed fringilla justo arcu vitae sapien.',
      ),
    ];
    
    // Update columns with sample cards
    final updatedColumns = [
      defaultBoard.columns[0].copyWith(cards: inNegotiationCards),
      defaultBoard.columns[1].copyWith(cards: paymentCards),
      defaultBoard.columns[2].copyWith(cards: pausedCards),
      defaultBoard.columns[3].copyWith(cards: lostCards),
    ];
    
    final boardWithSampleData = defaultBoard.copyWith(columns: updatedColumns);
    await saveBoard(boardWithSampleData);
    
    return boardWithSampleData;
  }
  
  // Clear all data (for testing or reset functionality)
  Future<bool> clearAllData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.clear();
    } catch (e) {
      return false;
    }
  }
}