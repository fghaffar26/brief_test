import 'package:equatable/equatable.dart';

class CategoryReaponse extends Equatable {
  List<Categories>? categories;

  CategoryReaponse({this.categories});

  CategoryReaponse.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [categories];
}

class Categories {
  Categories({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });
  late final String idCategory;
  late final String strCategory;
  late final String strCategoryThumb;
  late final String strCategoryDescription;

  Categories.fromJson(Map<String, dynamic> json) {
    idCategory = json['idCategory'];
    strCategory = json['strCategory'];
    strCategoryThumb = json['strCategoryThumb'];
    strCategoryDescription = json['strCategoryDescription'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idCategory'] = idCategory;
    data['strCategory'] = strCategory;
    data['strCategoryThumb'] = strCategoryThumb;
    data['strCategoryDescription'] = strCategoryDescription;
    return data;
  }
}
