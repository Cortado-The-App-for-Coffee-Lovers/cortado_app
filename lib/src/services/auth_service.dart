import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/locator.dart';
import 'package:cortado_app/src/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  UserService get _userService => locator.get();

  final FirebaseAuth _firebaseAuth;
  String verificationId;

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
    var list;
    try {
      print(email);
      list = await _firebaseAuth.fetchSignInMethodsForEmail(email: email);
    } catch (e) {
      print(e);
    }
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

  Future<void> sendCodeToPhoneNumber(String phone, User user) async {
    try {
      final PhoneVerificationCompleted verificationCompleted =
          (AuthCredential phoneAuthCredential) {
        print(
            'Inside _sendCodeToPhoneNumber: signInWithPhoneNumber auto succeeded: $phoneAuthCredential');
      };

      final PhoneVerificationFailed verificationFailed =
          (AuthException authException) {
        print(
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
      };

      final PhoneCodeSent codeSent =
          (String verificationId, [int forceResendingToken]) async {
        this.verificationId = verificationId;
        print("code sent to " + phone);
      };

      final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
          (String verificationId) {
        this.verificationId = verificationId;
        print("time out");
      };

      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      print(e.toString());
    }
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
