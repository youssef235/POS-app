import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pos_client_final/Client/Services/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_client_final/Client/Cubit/auth_cubit.dart';
import 'package:pos_client_final/Client/Cubit/product_cubit.dart';
import 'package:pos_client_final/Client/View/signin_screen.dart';
import 'package:pos_client_final/Client/View/main_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: AuthService().isUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (snapshot.hasData && snapshot.data == true) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthCubit()..checkLoginStatus(),
              ),
              BlocProvider(
                create: (context) => ProductClientCubit(
                  FirebaseFirestore.instance,
                  context.read<AuthCubit>(),
                ),
              ),
            ],
            child: MaterialApp(
              title: 'Product App',
              debugShowCheckedModeBanner: false,
              home: MainScreen(),
            ),
          );
        } else {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthCubit(),
              ),
              BlocProvider(
                create: (context) => ProductClientCubit(
                  FirebaseFirestore.instance,
                  context.read<AuthCubit>(),
                ),
              ),
            ],
            child: MaterialApp(
              title: 'Product App',
              debugShowCheckedModeBanner: false,
              home: SignInScreen(),
            ),
          );
        }
      },
    );
  }
}
