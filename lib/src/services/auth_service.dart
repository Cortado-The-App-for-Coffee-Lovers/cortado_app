
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/locator.dart';
import 'package:cortado_app/src/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  UserService get _userService => locator.get();

  final FirebaseAuth _firebaseAuth;

  AuthService(FirebaseAuth firebaseAuth) : _firebaseAuth = firebaseAuth;

  Future<FirebaseUser> signIn(String email, String password) async {
    AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return authResult.user;
  }

  Stream<FirebaseUser> listenForUser() {
    return _firebaseAuth.onAuthStateChanged;
  }

  Future<bool> isEmailInUse(String email) async {
    var list = await _firebaseAuth.fetchSignInMethodsForEmail(email: email);
    return list.isNotEmpty;
  }

  Future<FirebaseUser> signUp(String email, String password) async {
    AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return authResult.user;
  }

  Future<FirebaseUser> getCurrentFBUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<User> getCurrentUser() async {
    User user = await _userService.getUser(await getCurrentFBUser());
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  verifyPhoneNumber({
    String phoneNumber,
    PhoneVerificationCompleted verificationCompleted,
    PhoneVerificationFailed verificationFailed,
    PhoneCodeSent codeSent,
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(minutes: 2),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<User> checkVerificationCode(User user, String id, String code) async {
    AuthCredential credential =
        PhoneAuthProvider.getCredential(verificationId: id, smsCode: code);
    print('Auth: $credential');
    return user..phoneAuthCredentials = credential;
  }

  forgotPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
