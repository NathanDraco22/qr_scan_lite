import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_lite/cubit/Theme/theme_cubit.dart';
import 'package:qr_lite/cubit/qr_scans_cubit.dart';
import 'package:qr_lite/models/scan_model.dart';
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
            if(result != null) {

              qrCubit.addScan(result);

            }
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

        final GlobalKey<AnimatedListState>listState = GlobalKey<AnimatedListState>();

        final listScans = List.of(state.scans);

        return AnimatedList(
          key: listState,
          physics: const BouncingScrollPhysics(),
          initialItemCount: listScans.length, 
          itemBuilder: ( _ , int index, Animation<double> animation) { 

            return ScanItem(
              scanModel: listScans[index],
              onDeletePressed: ()async {
                final bool confirm = await showQRDialog(context);

                if (confirm){
                  BlocProvider.of<QrScansCubit>(context).deleteScans(listScans[index].id!);
                  onDeletePressed(index, listScans, listState);
                }

              }
            );
           },
      
        );

      },
     );
  }


  Future<bool> showQRDialog(BuildContext context)async {

    bool confirm = false;

    await showDialog<bool>(context: context,
    builder: ( _ )=> AlertDialog(
      title: const Text("Delete this Scan"),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            primary:  Colors.red.shade400,
          ),
          onPressed: (){
            Navigator.pop(context);
          }, 
          child: const Text("No", style: TextStyle(fontWeight: FontWeight.bold),),),
        TextButton(
           style: TextButton.styleFrom(
             primary:  Colors.blue.shade400,
          ),
          onPressed: (){
            confirm = true;
            Navigator.pop(context);
          }, 
          child: const Text("Yes", style: TextStyle(fontWeight: FontWeight.bold),))
      ],
    )
    );

    return confirm;

  }

  void onDeletePressed( int index, 
  List<ScanModel> scans, GlobalKey<AnimatedListState> listState) {


    final removedItem = scans[index];

    scans.removeAt(index);


    listState.currentState!.removeItem(
      index, (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: ScanItem(
          scanModel: removedItem, 
          onDeletePressed: (){}),
      )
    );

  }
}