import 'package:image_picker/image_picker.dart';

class ImageUtils {
  static Future<void> takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // Do something with the picked image file
    }
  }

  static Future<void> getPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Do something with the picked image file
    }
  }
}
