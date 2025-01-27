import '../models/user_model.dart';

abstract class AuthService {
  Future<UserModel?> getUser();
  Stream<UserModel?> authUserChanges();
  Future<UserModel> signInWithEmail(String email, String password);
  Future<UserModel> signUpWithEmail(String email, String password);
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithApple();
  Future<void> resetPassword(String email);
  Future<void> signOut();
}
