import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final Firestore _firestore;

  UserService(this._firestore);

  CollectionReference get _usersCollection => _firestore.collection('users');

  Future<User> saveUser(
    User userData,
  ) async {
    DocumentReference docRef =
        _usersCollection.document(userData.firebaseUser.uid);
    await docRef.setData(userData.toJson());
    userData.reference = docRef;
    return userData;
  }

  Future<User> getUser(FirebaseUser firebaseUser) async {
    try {
      DocumentSnapshot snapshot =
          await _usersCollection.document(firebaseUser.uid).get();
      return User.fromSnapshot(snapshot, firebaseUser: firebaseUser);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User> getUserFromId(String userId) async {
    DocumentSnapshot snapshot = await _usersCollection.document(userId).get();
    return User.fromSnapshot(snapshot);
  }

/*   Future<bool> removeUser(User member) async {
    try {
      var result = await CloudFunctions.instance
          .getHttpsCallable(functionName: 'user-deleteUser')
          .call({'uid': member.reference.documentID});
      return result.data['result'];
    } catch (e) {
      return false;
    }
  } */
}
