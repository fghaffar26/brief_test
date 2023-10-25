import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/auth/bloc/auth_bloc.dart';
import 'landing_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  // final CameraDescription camera;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Log In",
          style: TextStyle(
            color: Colors.black, // 2
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LandingPage()));
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton.extended(
                          label: const Text('Log In'),
                          backgroundColor: Colors.black,
                          icon: Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png",
                            height: 30.h,
                            width: 30.w,
                          ),
                          onPressed: () {
                            _authenticateWithGoogle(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }
}
