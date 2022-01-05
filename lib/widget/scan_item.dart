import 'package:flutter/material.dart';
import 'package:qr_lite/models/scan_model.dart';
import 'package:qr_lite/services/qr/qr_services.dart';
import 'package:qr_lite/utils/utils.dart';



class ScanItem extends StatelessWidget {
  const ScanItem({Key? key, 
  required this.scanModel, 
  required this.onDeletePressed, 
  required this.onSavePressed}) 
    : super(key: key);

  final ScanModel scanModel;
  final void Function() onDeletePressed;
  final void Function() onSavePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      height: 105,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).primaryColor,
      ),
    
      child: Stack(children: [
    
        _WidgetHeader(scanModel: scanModel, onDeletePressed: onDeletePressed,),
        
        Positioned(
          left: 8,
          top: 25,
          child: _IconCircle(scanModel: scanModel),
        ),
    
        Positioned(
          right: 4,
          bottom: 4,
          child: _Buttons(scanModel: scanModel,onSavePressed: onSavePressed,)
        )
    
      ],),
    
    );
  }
}

class _WidgetHeader extends StatelessWidget {
  const _WidgetHeader({
    Key? key,
    required this.scanModel, 
    required this.onDeletePressed,
  }) : super(key: key);

  final ScanModel scanModel;
  final void Function()? onDeletePressed;

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
          child: Text(scanModel.type?.toUpperCase() ?? ""),
        ), 
        IconButton(
          splashRadius: 20,
          padding: EdgeInsets.zero,
          onPressed: onDeletePressed,
          icon: Icon(
            Icons.delete, 
            color: Colors.red.shade400,)
        )
      ],);
  }
}

class _IconCircle extends StatelessWidget {
  const _IconCircle({
    Key? key,
    required this.scanModel,
  }) : super(key: key);

  final ScanModel scanModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          shape: BoxShape.circle
        ),

        child: Utils.selectIcon(scanModel.type!)
      ),
      ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 220 ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            scanModel.valueToShow ?? scanModel.value,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        )
        
        )
    ],);
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    Key? key,
    required this.scanModel, required this.onSavePressed
  }) : super(key: key);

  final ScanModel scanModel;
  final Function() onSavePressed;

  @override
  Widget build(BuildContext context) {

    return Row(children: [

      scanModel.storage == 1 
      ? const SizedBox()
      : SizedBox(
        height: 30,
        width: 70,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.blue.shade200
          ),
          onPressed: onSavePressed, 
          child: const Icon(Icons.save_alt, size: 24,color: Colors.white,),
        )
        
      ),

      const SizedBox(width: 30,),

      SizedBox(
        height: 30,
        width: 70,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.green.shade300
          ),
          onPressed: () async {

            final isLaunched = await QRservice.tryLaunch(scanModel.value);

            if(isLaunched) return;

            if ( scanModel.type == "wifi"){
              
              showQRDialog(context, "Connect To ${ scanModel.wifiModel?.name }", "");

              return;

            }

            showQRDialog(context, "", scanModel.value);

          }, 
          child: const Icon(Icons.arrow_forward_sharp, size: 24,color: Colors.white,),
        )
        
      ),
      
    ],);
  }


    Future<bool> showQRDialog(
    BuildContext context, 
    String title, 
    String message)async {

      bool confirm = false;

      await showDialog<bool>(context: context,
      builder: ( _ )=> AlertDialog(
        title: title != "" ? Text(title) : null,
        content: message != ""? Text(message) : null,
        actions: title == ""? null : [
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



}