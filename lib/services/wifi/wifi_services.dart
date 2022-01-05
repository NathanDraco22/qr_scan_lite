
import 'package:qr_lite/models/wifi_model.dart';
import 'package:wifi_iot/wifi_iot.dart';


class WifiService{


  static Future<bool> conectToWifi( WifiModel? wifiModel, {Function? onConnected} )async{

    if (wifiModel == null ) return false;

    WiFiForIoTPlugin.setEnabled(true);

    WiFiForIoTPlugin.forceWifiUsage(true);

    WiFiForIoTPlugin.connect(
      wifiModel.name, 
      password: wifiModel.password,
      security: NetworkSecurity.WPA,
      withInternet: true
      ).then(
      (value){

        if (onConnected != null){
          onConnected();
        }

        if (value) WiFiForIoTPlugin.forceWifiUsage(false);
      });



    return true;

  }


}