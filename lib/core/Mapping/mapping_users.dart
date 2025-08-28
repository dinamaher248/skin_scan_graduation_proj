class MappingUsers {
  Map<String, dynamic> responseJson;

  MappingUsers() : responseJson = <String, dynamic>{};
  MappingUsers.list(this.responseJson) {
    extractDataFromJson();
  }
  String? id;
  String? userName;
 // String? mail;

  void extractDataFromJson() {
    id = responseJson['id']?.toString();
    userName = responseJson['userName']?.toString() ?? "Unknown";
  }

// getters
  String? get Id {
    return id;
  }

  String? get UserName {
    return userName;
  }

  // String? get Mail {
  //   return mail;
  // }
}
