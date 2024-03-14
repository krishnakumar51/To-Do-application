import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  final controller = TextEditingController();
  List<ToDo> foundToDo = [];

  @override
  void initState() {
    super.initState();
    foundToDo = todoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: appBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                searchbox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text(
                          "All ToDo's",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                      ),
                      for (ToDo toDoo in foundToDo.reversed)
                        ToDoItem(
                          toDo: toDoo,
                          onToDoChanged: handleToDoChange,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'New ToDo',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      addToDoitem(controller.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(2),
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void onDelete(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void addToDoitem(String todo) {
    // Check if the todo is not empty and contains non-whitespace characters
    if (todo.trim().isNotEmpty) {
      setState(() {
        todoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo,
        ));
      });
      controller.clear();
    }
  }

  Widget searchbox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => runFilter(value),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search_outlined,
              color: tdBlack,
              size: 30,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 30, minHeight: 25),
            border: InputBorder.none,
            hintText: '   Search',
            hintStyle: TextStyle(color: tdGrey, fontSize: 20)),
      ),
    );
  }

  void runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundToDo = results;
    });
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 40,
          ),
          SizedBox(
            height: 50,
            width: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset('assets/images/1.png'),
            ),
          )
        ],
      ),
    );
  }
}
