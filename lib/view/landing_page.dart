import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:brief_test/bloc/food/category/category_bloc.dart';
import 'package:brief_test/view/hasil_data.dart';
import 'package:brief_test/view/sign_in.dart';

import '../bloc/auth/bloc/auth_bloc.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);
  // final CameraDescription camera;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Udah Log In',
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
          if (state is UnAuthenticated) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignIn()),
              (route) => false,
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Selamat anda berhasil Log In ${user.displayName}',
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // ElevatedButton(
              //     onPressed: () async {
              //       await availableCameras().then((value) => Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (_) => CameraPage(
              //                     camera: widget.camera,
              //                   ))));
              //     },
              //     child: const Text("Take a Picture")),
              const SizedBox(height: 16),
              ElevatedButton(
                child:
                    const Text('Lihat hasil data yang diambil dari API publik'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<CategoryBloc>(context),
                        child: const HasilDataPage(),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Log Out'),
                onPressed: () {
                  context.read<AuthBloc>().add(SignOutRequested());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
