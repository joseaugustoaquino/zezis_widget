// ignore_for_file: implementation_imports
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zezis_widget/src/utils/z_extensions.dart';
import 'package:zezis_widget/src/models/models.dart';

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
      CardKanbanModel.create(
        title: 'In Negotiation',

        colorStatus: Colors.orange,
        descriptionStatus: "In Negotiation",
        
        dayForgotten: 5,
        colorForgotten: Colors.orange,

        bodyCard: _body(),
        id: Random().nextInt(100) + DateTime.now().microsecond,
        footerCard: _footer((Random().nextInt(100) + DateTime.now().microsecond).toDouble()),
      ),
      CardKanbanModel.create(
        title: 'In Negotiation',

        colorStatus: Colors.orange,
        descriptionStatus: "In Negotiation",
        
        dayForgotten: 5,
        colorForgotten: Colors.orange,

        bodyCard: _body(),
        id: Random().nextInt(100) + DateTime.now().microsecond,
        footerCard: _footer((Random().nextInt(100) + DateTime.now().microsecond).toDouble()),
      ),
      CardKanbanModel.create(
        title: 'In Negotiation',

        colorStatus: Colors.orange,
        descriptionStatus: "In Negotiation",
        
        dayForgotten: 5,
        colorForgotten: Colors.orange,
        
        bodyCard: _body(),
        id: Random().nextInt(100) + DateTime.now().microsecond,
        footerCard: _footer((Random().nextInt(100) + DateTime.now().microsecond).toDouble()),
      ),
      CardKanbanModel.create(
        title: 'In Negotiation',

        colorStatus: Colors.green,
        descriptionStatus: "In Negotiation",
        
        dayForgotten: 5,
        colorForgotten: Colors.green,
        
        bodyCard: _body(),
        id: Random().nextInt(100) + DateTime.now().microsecond,
        footerCard: _footer((Random().nextInt(100) + DateTime.now().microsecond).toDouble()),
      ),
      CardKanbanModel.create(
        title: 'In Negotiation',

        colorStatus: Colors.green,
        descriptionStatus: "In Negotiation",
        
        dayForgotten: 5,
        colorForgotten: Colors.green,
        
        bodyCard: _body(),
        id: Random().nextInt(100) + DateTime.now().microsecond,
        footerCard: _footer((Random().nextInt(100) + DateTime.now().microsecond).toDouble()),
      ),
      CardKanbanModel.create(
        title: 'In Negotiation',

        colorStatus: Colors.green,
        descriptionStatus: "In Negotiation",
        
        dayForgotten: 5,
        colorForgotten: Colors.green,
        
        bodyCard: _body(),
        id: Random().nextInt(100) + DateTime.now().microsecond,
        footerCard: _footer((Random().nextInt(100) + DateTime.now().microsecond).toDouble()),
      ),
    ];
    
    final paymentCards = [
      CardKanbanModel.create(
        title: 'Loss',

        colorStatus: Colors.red,
        descriptionStatus: "Loss",
        
        dayForgotten: 5,
        colorForgotten: Colors.red,
        
        bodyCard: _body(),
        id: Random().nextInt(100) + DateTime.now().microsecond,
        footerCard: _footer((Random().nextInt(100) + DateTime.now().microsecond).toDouble()),
      ),
      CardKanbanModel.create(
        title: 'Paused',

        colorStatus: Colors.orange,
        descriptionStatus: "Paused",
        
        dayForgotten: 5,
        colorForgotten: Colors.orange,
        
        bodyCard: _body(),
        id: Random().nextInt(100) + DateTime.now().microsecond,
        footerCard: _footer((Random().nextInt(100) + DateTime.now().microsecond).toDouble()),
      ),
      CardKanbanModel.create(
        title: 'Payment',

        colorStatus: Colors.green,
        descriptionStatus: "Payment",
        
        dayForgotten: 5,
        colorForgotten: Colors.green,
        
        bodyCard: _body(),
        id: Random().nextInt(100) + DateTime.now().microsecond,
        footerCard: _footer((Random().nextInt(100) + DateTime.now().microsecond).toDouble()),
      ),
    ];
    
    final pausedCards = [
      CardKanbanModel.create(
        title: 'Loss',

        colorStatus: Colors.red,
        descriptionStatus: "Loss",
        
        dayForgotten: 5,
        colorForgotten: Colors.red,
        
        bodyCard: _body(),
        id: Random().nextInt(100) + DateTime.now().microsecond,
        footerCard: _footer((Random().nextInt(100) + DateTime.now().microsecond).toDouble()),
      ),
      CardKanbanModel.create(
        title: 'Loss',

        colorStatus: Colors.red,
        descriptionStatus: "Loss",
        
        dayForgotten: 5,
        colorForgotten: Colors.red,
        
        bodyCard: _body(),
        id: Random().nextInt(100) + DateTime.now().microsecond,
        footerCard: _footer((Random().nextInt(100) + DateTime.now().microsecond).toDouble()),
      ),
    ];

    final lostCards = [
      CardKanbanModel.create(
        title: 'Loss',

        colorStatus: Colors.red,
        descriptionStatus: "Loss",
        
        dayForgotten: 5,
        colorForgotten: Colors.red,
        
        bodyCard: _body(),
        id: Random().nextInt(100) + DateTime.now().microsecond,
        footerCard: _footer((Random().nextInt(100) + DateTime.now().microsecond).toDouble()),
      ),
    ];
    
    // Update columns with sample cards
    final updatedColumns = [
      defaultBoard.columns[0].copyWith(cards: inNegotiationCards, color: Colors.blue),
      defaultBoard.columns[1].copyWith(cards: paymentCards, color: Colors.amber),
      defaultBoard.columns[2].copyWith(cards: pausedCards, color: Colors.green),
      defaultBoard.columns[3].copyWith(cards: lostCards, color: Colors.red),
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

  // Widget
  List<Widget> _footer(double currency) {
    return [
      Expanded(
        child: Text(
          currency.toCurrency(),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify,
                  
          style: TextStyle(
            color: Colors.grey.withAlpha(230),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
            
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.calendar_month,
              color: Colors.grey.withAlpha(230),
              size: 18,
            ),
          ),
          
          const SizedBox(width: 10),
            
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.phone,
              color: Colors.grey.withAlpha(230),
              size: 16,
            ),
          ),
            
          const SizedBox(width: 10),
            
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.chat,
              color: Colors.grey.withAlpha(230),
              size: 20,
            ),
          ),
        ],
      ),
    ];
  }

  List<Widget> _body() {
    return [
      Row(
        children: [
          const Expanded(
            child: Text(
              "Participant Lorem",

              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),

          Visibility(
            child: Tooltip(
              message: "Negociação sem contato há +99 dias.",  

              decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.all(Radius.circular(15)) ,
              ),
              
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ), 

              child:  Container(
                width: 32,
                padding: const EdgeInsets.all(2.5),
                
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
              
                child: const Text(
                  "+99",
              
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
                
      const Text(
        "Consultor Lorem",
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.justify,
                
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
    ];
  }
}
