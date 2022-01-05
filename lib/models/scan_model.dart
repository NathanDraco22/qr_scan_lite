import 'package:qr_lite/models/wifi_model.dart';

class ScanModel {

  @override
  String toString() {
    return "scan storage = $storage";
  }

  int? id;
  String? type;
  int? storage = 0;
  WifiModel? wifiModel;
  String? valueToShow;
  final String value;

  ScanModel({
    this.id, 
    this.type,
    this.storage = 0, 
    required this.value}){

      checkType(value);

    }

  factory ScanModel.fromJsonMap( Map<String,dynamic> mapJson ){
    return ScanModel(
      id: mapJson["id"],
      type: mapJson["type"],
      value: mapJson["value"],
      storage: mapJson["storage"] ?? 0
      );
  }

  Map<String, dynamic> toJsonMap(){
    return {
      "id"      : id,
      "type"    : type,
      "value"   : value,
      "storage" : storage
    };

  }

  checkType( String value){

    if(value.contains("maps.")){
      type = "geo";
      return;
    } 

    if(value.contains("http")){
      type = "web";
      return;
    } 

    if(value.contains("geo")){
      type = "geo";
      return;
    } 


    if(value.contains("tel:") || value.contains("TEL:") ){
      type = "tel" ;
      return;
    } 

    if(value.contains("WIFI")){
      type = "wifi";

      wifiModel = WifiModel.fromRawString(value);

      valueToShow = "WiFi: ${ wifiModel?.name }\nPass: ${ wifiModel?.password }";

      return;
    }

    type = "txt";
    return;



  }

}

