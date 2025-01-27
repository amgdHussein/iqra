import 'package:dartz/dartz.dart';

// Core
import '../../../../core/interfaces/interfaces.dart';
// Feature
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInWithGoogle extends UseCase<User, Unit> {
  final AuthRepository repository;

  SignInWithGoogle({required this.repository});

  @override
  Future<Either<Failure, User>> call([Unit params = unit]) async {
    return repository.signInWithGoogle();
  }
}
