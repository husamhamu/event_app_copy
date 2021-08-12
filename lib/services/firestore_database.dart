import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/app/models/Event.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase {
  final FirebaseFirestore _db;
  final String uid;

  FirestoreDatabase({FirebaseFirestore? firebaseFirestore, required this.uid})
      : _db = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> setEvent(Event event) async {
    // final events = _db.collection('users').doc(uid).collection('events')
    // return events.add(event.toMap());
    final reference =
        _db.collection('users').doc(uid).collection('events').doc(event.id);
    return await reference.set(event.toMap());
  }

  Stream<List<Event>> eventsStream() {
    final events = _db.collection('users').doc(uid).collection('events');
    final snapshots = events.snapshots(); // collectionStream
    return snapshots.map((snapshot) {
      final result = snapshot.docs.map((snapshot) {
        return Event.fromMap(snapshot.data(), snapshot.id);
      }).toList();
      return result;
    });
  }
}
