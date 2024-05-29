import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notee/src/features/note/domain/task.dart';

class CompletedTodoStateNotifier extends StateNotifier<List<Task>> {
  CompletedTodoStateNotifier() : super([]);

  void addCompletedTask(Task task) {
    state = [...state, task];
  }

  void removeCompletedTask(Task task) async {
    await Future.delayed(const Duration(milliseconds: 1750)).then(
      (value) {
        state = state.where((element) => element != task).toList();
      },
    );
  }

  void clearCompletedTask() {
    state = [];
  }

  void toggleTaskStatus(Task task) {
    if (state.contains(task)) {
      state = state.where((element) => element != task).toList();
    } else {
      state = [...state, task];
    }
  }
}

final todoStateNotifierProvider =
    StateNotifierProvider<CompletedTodoStateNotifier, List<Task>>((ref) {
  return CompletedTodoStateNotifier();
});
