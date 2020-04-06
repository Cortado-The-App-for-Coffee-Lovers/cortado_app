import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UserModel extends ChangeNotifier {
  User user;

  updateUser(User user) {
    this.user = user;
    notifyListeners();
  }
}

class User {
  FirebaseUser firebaseUser;
  String cbCustomerId;
  String cbPlanId;
  DateTime createdAt;
  DateTime updatedAt;
  bool isAdmin = false;
  String firstName;
  String lastName;
  String phone;
  String email;
  int redemptionsLeft;
  DateTime reloadDate;
  Position currentLocation;
  double moneySaved;

  // only temp stored when doing sign up
  String password;
  AuthCredential phoneAuthCredentials;
  String grade;
  String picture;
  bool termsAgreed = true;
  DocumentReference reference;

  User({this.firebaseUser, this.currentLocation})
      : this.email = firebaseUser?.email,
        this.phone = firebaseUser?.phoneNumber;

  String get id => firebaseUser?.uid;

  User.fromSnapshot(DocumentSnapshot snapshot, {FirebaseUser firebaseUser})
      : this.fromData(
          snapshot.data,
          reference: snapshot.reference,
          firebaseUser: firebaseUser,
        );

  User.fromData(Map<String, dynamic> data,
      {this.reference, this.firebaseUser}) {
    firstName = data['firstName'];
    lastName = data['lastName'];
    moneySaved = data['moneySaved'];
    termsAgreed = data['termsAgreed'] ?? true;
    phone = data['phone'];
    email = data['email'];
    cbCustomerId = data['cbCustomerId'];
    cbPlanId = data['cbPlanId'];
    Timestamp timestamp = data['createdAt'];
    timestamp = timestamp ?? Timestamp.now();
    createdAt =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    updatedAt = data['updatedAt'];
    isAdmin = data['isAdmin'];
    redemptionsLeft = data['redemptionsLeft'] != null
        ? int.parse(data['redemptionsLeft'])
        : null;
    reloadDate = data['reloadDate'];
  }

  Map<String, dynamic> toJson() {
    return {
      "firstName": this.firstName,
      "lastName": this.lastName,
      "moneySaved": this.moneySaved,
      "termsAgreed": this.termsAgreed,
      "email": this.email,
      "phone": this.phone,
      "cbCustomerId": this.cbCustomerId,
      "cbPlanId": this.cbPlanId,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
      "isAdmin": this.isAdmin,
      "redemptionsLeft": this.redemptionsLeft,
      "reloadDate": this.reloadDate
    };
  }
}
