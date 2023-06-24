import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference _messagesCollection =
  FirebaseFirestore.instance.collection('messages');

  Future<void> sendMessage(String text) async {
    await _messagesCollection.add({
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getMessages() {
    return _messagesCollection
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
