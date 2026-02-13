import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/theme/app_theme.dart';
import '../../data/services/firestore_service.dart';

class ThemeController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();
  final Rx<ThemeData> currentTheme = AppTheme.normal.obs;

  @override
  void onInit() {
    super.onInit();
    _listenToThemeChanges();
  }

  void _listenToThemeChanges() {
    _firestoreService
        .getDocumentStream('settings', 'global')
        .listen((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null && data.containsKey('current_theme')) {
          final String themeName = data['current_theme'];
          currentTheme.value = AppTheme.getTheme(themeName);
          Get.changeTheme(currentTheme.value);
        }
      }
    });
  }
}
