import 'package:flutter/material.dart';
import 'package:example/ui/new_kanban/kanban_models.dart';

class CardEditorScreen extends StatefulWidget {
  final KanbanCard? card;
  final String columnId;
  final Function(String, KanbanCard) onSave;

  const CardEditorScreen({
    super.key,
    this.card,
    required this.columnId,
    required this.onSave,
  });

  @override
  State<CardEditorScreen> createState() => _CardEditorScreenState();
}

class _CardEditorScreenState extends State<CardEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedColor = '#6F61EF';

  final List<Map<String, dynamic>> _colorOptions = [
    {'name': 'Purple', 'value': '#6F61EF'},
    {'name': 'Teal', 'value': '#39D2C0'},
    {'name': 'Orange', 'value': '#EE8B60'},
    {'name': 'Pink', 'value': '#FF5963'},
    {'name': 'Blue', 'value': '#4B8EFF'},
    {'name': 'Green', 'value': '#3AD467'},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.card != null) {
      _titleController.text = widget.card!.title;
      _descriptionController.text = widget.card!.description;
      _selectedColor = widget.card!.color;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveCard() {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    final newCard = widget.card == null
        ? KanbanCard.create(
            title: title,
            description: description,
            color: _selectedColor,
          )
        : widget.card!.copyWith(
            title: title,
            description: description,
            color: _selectedColor,
          );

    widget.onSave(widget.columnId, newCard);
    Navigator.of(context).pop();
  }

  Color _getColorFromHex(String hexColor) {
    try {
      return Color(int.parse(hexColor.replaceAll('#', '0xFF')));
    } catch (e) {
      return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNewCard = widget.card == null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isNewCard ? 'Create Card' : 'Edit Card'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
        actions: [
          TextButton(
            onPressed: _saveCard,
            child: Text(
              'Save',
              style: TextStyle(color: theme.primaryColor),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Color selector
                  Text(
                    'Card Color',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _colorOptions.length,
                      itemBuilder: (context, index) {
                        final colorOption = _colorOptions[index];
                        final isSelected = colorOption['value'] == _selectedColor;
                        final color = _getColorFromHex(colorOption['value']);
                        
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedColor = colorOption['value'];
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 16),
                            width: isSelected ? 90 : 50,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: color.withAlpha(102),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                            ),
                            child: Center(
                              child: isSelected
                                ? Text(
                                    colorOption['name'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Title input
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: 'Enter a title for this card',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fillColor: theme.colorScheme.surface,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    maxLength: 100,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Description input
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter a description (optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fillColor: theme.colorScheme.surface,
                      filled: true,
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                    maxLength: 500,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Save button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _saveCard,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _getColorFromHex(_selectedColor),
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(isNewCard ? Icons.add : Icons.save),
                          const SizedBox(width: 12),
                          Text(
                            isNewCard ? 'Create Card' : 'Save Changes',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
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