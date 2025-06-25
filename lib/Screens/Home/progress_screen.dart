import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:maple_byte/Model/project_model.dart';
import 'package:maple_byte/Services/project_services.dart';
import 'package:maple_byte/Utils/app_colors.dart';
import 'package:maple_byte/main.dart';

class ProgressScreen extends StatelessWidget {
  final ProjectService _service = ProjectService();

  ProgressScreen({super.key});
  final currentUser = FirebaseAuth.instance.currentUser;

  void _moveToFinished(BuildContext context, String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkBlueColor,
        title: const Text(
          'Move to Finished?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to mark this project as finished?',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No', style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Yes',
              style: TextStyle(color: AppColors.darkBlueColor),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      _service.updateStatus(id, 'finished');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Project marked as Finished')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: _service.getProjectsByStatus('inprogress'),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
          return const Center(child: Text('No projects in Progress.'));
        }

        final data = Map<String, dynamic>.from(
          snapshot.data!.snapshot.value as Map,
        );
        final projects = data.entries
            .map(
              (e) => Project.fromMap(e.key, Map<String, dynamic>.from(e.value)),
            )
            .toList();

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final p = projects[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [AppColors.lightBlueColor, AppColors.darkBlueColor],
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image Section (same as TodoScreen)
                  Container(
                    width: mq.width * 0.3,
                    height: 120,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                    ),
                    child: p.image.isNotEmpty
                        ? Image.network(
                            p.image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 40,
                                  ),
                                ),
                          )
                        : const Center(
                            child: Icon(Icons.image_not_supported, size: 40),
                          ),
                  ),

                  // Text Section (same as TodoScreen)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.title,
                            style: TextStyle(
                              fontFamily: "Inter",
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            p.description,
                            style: TextStyle(
                              fontFamily: "Inter",
                              color: AppColors.whiteColor,
                              fontSize: 16,
                            ),
                          ),
                          if (p.price.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  'Price: € ',
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  p.price,
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  // Action Icon (to mark as finished)
                  currentUser?.email == "admin@gmail.com"
                      ? IconButton(
                          icon: Icon(
                            Icons.check_circle_outline,
                            color: AppColors.whiteColor,
                          ),
                          tooltip: "Mark as Finished",
                          onPressed: () => _moveToFinished(context, p.id),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
