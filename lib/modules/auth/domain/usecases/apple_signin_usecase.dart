import 'package:dartz/dartz.dart';

// Core
import '../../../../core/interfaces/interfaces.dart';
// Feature
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInWithApple extends UseCase<User, Unit> {
  final AuthRepository repository;

  SignInWithApple({required this.repository});

  @override
  Future<Either<Failure, User>> call([Unit params = unit]) async {
    return repository.signInWithApple();
  }
}
