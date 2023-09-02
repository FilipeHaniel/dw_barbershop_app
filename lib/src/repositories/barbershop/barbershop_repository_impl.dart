import 'package:dio/dio.dart';
import 'package:dw_barbershop_app/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop_app/src/core/funcional_programming/either.dart';
import 'package:dw_barbershop_app/src/core/rest_client/rest_client.dart';
import 'package:dw_barbershop_app/src/models/barbershop_model.dart';
import 'package:dw_barbershop_app/src/models/user_model.dart';
import 'package:dw_barbershop_app/src/repositories/barbershop/barbershop_repository.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  final RestClient _restClient;

  BarbershopRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
      UserModel userModel) async {
    switch (userModel) {
      case UserModelADM():
        final Response(data: List(first: data)) = await _restClient.auth.get(
          '/barbershop',
          queryParameters: {'user_id': '#userAuthRef'},
        );

        return Success(BarbershopModel.fromMap(data));

      case UserModelEmployee():
        final Response(:data) =
            await _restClient.auth.get('/barbershop/${userModel.barberShopId}');

        return Success(BarbershopModel.fromMap(data));
    }
  }
}
