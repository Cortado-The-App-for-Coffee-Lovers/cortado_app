import 'package:cloud_firestore/cloud_firestore.dart';

class CoffeeShop {
  String id;
  String name;
  Map<dynamic, dynamic> address;
  String blackDescription;
  String createdAt;
  String updatedAt;
  String description;
  String disabledReason;
  String picture;
  dynamic hours;
  String phone;
  String premiumDescription;
  DocumentReference reference;
  double currentDistance;

  CoffeeShop(
      this.reference,
      this.name,
      this.address,
      this.phone,
      this.hours,
      this.blackDescription,
      this.createdAt,
      this.description,
      this.disabledReason,
      this.premiumDescription,
      this.updatedAt,
      this.currentDistance,
      this.picture);

  CoffeeShop.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromData(snapshot.data, reference: snapshot.reference);

  CoffeeShop.fromData(Map<dynamic, dynamic> data, {this.reference})
      : this.id = reference.documentID,
        this.name = data['name'],
        this.address = data['address'],
        this.blackDescription = data['blackDescription'],
        this.createdAt = data['createdAt'],
        this.updatedAt = data['updatedAt'],
        this.description = data['description'],
        this.disabledReason = data['disabledReason'],
        this.hours = data['hours'],
        this.phone = data['phone'],
        this.picture = data['picture'],
        this.premiumDescription = data['premiumDescription'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'hours': hours,
      'blackDescription': blackDescription,
      'createdAt': createdAt,
      'description': description,
      'disabledReason': disabledReason,
      'premiumDescription': premiumDescription,
      'updatedAt': updatedAt,
      'picture': picture
    };
  }
}
