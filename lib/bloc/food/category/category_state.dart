part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryInitialState extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoadingState extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryErrorState extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoadedState extends CategoryState {
  final CategoryReaponse categoryReaponse;

  const CategoryLoadedState({required this.categoryReaponse});

  @override
  List<Object> get props => [categoryReaponse];
}
