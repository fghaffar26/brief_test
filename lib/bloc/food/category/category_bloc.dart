import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:brief_test/data/source/food/category_respone.dart';
import 'package:brief_test/domain/use_case/get_category.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategory getCategory;

  CategoryBloc({required this.getCategory}) : super(CategoryInitialState()) {
    on<GetCategoryListEvent>(_getCategory);
  }

  void _getCategory(
      GetCategoryListEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    final result = await getCategory.execute();

    await result.fold(
      (failure) async {
        emit(CategoryErrorState());
      },
      (response) async {
        emit(
          CategoryLoadedState(categoryReaponse: response),
        );
      },
    );
  }
}
