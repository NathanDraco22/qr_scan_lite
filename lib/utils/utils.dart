
import 'package:flutter/material.dart';

class Utils {

  static Widget? selectIcon(String tipo){

    const double iconSize = 36.0;

    Map <String,Widget> iconsMap = {

      "web"   : const Icon(Icons.language,color: Colors.lightGreenAccent, size: iconSize ,),
      "wifi"  : const Icon(Icons.wifi,color: Colors.yellowAccent , size: iconSize),
      "geo"   : const Icon(Icons.location_on, color: Colors.redAccent, size: iconSize),
      "tel"   : const Icon(Icons.phone, color: Colors.cyanAccent , size: iconSize),
      "txt" : const Icon(Icons.sticky_note_2, color: Colors.amberAccent , size: iconSize),
      "mail"  : const Icon(Icons.mail, color: Colors.orangeAccent , size: iconSize),
      "sms"   : const Icon(Icons.sms, color: Colors.lightBlueAccent , size: iconSize)
    };

    return iconsMap[tipo];
  }

  static   Future<bool> showQRDialog(
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