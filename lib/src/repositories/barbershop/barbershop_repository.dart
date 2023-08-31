import 'package:dw_barbershop_app/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop_app/src/core/funcional_programming/either.dart';
import 'package:dw_barbershop_app/src/models/barbershop_model.dart';
import 'package:dw_barbershop_app/src/models/user_model.dart';

abstract interface class BarbershopRepository {
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
      UserModel userModel);
}
