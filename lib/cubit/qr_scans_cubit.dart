import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:qr_lite/database/sqlite/db_sql_services.dart';
import 'package:qr_lite/models/scan_model.dart';

part 'qr_scans_state.dart';

class QrScansCubit extends Cubit<QrScansState> {

  QrScansCubit() : super(const QrScansInitial());


  void getAllScans()async {

    final database = DBservice.db;

    List<ScanModel> scansFromDB = await database.getAllScans();

    List<ScanModel> storage = List.of(scansFromDB);

    storage.removeWhere((e)=> e.storage == 0 );

    scansFromDB.removeWhere( (e)=> e.storage == 1 );

    scansFromDB.forEach((print));  

    emit(QrScansSetState(scansFromDB.reversed.toList(), storage));


  }


  void addScan( ScanModel scan )async {

    final database = DBservice.db;

    final res = await database.newScan(scan);

    scan.id = res;

    emit( QrScansSetState([scan, ...state.scans], [ ...state.storage]) );


  }

  void deleteScans( int id ) async {

    final database = DBservice.db;

    await database.deleteScan(id);

    List<ScanModel> newState = [];

    for (var scan in state.scans) {

      if ( scan.id == id ) continue;

      newState.add(scan);

    }

    // emit(QrScansSetState([...newState]));
  }

  void moveInStorage( ScanModel scanModel )async{

    final db = DBservice.db;

    scanModel.storage = 1;

    await db.updateScan(scanModel);

    final scans = [...state.scans];

    final storage = [scanModel, ...state.storage];

    scans.removeWhere((element) => element.storage == 1);


    emit(QrScansSetState(scans, storage));


  }


}
