import 'package:dartz/dartz.dart';

import '../../domain/domain.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService service;

  AuthRepositoryImpl({required this.service});

  @override
  Future<Either<AuthFailure, UserModel?>> getUser() async {
    try {
      final user = await service.getUser();
      return Right(user);
    } on AuthFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Either<AuthFailure, Stream<UserModel?>> authUserChanges() {
    try {
      final stream = service.authUserChanges();
      return Right(stream);
    } on AuthFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> signInWithEmail(String email, String password) async {
    try {
      final user = await service.signInWithEmail(email, password);
      return Right(user);
    } on AuthFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> signUpWithEmail(String email, String password) async {
    try {
      final user = await service.signUpWithEmail(email, password);
      return Right(user);
    } on AuthFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> signInWithGoogle() async {
    try {
      final user = await service.signInWithGoogle();
      return Right(user);
    } on AuthFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> signInWithApple() async {
    try {
      final user = await service.signInWithApple();
      return Right(user);
    } on AuthFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      await service.signOut();
      return Right(unit);
    } on AuthFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> resetPassword(String email) async {
    try {
      await service.resetPassword(email);
      return Right(unit);
    } on AuthFailure catch (exception) {
      return Left(exception);
    }
  }
}
