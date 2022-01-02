import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:qr_lite/database/sqlite/db_sql_services.dart';
import 'package:qr_lite/models/scan_model.dart';

part 'qr_scans_state.dart';

class QrScansCubit extends Cubit<QrScansState> {

  QrScansCubit() : super(const QrScansInitial());


  void getAllScans()async {

    final database = DBservice.db;

    final scansFromDB = await database.getAllScans();

    emit(QrScansSetState(scansFromDB));


  }


  void addScan( ScanModel scan )async {

    final database = DBservice.db;

    final res = await database.newScan(scan);

    scan.id = res;

    emit( QrScansSetState([...state.scans, scan]) );


  }

  void deleteScans( int id ) async {

    final database = DBservice.db;

    await database.deleteScan(id);

    List<ScanModel> newState = [];

    for (var scan in state.scans) {

      if ( scan.id == id ) continue;

      newState.add(scan);

    }

    emit(QrScansSetState([...newState]));


  }


}
