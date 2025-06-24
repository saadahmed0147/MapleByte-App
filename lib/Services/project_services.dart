import 'package:firebase_database/firebase_database.dart';
import '../Model/project_model.dart';

class ProjectService {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref().child(
    'projects',
  );

  Stream<DatabaseEvent> getProjectsByStatus(String status) {
    return _ref.orderByChild('status').equalTo(status).onValue;
  }

  Future<void> addProject(Project project) {
    final newRef = _ref.push();
    return newRef.set(project.toMap());
  }

  Future<void> updateStatus(String id, String newStatus) {
    return _ref.child(id).update({'status': newStatus});
  }

  Future<void> deleteProject(String id) {
    return _ref.child(id).remove();
  }
}
