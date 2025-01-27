import 'package:dartz/dartz.dart';

// Core
import '../../../../core/interfaces/interfaces.dart';
// Feature
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SubscribeAuthChanges extends UseCase<Stream<User?>, Unit> {
  final AuthRepository repository;

  SubscribeAuthChanges({required this.repository});

  @override
  Either<Failure, Stream<User?>> call([Unit params = unit]) {
    return repository.authUserChanges();
  }
}
