import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/vice_chairman_controller.dart';

class ViceChairmanView extends GetView<ViceChairmanController> {
  const ViceChairmanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vice Chairman Dashboard'),
        actions: [
          IconButton(
            onPressed: controller.logout,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Obx(() {
        if (controller.projects.isEmpty) {
          return const Center(child: Text('No projects found.'));
        }
        return ListView.builder(
          itemCount: controller.projects.length,
          itemBuilder: (context, index) {
            final project = controller.projects[index];
            final int progress = project['progress'] ?? 0;
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(project['title'] ?? 'Untitled'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Progress: $progress%'),
                    LinearProgressIndicator(value: progress / 100),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => controller.updateProgress(
                          project['id'], progress - 10),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => controller.updateProgress(
                          project['id'], progress + 10),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
