import 'package:dartz/dartz.dart';

// Core
import '../../../../core/interfaces/interfaces.dart';
// Feature
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInWithEmail extends UseCase<User, SignInParams> {
  final AuthRepository repository;

  SignInWithEmail({required this.repository});

  @override
  Future<Either<Failure, User>> call(SignInParams params) async {
    return repository.signInWithEmail(params.email, params.password);
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}
