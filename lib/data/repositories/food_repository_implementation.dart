import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:brief_test/common/base_url.dart';
import 'package:brief_test/common/failure.dart';
import 'package:brief_test/data/source/food/category_respone.dart';
import 'package:brief_test/domain/repositories/food_repository.dart';

class FoodRepositoryImpl extends FoodRepository {
  final http.Client client;

  FoodRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, CategoryReaponse>> getCategory() async {
    try {
      var uri = Uri.parse("$urlStaging/categories.php");
      final response = await client.get(uri);

      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);

      return Right(CategoryReaponse.fromJson(jsonData));
    } catch (e) {
      return const Left(ServerFailure(""));
    }
  }
}
