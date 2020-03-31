import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cortado_app/src/bloc/sign_up/bloc.dart';
import 'package:cortado_app/src/services/user_service.dart';
import 'package:flutter/services.dart';
import '../../data/user.dart';
import '../../locator.dart';
import '../../services/auth_service.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  AuthService get _authService => locator.get();
  UserService get _userService => locator.get();
  @override
  SignUpState get initialState => SignUpInitial();

  @override
  void onTransition(Transition<SignUpEvent, SignUpState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is SignUpEmailPassword) {
      try {
        if (event.password != event.retypePassword) {
          yield SignUpErrorState('Passwords do not match');
        } else if (event.password.length < 6) {
          yield SignUpErrorState('Password is not long enough');
        } else {
          yield SignUpLoadingState();
          var user = User();
          user
            ..email = event.email
            ..password = event.password;
          bool emailInUse = await _authService.isEmailInUse(event.email);
          if (!emailInUse) {
            yield SignUpInitialComplete(user);
          } else {
            yield SignUpErrorState('Email is already in use.');
          }
        }
      } catch (error) {
        yield SignUpErrorState('An error occured');
      }
    }

    if (event is SignUpPhonePressed) {
      try {
        yield SignUpLoadingState();
        User user = event.user;
        user.phone = event.phone;

        Completer<SignUpState> verifyCompleter = Completer();
        Completer<SignUpState> autoVerifyCompleter = Completer();

        await _authService.verifyPhoneNumber(
          phoneNumber: event.phone,
          verificationCompleted: (authCredentials) async {
            event.user.phoneAuthCredentials = authCredentials;
            User updatedUser = await _phoneVerified(user);
            autoVerifyCompleter
                .complete(SignUpPhoneVerificationComplete(updatedUser));
            return;
          },
          verificationFailed: (authException) {
            verifyCompleter.complete(SignUpErrorState(authException.message));
            return;
          },
          codeSent: (verificationId, [int forceResendingToken]) {
            verifyCompleter.complete(
                SignUpPhoneVerificationSent(user, verificationId, user.phone));
            return;
          },
          codeAutoRetrievalTimeout: (verificationId) {
            verifyCompleter.complete(SignUpErrorState('Verification timeout'));
            return;
          },
        );
        await for (SignUpState state in Stream.fromFutures(
            [verifyCompleter.future, autoVerifyCompleter.future])) {
          yield state;
          return;
        }
      } catch (e) {
        yield SignUpErrorState(e.toString());
      }
    }
    if (event is SignUpVerifyPressed) {
      yield SignUpLoadingState();
      try {
        var user = await _authService.checkVerificationCode(
            event.user, event.verificationId, event.code);
        User updatedUser = await _phoneVerified(user);
        updatedUser = await _userService.saveUser(updatedUser);
        yield SignUpPhoneVerificationComplete(updatedUser);
      } catch (e) {
        print('Verification error: $e');
        String error = 'There was an issue verifying your number.';
        if (e is PlatformException) {
          if (e.code == 'ERROR_CREDENTIAL_ALREADY_IN_USE') {
            error = 'Phone number is already in use with another account.';
          } else if (e.code == 'ERROR_INVALID_VERIFICATION_CODE') {
            error = 'Invalid verification code.';
          }
        }
        // Need to delete the attempt to create the user
        var firebaseUser = await _authService.getCurrentFBUser();
        try {
          await firebaseUser?.delete();
        } catch (e) {
          print('Failed to reset the user $e');
        }
        yield SignUpErrorState(error);
      }
    }
  }

  Future<User> _phoneVerified(User user) async {
    var firebaseUser = await _authService.signUp(user.email, user.password);
    await firebaseUser.linkWithCredential(user.phoneAuthCredentials);
    print('_phoneVerified: $firebaseUser');
    user.firebaseUser = firebaseUser;
    user = await _userService.saveUser(user);
    return user;
  }
}
