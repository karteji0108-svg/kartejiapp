import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/auth_service.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }

    try {
      isLoading.value = true;
      await _authService.signIn(emailController.text, passwordController.text);
      await _checkRoleAndNavigate();
    } catch (e) {
      Get.snackbar('Error', 'Login failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _checkRoleAndNavigate() async {
    // Wait for userRole to be populated
    if (_authService.userRole.value.isEmpty) {
      try {
        await _authService.userRole.stream
            .firstWhere((role) => role.isNotEmpty)
            .timeout(const Duration(seconds: 5));
      } catch (e) {
        // Handle timeout or error if role never comes
        Get.snackbar('Error', 'Failed to fetch user role');
        return;
      }
    }
    final role = _authService.userRole.value;

    if (role == 'bendahara' || role == 'sekretaris' || role == 'super_admin') {
       // Placeholder for Admin Dashboard
       Get.offAllNamed('/admin-dashboard');
    } else if (role == 'wakil_ketua') {
      Get.offAllNamed('/vice-chairman-dashboard');
    } else {
      Get.offAllNamed('/member-dashboard');
    }
  }
}
