import 'package:brief_test/bloc/food/category/category_bloc.dart';
import 'package:brief_test/view/landing_page.dart';
import 'package:brief_test/view/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'data/repositories/auth_repository.dart';
import 'package:brief_test/injection.dart' as di;

import 'bloc/auth/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider<CategoryBloc>(
            create: (BuildContext context) =>
                di.getIt<CategoryBloc>()..add(GetCategoryListEvent()),
          ),
        ],
        child: ScreenUtilInit(
            designSize: const Size(390, 844),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (BuildContext context, Widget? child) {
              return MaterialApp(
                title: 'TestApp',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  primarySwatch: Colors.blue,
                ),
                builder: (context, widget) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: widget!,
                  );
                },
                home: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return const LandingPage();
                      }
                      return const SignIn();
                    }),
              );
            }),
      ),
    );
  }
}
