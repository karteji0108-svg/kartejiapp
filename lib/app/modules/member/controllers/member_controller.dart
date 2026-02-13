import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/cloudinary_service.dart';
import '../../../data/services/firestore_service.dart';

class MemberController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final CloudinaryService _cloudinaryService = Get.find<CloudinaryService>();
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  final RxBool isUploading = false.obs;

  Future<void> uploadProofPayment() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      try {
        isUploading.value = true;
        // 1. Upload to Cloudinary
        String? secureUrl = await _cloudinaryService.uploadImage(image);

        if (secureUrl != null) {
          // 2. Save Transaction to Firestore
          String uid = _authService.currentUser.value?.uid ?? '';
          await _firestoreService.addDocument('transactions', {
            'user_id': uid,
            'type': 'transfer',
            'amount': 0, // Should be input by user, simpler for now
            'status': 'pending',
            'proof_url_cloudinary': secureUrl,
            'date': DateTime.now().toIso8601String(),
          });
          Get.snackbar('Success', 'Proof uploaded successfully');
        } else {
          Get.snackbar('Error', 'Failed to upload image');
        }
      } catch (e) {
        Get.snackbar('Error', 'Something went wrong: $e');
      } finally {
        isUploading.value = false;
      }
    }
  }

  void logout() {
    _authService.signOut();
    Get.offAllNamed('/login');
  }
}
