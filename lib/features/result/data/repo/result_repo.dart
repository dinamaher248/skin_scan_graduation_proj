import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import '../../../../core/Mapping/mapping_upload.dart';
import '../../../../core/helper/token.dart';
import '../../../../core/utils/constants.dart';

class ResultRepository {
  Future<MappingUpload> processImage(String imagePath, String uploadURL) async {
    File image = File(imagePath);
    String url = "$resourceUrl$uploadURL";

    var request = http.MultipartRequest('POST', Uri.parse(url));
    var token = await Tokens.retrieve('access_token');

    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'multipart/form-data';

    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        image.path,
        filename: basename(image.path),
      ),
    );

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();

    MappingUpload upload = MappingUpload.Default();
    try {
      final responseJson = jsonDecode(responseBody);
      upload = MappingUpload(responseJson: responseJson);
    } catch (e) {
      print('Failed to decode JSON response: $e');
    }

    if (response.statusCode == 200) {
      return upload;
    } else {
      throw Exception(
          'Failed to upload photo. Status code: ${response.statusCode}');
    }
  }
}
