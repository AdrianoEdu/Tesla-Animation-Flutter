import 'package:teslacaranimation/repositories/tyre_repository.dart';

import '../../model/Tyre.dart';

class TempController {
  final TyreRepository _tyreRepository = TyreRepository();

  save(Tyre tyre) async {
    return await _tyreRepository.save(tyre);
  }

  update(Tyre tyre) async {
    await _tyreRepository.update(tyre);
  }

  Future<List<Tyre>> getAll() async {
    return await _tyreRepository.getAll() as List<Tyre>;
  }

  remove(Tyre tyre) async {
    await _tyreRepository.remove(tyre);
  }

  Future<Tyre> getByIndex(int index) async {
    List<Tyre> list = await getAll();

    return list.elementAt(index);
  }

  removeAll() async {
    await _tyreRepository.removeAll();
  }

  createTyres() async
  {
    final Tyre tyre1 = Tyre(name: 'leftUp', psi: 32.2, isLowPressure: false, temp: 40);
    final Tyre tyre2 = Tyre(name: 'RightUp', psi: 34.2, isLowPressure: false, temp: 38);
    final Tyre tyre3 = Tyre(name: 'leftDown', psi: 35.2, isLowPressure: false, temp: 35);
    final Tyre tyre4 = Tyre(name: 'RightDown', psi: 37.2, isLowPressure: false, temp: 42);

    await save(tyre1);
    await save(tyre2);
    await save(tyre3);
    await save(tyre4);
  }
}
