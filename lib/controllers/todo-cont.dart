// controllers/todo_controller.dart
import 'package:get/get.dart';
import 'package:goto/models/todo-model.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;
  var selectedCategory = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    // Load dummy data
    loadDummyTodos();
  }

  void loadDummyTodos() {
    final dummyTodos = [
      Todo(
        id: '1',
        title: 'Reply to email messages',
        time: DateTime(2023, 2, 26, 10, 17),
        category: 'Work',
      ),
      Todo(
        id: '2',
        title: 'Shopping at the supermarket',
        time: DateTime(2023, 2, 26, 10, 17),
        category: 'Shopping',
      ),
      Todo(
        id: '3',
        title: 'Call my sister and my mom',
        time: DateTime(2023, 2, 26, 13, 11),
        category: 'Family',
      ),
      // Add more dummy todos as shown in the image
    ];
    todos.assignAll(dummyTodos);
  }

  void addTodo(Todo todo) {
    todos.add(todo);
  }

  void toggleTodoStatus(String id) {
    final index = todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      todos[index].isCompleted = !todos[index].isCompleted;
      todos.refresh();
    }
  }

  void deleteTodo(String id) {
    todos.removeWhere((todo) => todo.id == id);
  }

  List<Todo> get filteredTodos {
    if (selectedCategory.value == 'All') {
      return todos;
    }
    return todos.where((todo) => todo.category == selectedCategory.value).toList();
  }
}