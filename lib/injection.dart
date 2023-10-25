import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:brief_test/bloc/food/category/category_bloc.dart';
import 'package:brief_test/data/repositories/food_repository_implementation.dart';
import 'package:brief_test/domain/repositories/food_repository.dart';
import 'package:brief_test/domain/use_case/get_category.dart';

final getIt = GetIt.instance;

void init() {
  initRepository();
  initUseCase();
  initBloc();

  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton(() => Logger());
}

void initRepository() {
  getIt.registerLazySingleton<FoodRepository>(
    () => FoodRepositoryImpl(client: getIt.get<http.Client>()),
  );
}

void initUseCase() {
  getIt.registerLazySingleton(
    () => GetCategory(
      getIt.get<FoodRepository>(),
    ),
  );
}

void initBloc() {
  getIt.registerFactory(
    () => CategoryBloc(
      getCategory: getIt.get<GetCategory>(),
    ),
  );
}
