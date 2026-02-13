import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/member_controller.dart';

class MemberView extends GetView<MemberController> {
  const MemberView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Dashboard'),
        actions: [
          IconButton(
            onPressed: controller.logout,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome, Member!'),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.isUploading.value) {
                return const CircularProgressIndicator();
              } else {
                return ElevatedButton.icon(
                  onPressed: controller.uploadProofPayment,
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Upload Proof of Payment'),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
