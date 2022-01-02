part of 'qr_scans_cubit.dart';

@immutable
abstract class QrScansState {

  final List<ScanModel> scans;

  const QrScansState(this.scans);

}

class QrScansInitial extends QrScansState {
  const QrScansInitial() : super( const [] );

}

class QrScansSetState extends QrScansState{
  const QrScansSetState(List<ScanModel> scans) : super(scans);


}
