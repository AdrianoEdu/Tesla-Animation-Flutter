import 'package:teslacaranimation/database/object_box_databases.dart';

import '../database/objectbox.g.dart';
import '../model/Tyre.dart';

class TyreRepository{
  List<Tyre> _tyreList = [];

  final ObjectBoxDatabase _database = ObjectBoxDatabase();

  Future<Box> getBox() async {
    final store = await _database.getStore();
    return store.box<Tyre>();
  }

  save(Tyre tyre) async {
    final box = await getBox();

    final id = box.put(tyre);
    _tyreList.add(tyre);
    return id;
  }

  update(Tyre tyre) async {
    final box = await getBox();
    box.put(tyre);
    _tyreList.add(tyre);
  }

  getAll() async {
    final box = await getBox();
    _tyreList = box.getAll() as List<Tyre>;
    return _tyreList;
  }

  remove(Tyre tyre) async {
    final box = await getBox();
    box.remove(tyre.id);
    _tyreList.remove(tyre);
  }

  removeAll() async {
    final box = await getBox();
    box.removeAll();
  }
}
