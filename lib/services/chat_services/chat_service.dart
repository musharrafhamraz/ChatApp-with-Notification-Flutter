import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  // get instance of firestore

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((docs) {
        final user = docs.data();

        return user;
      }).toList();
    });
  }

  // send messages

  // get messages
}
