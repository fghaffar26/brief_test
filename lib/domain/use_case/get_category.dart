import 'package:dartz/dartz.dart';
import 'package:brief_test/common/failure.dart';
import 'package:brief_test/data/source/food/category_respone.dart';
import 'package:brief_test/domain/repositories/food_repository.dart';

class GetCategory {
  final FoodRepository foodRepository;

  GetCategory(this.foodRepository);

  Future<Either<Failure, CategoryReaponse>> execute() {
    return foodRepository.getCategory();
  }
}
