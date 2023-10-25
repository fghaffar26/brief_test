import 'package:dartz/dartz.dart';
import 'package:brief_test/common/failure.dart';
import 'package:brief_test/data/source/food/category_respone.dart';

abstract class FoodRepository {
  Future<Either<Failure, CategoryReaponse>> getCategory();
}
