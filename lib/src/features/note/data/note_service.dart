import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notee/src/features/note/domain/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

class TODOService {
  late Future<Isar> db;
  //we define db that we want to use as late
  TODOService() {
    db = openDB();
  }
  //Create
  Future<void> createTODO(Note note) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.notes.putSync(note));
  }

  //Read
  Future<List<Note>> getAllTODO() async {
    final isar = await db;
    //Find all users in the user collection and return the list.
    var rex = await isar.notes.where().findAll();
    return rex;
  }

  //Update
  Future<void> updateTODO(Note note) async {
    final isar = await db;
    await isar.writeTxn(() async {
      //Perform a write transaction to update the user in the database.
      await isar.notes.put(note);
    });
  }

  //Delete
  //Delete a user from the Isar database based on user ID.
  Future<void> deleteTODO(int todoID) async {
    final isar = await db;
    //Perform a write transaction to delete the user with the specified ID.
    Future.delayed(const Duration(seconds: 3)).then(
      (_) => isar.writeTxn(
        () => isar.notes.delete(todoID),
      ),
    );
  }

  //Listen to changes in the user collection and yield a stream of user lists.
  Stream<List<Note>> listenTODO() async* {
    final isar = await db;
    //Watch the user collection for changes and yield the updated user list.
    yield* isar.notes.where().watch(fireImmediately: true);
  }

  Future<Isar> openDB() async {
    var dir = await getApplicationDocumentsDirectory();
    // to get application directory information
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        //open isar
        [NoteSchema],
        directory: dir.path,
        // user.g.dart includes the schemes that we need to define here - it can be multiple.
      );
    }
    return Future.value(Isar.getInstance());
    // return instance of Isar - it makes the isar state Ready for Usage for adding/deleting operations.
  }
}

final todoServiceProvider = Provider<TODOService>((ref) {
  return TODOService();
});

final allNotesProvider = StreamProvider<List<Note>>((ref) async* {
  final todosService = ref.read(todoServiceProvider);
  yield* todosService.listenTODO();
});

