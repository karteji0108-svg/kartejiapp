import 'package:get/get.dart';
import '../../../data/services/firestore_service.dart';
import '../../../data/services/auth_service.dart';

class ViceChairmanController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();
  final AuthService _authService = Get.find<AuthService>();

  final RxList<Map<String, dynamic>> projects = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchProjects();
  }

  void _fetchProjects() {
    _firestoreService.getCollectionStream('projects').listen((snapshot) {
      projects.value = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  Future<void> updateProgress(String projectId, int newProgress) async {
    try {
      if (newProgress < 0) newProgress = 0;
      if (newProgress > 100) newProgress = 100;

      await _firestoreService.updateDocument('projects', projectId, {
        'progress': newProgress,
      });
      Get.snackbar('Success', 'Project progress updated');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update progress: $e');
    }
  }

  void logout() {
    _authService.signOut();
    Get.offAllNamed('/login');
  }
}
