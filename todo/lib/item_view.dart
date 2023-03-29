import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:todo/todo_list_provider.dart';
import 'package:todo/todo_model.dart';
import 'package:provider/provider.dart';

class ItemView extends StatefulWidget {
  final Todo item;

  ItemView({this.item});

  @override
  _ItemViewState createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    if (widget.item != null)
      _textEditingController.text = widget.item.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item != null ? 'Edit todo' : 'New todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormField(
              controller: _textEditingController,
              onFieldSubmitted: (value) => submit(),
              textCapitalization: TextCapitalization.sentences,
              autofocus: true,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder (
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                )
              ),
            ),
            SizedBox(height: 10),
            AnimatedButton(
              height: 70,
              width: 200,
              text: 'SUBMIT',
              isReverse: true,
              onPress: submit,
              selectedTextColor: Colors.black,
              transitionType: TransitionType.LEFT_TO_RIGHT,
              backgroundColor: Colors.greenAccent,
              borderColor: Colors.white,
              borderRadius: 50,
              borderWidth: 2,
            ),
          ],
        ),
      ),
    );
  }

  void submit() {
    String description = _textEditingController.text;
    if(description != null && description.isNotEmpty) {
      if(widget.item != null) {
        context.read<TodoListProvider>().updateItemDescription(widget.item, description);
      } else {
        context.read<TodoListProvider>().addNewItem(description);
      }
      Navigator.pop(context, _textEditingController.text);
    }
  }
}
