import 'package:dw_barbershop_app/src/core/exceptions/auth_exception.dart';
import 'package:dw_barbershop_app/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop_app/src/core/funcional_programming/either.dart';
import 'package:dw_barbershop_app/src/models/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);

  Future<Either<RepositoryException, UserModel>> me();
}
