import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:maple_byte/Model/project_model.dart';
import 'package:maple_byte/Services/project_services.dart';
import 'package:maple_byte/Utils/app_colors.dart';
import 'package:maple_byte/main.dart';
import 'package:ultimate_bottom_navbar/utils/styles.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final ProjectService _service = ProjectService();
  void _showAddProjectDialog() {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final imageController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkBlueColor,
        title: const Text(
          "Add New Project",
          style: TextStyle(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: descController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: imageController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: priceController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Price',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {
              final project = Project(
                id: '',
                title: titleController.text,
                description: descController.text,
                image: imageController.text,
                price: priceController.text,
                status: 'todo',
              );

              _service.addProject(project);
              Navigator.pop(context);
            },
            child: Text(
              "Add",
              style: TextStyle(color: AppColors.darkBlueColor),
            ),
          ),
        ],
      ),
    );
  }

  void _moveToProgress(BuildContext context, String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkBlueColor,
        title: const Text(
          'Move to In Progress?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to move this project to the In Progress section?',
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
      _service.updateStatus(id, 'inprogress');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Project moved to In Progress')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: StreamBuilder<DatabaseEvent>(
        stream: _service.getProjectsByStatus('todo'),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(child: Text('No projects in To-Do.'));
          }

          final data = Map<String, dynamic>.from(
            snapshot.data!.snapshot.value as Map,
          );
          final projects = data.entries
              .map(
                (e) =>
                    Project.fromMap(e.key, Map<String, dynamic>.from(e.value)),
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
                    // Image Section
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: p.image.isNotEmpty
                          ? SizedBox(
                              width: mq.width * 0.3,
                              height: mq.width * 0.2,
                              child: Image.network(
                                p.image,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.image_not_supported, size: 40),
                              ),
                            )
                          : SizedBox(
                              width: mq.width * 0.3,
                              height: mq.width * 0.2,
                              child: Icon(Icons.image_not_supported, size: 40),
                            ),
                    ),
                    SizedBox(width: 8),

                    // Text Section
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
                    // Action Icon
                    IconButton(
                      icon: Icon(Icons.schedule, color: AppColors.whiteColor),
                      tooltip: "Start Project",
                      onPressed: () => _moveToProgress(context, p.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.darkBlueColor,
        onPressed: _showAddProjectDialog,
        child: const Icon(Icons.add, color: white),
      ),
    );
  }
}
