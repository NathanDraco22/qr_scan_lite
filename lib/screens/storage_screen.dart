import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_lite/cubit/qr_scans_cubit.dart';
import 'package:qr_lite/models/scan_model.dart';
import 'package:qr_lite/utils/utils.dart';
import 'package:qr_lite/widget/scan_item.dart';


class StorageScreen extends StatelessWidget {
  const StorageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Storage"),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: (){
          BlocProvider.of<QrScansCubit>(context, listen: false).getAllScans();
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.blueGrey
      ),

      body:Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.save_alt_rounded,size: 240, color: Colors.grey.withOpacity(0.4),),
              const SizedBox(height:80)
            ],
          ),
          const _MainContentScans(),
        ],
      )
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

        final listScans = List.of(state.storage);

        return AnimatedList(
          key: listState,
          physics: const BouncingScrollPhysics(),
          initialItemCount: listScans.length, 
          itemBuilder: ( _ , int index, Animation<double> animation) { 

            return ScanItem(
              scanModel: listScans[index],
              onDeletePressed: ()async {
                final bool confirm = await Utils.showQRDialog(context, "Delete this Scan", "");

                if (confirm){
                  BlocProvider.of<QrScansCubit>(context).deleteScans(listScans[index].id!);
                  onDeletePressed(index, listScans, listState);
                }
              },

              onSavePressed:(){}

            );
           },
      
        );

      },
     );
  }

  void onDeletePressed( int index, 
  List<ScanModel> scans, 
  GlobalKey<AnimatedListState> listState,
  ) {

    final removedItem = scans[index];

    scans.removeAt(index);

    listState.currentState!.removeItem(
      index, (context, animation) {

        return SizeTransition(
        sizeFactor: animation,
        child: ScanItem(
          scanModel: removedItem, 
          onDeletePressed: (){},
          onSavePressed: (){},
          ),
        );
      }
    );

  }

}