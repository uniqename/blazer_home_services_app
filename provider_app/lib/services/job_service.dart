import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/job.dart';

class JobService {
  static final CollectionReference _jobsCollection = FirebaseFirestore.instance.collection('jobs');
  static final CollectionReference _applicationsCollection = FirebaseFirestore.instance.collection('job_applications');

  // Get available jobs for provider based on their service types and location
  static Stream<List<Job>> getAvailableJobs(List<String> providerServiceTypes, {String? location}) {
    Query query = _jobsCollection
        .where('status', isEqualTo: 'pending')
        .where('serviceType', whereIn: providerServiceTypes)
        .orderBy('createdAt', descending: true);

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Job.fromFirestore(doc)).toList();
    });
  }

  // Get jobs assigned to specific provider
  static Stream<List<Job>> getProviderJobs(String providerId) {
    return _jobsCollection
        .where('providerId', isEqualTo: providerId)
        .orderBy('scheduledDate', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Job.fromFirestore(doc)).toList();
    });
  }

  // Apply for a job
  static Future<bool> applyForJob(String jobId, String providerId, double proposedPrice, String message) async {
    try {
      // Check if provider already applied
      final existingApplication = await _applicationsCollection
          .where('jobId', isEqualTo: jobId)
          .where('providerId', isEqualTo: providerId)
          .get();

      if (existingApplication.docs.isNotEmpty) {
        return false; // Already applied
      }

      await _applicationsCollection.add({
        'jobId': jobId,
        'providerId': providerId,
        'proposedPrice': proposedPrice,
        'message': message,
        'status': 'pending',
        'appliedAt': FieldValue.serverTimestamp(),
      });

      return true;
    } catch (e) {
      print('Error applying for job: $e');
      return false;
    }
  }

  // Accept a job (when customer selects provider)
  static Future<bool> acceptJob(String jobId, String providerId) async {
    try {
      await _jobsCollection.doc(jobId).update({
        'providerId': providerId,
        'status': 'accepted',
        'acceptedAt': FieldValue.serverTimestamp(),
      });

      // Update application status
      final applications = await _applicationsCollection
          .where('jobId', isEqualTo: jobId)
          .where('providerId', isEqualTo: providerId)
          .get();

      for (var doc in applications.docs) {
        await doc.reference.update({'status': 'accepted'});
      }

      return true;
    } catch (e) {
      print('Error accepting job: $e');
      return false;
    }
  }

  // Update job status
  static Future<bool> updateJobStatus(String jobId, String status) async {
    try {
      Map<String, dynamic> updateData = {'status': status};
      
      switch (status) {
        case 'in_progress':
          updateData['startedAt'] = FieldValue.serverTimestamp();
          break;
        case 'completed':
          updateData['completedAt'] = FieldValue.serverTimestamp();
          break;
      }

      await _jobsCollection.doc(jobId).update(updateData);
      return true;
    } catch (e) {
      print('Error updating job status: $e');
      return false;
    }
  }

  // Get job applications for a specific job
  static Stream<List<Map<String, dynamic>>> getJobApplications(String jobId) {
    return _applicationsCollection
        .where('jobId', isEqualTo: jobId)
        .orderBy('appliedAt', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  // Get provider's job applications
  static Stream<List<Map<String, dynamic>>> getProviderApplications(String providerId) {
    return _applicationsCollection
        .where('providerId', isEqualTo: providerId)
        .orderBy('appliedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  // Update job location (for tracking)
  static Future<bool> updateJobLocation(String jobId, double latitude, double longitude) async {
    try {
      await _jobsCollection.doc(jobId).update({
        'currentLocation': {
          'latitude': latitude,
          'longitude': longitude,
          'updatedAt': FieldValue.serverTimestamp(),
        }
      });
      return true;
    } catch (e) {
      print('Error updating job location: $e');
      return false;
    }
  }
}