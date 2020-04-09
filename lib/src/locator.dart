import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cortado_app/src/services/auth_service.dart';
import 'package:cortado_app/src/services/navigation_service.dart';
import 'package:cortado_app/src/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

registerLocatorItems() {
  var firebaseApp = FirebaseApp.instance;
  var firestore = Firestore(app: firebaseApp);
  var firebaseAuth = FirebaseAuth.instance;
  firestore.settings(persistenceEnabled: true);
  locator.registerSingleton(firestore);
  locator.registerLazySingleton(() => true);
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => UserService(firestore));
  locator.registerLazySingleton(() => AuthService(firebaseAuth));
}
