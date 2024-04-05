import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkup/models/message.dart';

class ChatService {
  // get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user stream; listen to our firestore
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go thru each individual user
        final user = doc.data();

        // return user
        return user;
      }).toList();
    });
  }

  // send msg
  Future<void> sendMessage(String receiverID, message) async {
    // get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create new msg
    Message newMessage = Message(
      senderID : currentUserID,
      senderEmail : currentUserEmail,
      receiverID :   receiverID,
      message : message,
      timestamp : timestamp,
    );

    // construct chatroom ID for two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); // sort the ids (this ensure the chartroomID is the same for any 2 people)
    String chatRoomID = ids.join('_');

    // add new msg to database
    await _firestore.collection("chat_rooms").doc(chatRoomID).collection("messages").add(newMessage.toMap());
  }

  // get msg
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection('messages')
        .orderBy("timestamp", descending: false)
        .snapshots();
  }


}