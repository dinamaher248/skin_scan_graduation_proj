
class MappingUpload {
  Map<String, dynamic> responseJson;
  int? id;
  String? type;
  String? risk;
  String? name;
  String? description;
  String? image;
  List<String>? preventions;

  MappingUpload({required this.responseJson}) {
    ExtractDataFromJson();
  }
  MappingUpload.Default() : responseJson = new Map<String, dynamic>();

  void ExtractDataFromJson() {
    id = responseJson['data']['id'];
    name = responseJson['data']['name'];
    description = responseJson['data']['description'];
    risk = responseJson['data']['risk'];
    type = responseJson['data']['type'];
    image =responseJson['data']['image'];
    List<dynamic> list = responseJson['data']['preventions'];
    preventions = List<String>.from(list);
    print(description);
  }

  // getters
  int? get Id {
    return id;
  }

  String? get Name {
    return name;
  }

  String? get Type {
    return type;
  }

  String? get Risk {
    return risk;
  }

  String? get Description {
    return description;
  }

  List<String>? get Preventions {
    return preventions;
  }

}
