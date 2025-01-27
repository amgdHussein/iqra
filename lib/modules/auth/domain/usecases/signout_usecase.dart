import 'package:dartz/dartz.dart';

// Core
import '../../../../core/interfaces/interfaces.dart';
// Feature
import '../repositories/auth_repository.dart';

class SignOut extends UseCase<Unit, Unit> {
  final AuthRepository repository;

  SignOut({required this.repository});

  @override
  Future<Either<Failure, Unit>> call([Unit params = unit]) async {
    return repository.signOut();
  }
}
