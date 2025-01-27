import 'package:dartz/dartz.dart';

import '../../../../core/interfaces/failure.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, User?>> getUser();
  Either<Failure, Stream<User?>> authUserChanges();
  Future<Either<Failure, User>> signInWithEmail(String email, String password);
  Future<Either<Failure, User>> signUpWithEmail(String email, String password);
  Future<Either<Failure, User>> signInWithGoogle();
  Future<Either<Failure, User>> signInWithApple();
  Future<Either<Failure, Unit>> resetPassword(String email);
  Future<Either<Failure, Unit>> signOut();
}
