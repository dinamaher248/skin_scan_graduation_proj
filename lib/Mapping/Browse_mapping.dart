class BrowseMapping {
  Map<String, dynamic> responseJson;

  BrowseMapping() : responseJson = <String, dynamic>{};
  BrowseMapping.Map(this.responseJson) {
    extractDataFromJson();
  }
  int? id;
  String? name;

  void extractDataFromJson() {
    id = responseJson['id'];
    name = responseJson['name'];
  }

// getters
  int? get Id {
    return id;
  }

  String? get Name {
    return name;
  }
}
