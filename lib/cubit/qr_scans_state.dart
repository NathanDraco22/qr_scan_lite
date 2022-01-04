part of 'qr_scans_cubit.dart';

@immutable
abstract class QrScansState {

  final List<ScanModel> scans;
  final List<ScanModel> storage;

  const QrScansState({required this.scans, required this.storage});

}

class QrScansInitial extends QrScansState {
  const QrScansInitial() : super( scans: const [], storage: const [] );

}

class QrScansSetState extends QrScansState{
  const QrScansSetState(List<ScanModel> scans, List<ScanModel> storage) 
    : super( scans: scans, storage: storage);


}
