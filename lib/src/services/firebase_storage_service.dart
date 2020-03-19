import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final StorageReference coffeePicStorageRef =
      FirebaseStorage.instance.ref().child('coffee_shop_pics');

  String coffeePicDownloadUrl;

  getPic(path) {
    StorageReference pathReference = coffeePicStorageRef.child(path);
    pathReference.getDownloadURL();
  }
}
