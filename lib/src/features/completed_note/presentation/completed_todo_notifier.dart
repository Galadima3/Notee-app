import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notee/src/features/note/domain/note.dart';

class CompletedTodoStateNotifier extends StateNotifier<List<Note>> {
  CompletedTodoStateNotifier() : super([]);

  void addCompletedTask(Note task) {
    state = [...state, task];
  }

  void removeCompletedTask(Note task) async {
    await Future.delayed(const Duration(milliseconds: 1750)).then(
      (value) {
        state = state.where((element) => element != task).toList();
      },
    );
  }

  void clearCompletedTask() {
    state = [];
  }

  void toggleTaskStatus(Note task) {
    if (state.contains(task)) {
      state = state.where((element) => element != task).toList();
    } else {
      state = [...state, task];
    }
  }
}

final todoStateNotifierProvider =
    StateNotifierProvider<CompletedTodoStateNotifier, List<Note>>((ref) {
  return CompletedTodoStateNotifier();
});
