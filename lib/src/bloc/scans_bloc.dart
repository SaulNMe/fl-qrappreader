import 'dart:async';

import 'package:qrappreader/src/bloc/validator.dart';
import 'package:qrappreader/src/providers/db_provider.dart';

class ScansBloc with Validators{
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal(){
    obtenerScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scanStream => _scansController.stream.transform(validarGeo);
  Stream<List<ScanModel>> get scanStreamHttp => _scansController.stream.transform(validarHttp);

  dispose() {
    _scansController?.close();
  }

  agregarScan(ScanModel scan) async {
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  obtenerScans() async{
    _scansController.sink.add(await DBProvider.db.getTodosScans());

  }

  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarTodosScan() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }


}