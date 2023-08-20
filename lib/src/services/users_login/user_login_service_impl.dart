import 'package:dw_barbershop_app/src/core/constants/local_storages_keys.dart';
import 'package:dw_barbershop_app/src/core/exceptions/auth_exception.dart';
import 'package:dw_barbershop_app/src/core/exceptions/service_exception.dart';
import 'package:dw_barbershop_app/src/core/funcional_programming/either.dart';
import 'package:dw_barbershop_app/src/core/funcional_programming/nil.dart';
import 'package:dw_barbershop_app/src/repositories/user/user_repository.dart';
import 'package:dw_barbershop_app/src/services/users_login/user_login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository _userRepository;

  UserLoginServiceImpl({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Either<ServiceException, Nil>> execute(
      String email, String password) async {
    final loginResult = await _userRepository.login(email, password);

    switch (loginResult) {
      case Success(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStoragesKeys.accessToken, accessToken);

        return Success(nil);

      case Failure(:final exeption):
        return switch (exeption) {
          AuthError() =>
            Failure(ServiceException(message: 'Erro ao realizar login')),
          AuthunauthorizedException() =>
            Failure(ServiceException(message: 'login ou senha  inválidos')),
        };
    }
  }
}
