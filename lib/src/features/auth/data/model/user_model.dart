import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// class UserModel {
//   String? userId;
//   String? email;
//   String? password;
//   UserModel({this.userId, this.email, this.password});

//   Map<String, dynamic> toMap() {
//     final result = <String, dynamic>{};

//     if (userId != null) {
//       result.addAll({'userId': userId});
//     }
//     if (email != null) {
//       result.addAll({'email': email});
//     }
//     if (password != null) {
//       result.addAll({'password': password});
//     }

//     return result;
//   }

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       userId: map['userId'],
//       email: map['email'],
//       password: map['password'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory UserModel.fromJson(String source) =>
//       UserModel.fromMap(json.decode(source));
//   static UserModel fromSnap(DocumentSnapshot snap) {
//     var snapshot = snap.data() as Map<String, dynamic>;

//     return UserModel(email: snapshot['email'], userId: snapshot['userId']);
//   }
// }

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
