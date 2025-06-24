import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:maple_byte/Model/project_model.dart';
import 'package:maple_byte/Services/project_services.dart';
import 'package:maple_byte/Utils/app_colors.dart';
import 'package:maple_byte/main.dart';

class FinishedScreen extends StatelessWidget {
  final ProjectService _service = ProjectService();

  FinishedScreen({super.key});

  void _confirmDelete(BuildContext context, String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkBlueColor,
        title: const Text(
          'Delete Project?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to delete this project? This action cannot be undone.',
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
      _service.deleteProject(id);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Project deleted')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: _service.getProjectsByStatus('finished'),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
          return const Center(child: Text('No projects finished.'));
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
              padding: const EdgeInsets.all(12),
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
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: p.image.isNotEmpty
                        ? SizedBox(
                            width: mq.width * 0.3,
                            height: mq.width * 0.2,
                            child: Image.network(
                              p.image,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.image_not_supported,
                                    size: 40,
                                  ),
                            ),
                          )
                        : SizedBox(
                            width: mq.width * 0.3,
                            height: mq.width * 0.2,
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 40,
                            ),
                          ),
                  ),
                  const SizedBox(width: 12),
                  // Text Content
                  Expanded(
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
                                'Price: ',
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
                  // Delete Icon
                  IconButton(
                    icon: Icon(Icons.delete, color: AppColors.whiteColor),
                    tooltip: "Delete Project",
                    onPressed: () => _confirmDelete(context, p.id),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
