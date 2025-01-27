import 'package:dartz/dartz.dart';

// Core
import '../../../../core/interfaces/interfaces.dart';
// Feature
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpWithEmail extends UseCase<User, SignUpParams> {
  final AuthRepository repository;

  SignUpWithEmail({required this.repository});

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return repository.signUpWithEmail(params.email, params.password);
  }
}

class SignUpParams {
  final String email;
  final String password;

  SignUpParams({required this.email, required this.password});
}
