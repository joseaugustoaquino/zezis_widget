// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:zezis_widget/zezis_widget.dart';

class DragAndDropPage extends StatefulWidget {
  const DragAndDropPage({super.key});

  @override
  State<DragAndDropPage> createState() => _DragAndDropPageState();
}

class _DragAndDropPageState extends State<DragAndDropPage> {
  List<DragAndDropList> kanbanItens = [];
  final ScrollController _scrollController1 = ScrollController();

  List<KanbanModel> kanban = List.generate(6, (i1) => KanbanModel(
    id: i1,
    color: Colors.orange,
    title: "Kanban $i1",

    itens: i1 == 0 ? [] : List.generate(i1 * 2, (i2) => ItemKanbanModel(
      id: i2,
      description: "Item Kanban $i2",
      date: DateTime.now().add(Duration(days: i2)),
    )),
  ));

  @override
  void initState() {
    kanban.sort((a, b) => a.id?.compareTo(b.id ?? 0) ?? 0);
    kanbanItens = kanban.map((m) => _dropList(m)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / kanban.length;
    size = size < 300 ? 325 : size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Drag And Drop"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: DragAndDropLists(
        sliverList: false,
        disableScrolling: false,
        removeTopPadding: false,
        constrainDraggingAxis: false,
        listDividerOnLastChild: false,
        addLastItemTargetHeightToTop: false,
        scrollController: _scrollController1,
      
        listWidth: size,
        lastListTargetSize: 0,
        lastItemTargetHeight: 30,
      
        axis: Axis.horizontal,
        contentsWhenEmpty: const SizedBox(),
        listPadding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      
        listDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[300],
        ),
      
        onListReorder: (int oldListIndex, int newListIndex) { },
      
        onItemReorder: (oldItemIndex, oldListIndex, newItemIndex, newListIndex) async {}, 
      
        itemDecorationWhileDragging: const BoxDecoration(color: Colors.transparent), 
      
        children: kanbanItens.map((m) => m).toList(),
      ),
    );
  }

  DragAndDropList _dropList(KanbanModel kanban) {
    var backgroundColor = (kanban.color ?? Colors.white).computeLuminance() >= 0.5 ? Colors.black : const Color(0xFFF0F0F0);
    
    return DragAndDropList(
      canDrag: false,
      contentsWhenEmpty: const SizedBox(),

      leftSide: const SizedBox(height: 8, width: 8),
      rightSide: const SizedBox(height: 8, width: 8),

      header: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Column(
          children: [
            Text(
              kanban.title ?? "",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:  backgroundColor,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              "${kanban.itens?.length ?? 0} NEGOCIAÇÕES",
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: backgroundColor,
                fontSize: 11.5,
              ),
            ),
          ],
        ),
      ),

      footer: TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: backgroundColor,
              size: 18,
            ),

            const SizedBox(width: 5),

            Text(
              "Adicionar",
              style: TextStyle(
                color: backgroundColor,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),

        onPressed: () {},
      ),

      decoration: BoxDecoration(
        color: kanban.color,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),

      children: kanban.itens?.map((p) => _dropItem(p)).toList() ?? [],
    );
  }

  DragAndDropItem _dropItem(ItemKanbanModel item) {
    return DragAndDropItem(
      feedbackWidget: RotationTransition(
        turns: const AlwaysStoppedAnimation(12 / 360),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.description ?? "",
              overflow: TextOverflow.clip,
              textAlign: TextAlign.justify,
                      
              style: const TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
        child: InkWell(
          onTap: () {},

          child: Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.description ?? "",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                            
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),

                  Text(
                    item.date.toString(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                            
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

class KanbanModel {
  int? id;
  Color? color;
  String? title;
  List<ItemKanbanModel>? itens;

  KanbanModel({
    this.id,
    this.color,
    this.title,
    this.itens,
  });
}

class ItemKanbanModel {
  int? id;
  DateTime? date;
  String? description;

  ItemKanbanModel({
    this.id,
    this.date,
    this.description,
  });
}
