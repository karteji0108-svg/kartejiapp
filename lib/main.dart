import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

import 'app/data/services/auth_service.dart';
import 'app/data/services/cloudinary_service.dart';
import 'app/data/services/firestore_service.dart';
import 'app/modules/theme/theme_controller.dart';

import 'app/modules/login/controllers/login_controller.dart';
import 'app/modules/login/views/login_view.dart';
import 'app/modules/member/controllers/member_controller.dart';
import 'app/modules/member/views/member_view.dart';
import 'app/modules/vice_chairman/controllers/vice_chairman_controller.dart';
import 'app/modules/vice_chairman/views/vice_chairman_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initServices();

  runApp(const KartejiApp());
}

Future<void> initServices() async {
  Get.put(FirestoreService());
  Get.put(AuthService());
  Get.put(CloudinaryService());
  // ThemeController needs FirestoreService, so it comes after
  Get.put(ThemeController());
}

class KartejiApp extends StatelessWidget {
  const KartejiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() {
      return GetMaterialApp(
        title: 'KARTEJI',
        theme: themeController.currentTheme.value,
        initialRoute: '/login',
        getPages: [
          GetPage(
            name: '/login',
            page: () => const LoginView(),
            binding: BindingsBuilder(() {
              Get.lazyPut<LoginController>(() => LoginController());
            }),
          ),
          GetPage(
            name: '/member-dashboard',
            page: () => const MemberView(),
            binding: BindingsBuilder(() {
              Get.lazyPut<MemberController>(() => MemberController());
            }),
          ),
          GetPage(
            name: '/vice-chairman-dashboard',
            page: () => const ViceChairmanView(),
            binding: BindingsBuilder(() {
              Get.lazyPut<ViceChairmanController>(() => ViceChairmanController());
            }),
          ),
          GetPage(
            name: '/admin-dashboard',
            page: () => const Scaffold(
              body: Center(child: Text('Admin Dashboard Placeholder')),
            ),
          ),
        ],
      );
    });
  }
}
