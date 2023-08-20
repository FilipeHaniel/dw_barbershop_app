import 'package:dw_barbershop_app/src/core/exceptions/auth_exception.dart';
import 'package:dw_barbershop_app/src/core/funcional_programming/either.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
}
