import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dw_barbershop_app/src/core/exceptions/auth_exception.dart';
import 'package:dw_barbershop_app/src/core/funcional_programming/either.dart';
import 'package:dw_barbershop_app/src/core/rest_client/rest_client.dart';
import 'package:dw_barbershop_app/src/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient _restClient;

  UserRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      /// [inAuth] por ser uma requisição não autenticada
      final Response(:data) = await _restClient.unAuth.post('/auth', data: {
        'email': email,
        'password': password,
      });

      return Success(data['access-token']);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;

        if (statusCode == HttpStatus.forbidden) {
          log('login ou senha inválidos', error: e, stackTrace: s);

          return Failure(AuthunauthorizedException());
        }
      }

      log('Erro ao realizar login', error: e, stackTrace: s);

      return Failure(AuthError(message: 'Erro ao realizar login'));
    }
  }
}
