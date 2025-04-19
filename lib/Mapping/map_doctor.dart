class MapDoctor {
  Map<String, dynamic> responseJson;

  MapDoctor() : responseJson = <String, dynamic>{};
  MapDoctor.Map(this.responseJson) {
    extractDataFromJson();
  }
  String? id;
  String? email;
  String? name;
  String? phone;

  void extractDataFromJson() {
    id = responseJson['id'];
    name = responseJson['name'];
    email = responseJson['email'];
    phone = responseJson['phoneNumber'];
  }

// getters
  String? get Id {
    return id;
  }

  String? get Name {
    return name;
  }

  String? get Email {
    return email;
  }

  String? get Phone {
    return phone;
  }
}
