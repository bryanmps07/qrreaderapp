import 'dart:async';

import 'package:qrreaderapp/src/bloc/validator.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';



class ScansBloc with Validators {

  static final ScansBloc _singleton = new ScansBloc._internal();

  //se ejecuta al instanciar la clase ScansBloc en cualquiere lado devuelve el _singleton o otra cosa.
  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    //Obtener Scans de la Base de Datos
    obtenerScans();
  }

  //controlador
  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream     => _scansController.stream.transform( validarGeo );
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform( validarHttp );
   
  dispose() {
    _scansController?.close();
  }

  obtenerScans() async {
    _scansController.sink.add( await DBProvider.db.getTodosScans() );
  }

  agregarScan( ScanModel scan ) async{
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  borrarScan( int id ) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScanTODOS() async {
    await DBProvider.db.deleteAll();
    obtenerScans();

    //otra forma de obtener todos los registros aunque ya sabemos que se borraron todos
    //_scansController.sink.add([]);
  } 






}