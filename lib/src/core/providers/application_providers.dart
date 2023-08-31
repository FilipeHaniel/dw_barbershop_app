import 'package:dw_barbershop_app/src/core/funcional_programming/either.dart';
import 'package:dw_barbershop_app/src/core/rest_client/rest_client.dart';
import 'package:dw_barbershop_app/src/models/user_model.dart';
import 'package:dw_barbershop_app/src/repositories/user/user_repository.dart';
import 'package:dw_barbershop_app/src/repositories/user/user_repository_impl.dart';
import 'package:dw_barbershop_app/src/services/users_login/user_login_service.dart';
import 'package:dw_barbershop_app/src/services/users_login/user_login_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) =>
    UserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginServiceImpl(userRepository: ref.read(userRepositoryProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepositoryProvider).me();

  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}
