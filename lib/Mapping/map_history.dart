class MapHistory {
  Map<String, dynamic> responseJson;

  MapHistory() : responseJson = new Map<String, dynamic>();
  MapHistory.Map(this.responseJson) {
    extractDataFromJson();
  }
  /**
   * Id 
    file 
    Type 
    //Location 
    AddedDate
   */
  int? id;
  String? image;
  String? type;
  String? name;
  String? addedDate;

  void extractDataFromJson() {
    id = responseJson['id'];
    type = responseJson['type'];
    name = responseJson['name'];
    image = responseJson['file'];
    addedDate = responseJson['addedDate'];
    print('Extracted Name: $name');
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

  String? get Image {
    return image;
  }

  String? get AddedDate {
    return addedDate;
  }
}
