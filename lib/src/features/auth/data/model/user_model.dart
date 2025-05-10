import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String email;

  UserModel({required this.userId, required this.email});

  Map<String, dynamic> toJson() => {"email": email, "userId": userId};

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(email: snapshot['email'], userId: snapshot['userId']);
  }
}
