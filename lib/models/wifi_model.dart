


class WifiModel {

  String name;
  String password;

  WifiModel({
    required this.name,
    required this.password
  });

  factory WifiModel.fromRawString(String rawString){

    RegExp nameDetector = RegExp(r"S:[\w\s_?-@!]*");

    RegExp passDetector = RegExp(r"P:[\w\s!@#$%^&*()_+\-=?<>/\\.,]*");

    RegExpMatch? nameMatch =  nameDetector.firstMatch(rawString);
    RegExpMatch? passMatch =  passDetector.firstMatch(rawString);

    String? nameElements = nameMatch?.groups([0])[0];
    String? passElements = passMatch?.groups([0])[0];

    nameElements = nameElements?.substring(2);
    passElements = passElements?.substring(2);

    return WifiModel(name: nameElements ?? "", password: passElements ?? "");

  }

  @override
  String toString() {
    return "WiFi name: $name pass: $password";
  }


}