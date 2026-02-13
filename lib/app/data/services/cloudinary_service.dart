import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CloudinaryService extends GetxService {
  final dio.Dio _dio = dio.Dio();
  final String _cloudName = 'dbxktcwug';
  final String _uploadPreset = 'Karteji';

  Future<String?> uploadImage(XFile file) async {
    try {
      String fileName = file.path.split('/').last;
      dio.FormData formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(file.path, filename: fileName),
        'upload_preset': _uploadPreset,
      });

      dio.Response response = await _dio.post(
        'https://api.cloudinary.com/v1_1/$_cloudName/image/upload',
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data['secure_url'];
      } else {
        print('Cloudinary Upload Failed: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading to Cloudinary: $e');
      return null;
    }
  }
}
