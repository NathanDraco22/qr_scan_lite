import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_lite/cubit/Theme/theme_cubit.dart';
import 'package:qr_lite/cubit/qr_scans_cubit.dart';
import 'package:qr_lite/services/qr/qr_services.dart';
import 'package:qr_lite/widget/custom_drawe.dart';
import 'package:qr_lite/widget/scan_item.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final qrCubit = BlocProvider.of<QrScansCubit>(context, listen: false);
    final themeCubit = BlocProvider.of<ThemeCubit>(context, listen: false);

    qrCubit.getAllScans();

    return Scaffold(

      drawer: CustomDrawer(themeCubit: themeCubit),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.qr_code),
          onPressed: ()async{
            final result = await QRservice.launchQRScanner();
            result != null ? qrCubit.addScan(result) : null;
          }
        ),

      appBar: AppBar(
        title: const Text("QR Scans"),
      ),

      body: const _MainContentScans()

    );
  }
}



class _MainContentScans extends StatelessWidget {
  const _MainContentScans({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<QrScansCubit, QrScansState>(

      builder: (BuildContext context, state) {  

        final listScans = state.scans;

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: listScans.length,
          itemBuilder: ( _ , i ){

            final scan = listScans[i];

            return ScanItem(scanModel: scan,);


          }

       );

      },
     );
  }
}