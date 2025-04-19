import 'dart:convert';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class ImageService {
  static const int maxWidth = 1024;
  static const int maxHeight = 1024;
  static const int jpegQuality = 85;

  static Future<String> processImageForSending(XFile image) async {
    // Read the image file
    Uint8List imageBytes = await image.readAsBytes();
    
    // Decode the image
    img.Image? originalImage = img.decodeImage(imageBytes);
    if (originalImage == null) throw Exception('Failed to decode image');
    
    // Calculate aspect ratio preserving dimensions
    double ratio = originalImage.width / originalImage.height;
    int targetWidth = originalImage.width;
    int targetHeight = originalImage.height;
    
    if (targetWidth > maxWidth) {
      targetWidth = maxWidth;
      targetHeight = (maxWidth / ratio).round();
    }
    
    if (targetHeight > maxHeight) {
      targetHeight = maxHeight;
      targetWidth = (maxHeight * ratio).round();
    }
    
    // Resize image while maintaining aspect ratio
    img.Image resizedImage = img.copyResize(
      originalImage,
      width: targetWidth,
      height: targetHeight,
      interpolation: img.Interpolation.linear
    );
    
    // Encode as JPEG with quality setting
    List<int> compressedBytes = img.encodeJpg(resizedImage, quality: jpegQuality);
    
    // Convert to base64
    return base64Encode(compressedBytes);
  }
}