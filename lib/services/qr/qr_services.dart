import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_lite/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart' as ul;


class QRservice {

  static Future<ScanModel?> launchQRScanner()async{
//--- Init QR and BarCode Scanner-----------------
    String result = 
      await FlutterBarcodeScanner.scanBarcode(
        "#00FF00", 
        "Cancel", 
        true, 
        ScanMode.DEFAULT
      );

//--- Check if have a valid scan----------------
    if(result == "-1") return null ;

//--- try to launch a url-----------------------

    await tryLaunch(result);

    return ScanModel(value: result);

  }

  static Future<bool> tryLaunch(String result)async{

    if( await ul.canLaunch(result) ){

      ul.launch(result);

      ScanModel(
        value: result
      ); 
      return true;     
    
    }

    return false;
  }



  
}