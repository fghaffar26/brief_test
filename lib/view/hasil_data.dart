import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brief_test/bloc/food/category/category_bloc.dart';
import 'package:brief_test/data/source/food/category_respone.dart';

import 'widget/ink_effect.dart';

class HasilDataPage extends StatefulWidget {
  const HasilDataPage({Key? key}) : super(key: key);

  @override
  State<HasilDataPage> createState() => _HasilDataPageState();
}

class _HasilDataPageState extends State<HasilDataPage> {
  TextEditingController categoryTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Ini Kategori Makanan",
          style: TextStyle(
            color: Colors.black, // 2
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(
                height: 16.h,
              ),
              BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                if (state is CategoryLoadedState) {
                  CategoryReaponse? categoryReaponse = state.categoryReaponse;

                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: categoryReaponse.categories?.length ?? 0,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 20.h,
                      );
                    },
                    itemBuilder: (context, index) {
                      Categories? cat =
                          categoryReaponse.categories?.elementAt(index);

                      return InkEffect(
                        onTap: () {},
                        boxDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                cat?.strCategoryThumb ?? '',
                                width: 60.w,
                                height: 60.w,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Flexible(
                                child: Text(
                                  cat?.strCategory ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is CategoryErrorState) {
                  return const Text("Failed load data");
                } else if (state is CategoryLoadingState) {
                  return const CircularProgressIndicator();
                } else {
                  //initial state
                  return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
