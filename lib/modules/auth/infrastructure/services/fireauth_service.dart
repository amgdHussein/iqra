import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../domain/failures/auth_failure.dart';
import '../models/user_model.dart';
import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<UserModel?> getUser() async {
    final User? user = _firebaseAuth.currentUser;
    if (user != null) {
      return UserModel(id: user.uid, email: user.email!, name: user.displayName ?? '');
    }

    return null;
  }

  @override
  Stream<UserModel?> authUserChanges() {
    return _firebaseAuth.authStateChanges().map((User? user) {
      if (user != null) {
        return UserModel(id: user.uid, email: user.email!, name: user.displayName ?? '');
      }

      return null;
    }).handleError((error) {
      throw AuthFailure(message: _mapFirebaseAuthExceptionToMessage(error));
    });
  }

  @override
  Future<UserModel> signInWithEmail(String email, String password) async {
    try {
      final UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return UserModel(
        id: result.user!.uid,
        email: result.user!.email!,
        name: result.user!.displayName ?? '',
      );
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(message: _mapFirebaseAuthExceptionToMessage(e));
    } catch (e) {
      throw AuthFailure(message: "An unknown error occurred during sign-in.");
    }
  }

  @override
  Future<UserModel> signUpWithEmail(String email, String password) async {
    try {
      final UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return UserModel(
        id: result.user!.uid,
        email: result.user!.email!,
        name: result.user!.displayName ?? '',
      );
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(message: _mapFirebaseAuthExceptionToMessage(e));
    } catch (e) {
      throw AuthFailure(message: "An unknown error occurred during sign-up.");
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential result = await _firebaseAuth.signInWithCredential(credential);
      return UserModel(
        id: result.user!.uid,
        email: result.user!.email!,
        name: result.user!.displayName ?? '',
      );
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(message: _mapFirebaseAuthExceptionToMessage(e));
    } catch (e) {
      throw AuthFailure(message: "An unknown error occurred during Google sign-in.");
    }
  }

  @override
  Future<UserModel> signInWithApple() async {
    try {
      final AuthorizationCredentialAppleID credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final OAuthCredential appleCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(appleCredential);

      return UserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email!,
        name: userCredential.user!.displayName ?? '',
      );
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(message: _mapFirebaseAuthExceptionToMessage(e));
    } catch (e) {
      throw AuthFailure(message: "An unknown error occurred during Apple sign-in.");
    }
  }

  @override
  Future<void> resetPassword(String email) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(message: _mapFirebaseAuthExceptionToMessage(e));
    } catch (e) {
      throw AuthFailure(message: "An unknown error occurred during sign-out.");
    }
  }

  String _mapFirebaseAuthExceptionToMessage(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'wrong-password':
        return 'The password is invalid for the given email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'The user corresponding to the given email has been disabled.';
      case 'user-not-found':
        return 'No user found for the given email address.';
      case 'email-already-in-use':
        return 'An account already exists with the given email address.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different credentials.';
      case 'invalid-credential':
        return 'The provided credential is invalid or has expired.';
      case 'invalid-verification-code':
        return 'The verification code is invalid.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
}
