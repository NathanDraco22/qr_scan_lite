


class ScanModel {

  int? id;
  String? type;
  final String value;

  ScanModel({
    this.id, 
    this.type, 
    required this.value}){

      checkType(value);

    }

  factory ScanModel.fromJsonMap( Map<String,dynamic> mapJson ){
    return ScanModel(
      id: mapJson["id"],
      type: mapJson["type"],
      value: mapJson["value"]);
  }

  Map<String, dynamic> toJsonMap(){
    return {
      "id"    : id,
      "type"  : type,
      "value" : value
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


    if(value.contains("tel:")){
      type = "tel" ;
      return;
    } 

    if(value.contains("WIFI")){
      type = "wifi";
      return;
    }

    type = "txt";
    return;



  }

}

