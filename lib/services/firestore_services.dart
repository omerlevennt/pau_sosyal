import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  final CollectionReference events =
      FirebaseFirestore.instance.collection("Events");
  Stream<QuerySnapshot> getEvents() {
    final eventsStream = events.orderBy('date', descending: false).snapshots();
    return eventsStream;
  }

  final CollectionReference project =
      FirebaseFirestore.instance.collection("Projects");
  Stream<QuerySnapshot> getProject() {
    final eventsStream = project.snapshots();
    return eventsStream;
  }

  final CollectionReference job = FirebaseFirestore.instance.collection("Jobs");
  Stream<QuerySnapshot> getJobs() {
    final eventsStream = job.snapshots();
    return eventsStream;
  }

  final CollectionReference noti =
      FirebaseFirestore.instance.collection("notifications");
  Stream<QuerySnapshot> getNoti() {
    final eventsStream = noti.snapshots();
    return eventsStream;
  }

  Future<DocumentSnapshot?> getEvent(String eventId) async {
    final CollectionReference eventsRef =
        FirebaseFirestore.instance.collection('events');
    return await eventsRef.doc(eventId).get();
  }
}
