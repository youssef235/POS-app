import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pos_client_final/Client/Cubit/auth_state.dart';
import 'package:pos_client_final/Client/Services/auth_services.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();

  AuthCubit() : super(AuthInitial());

  void checkLoginStatus() async {
    final isLoggedIn = await _authService.isUserLoggedIn();
    if (isLoggedIn) {
      final user = _auth.currentUser;
      if (user != null) {
        emit(AuthAuthenticated(user.uid));
      } else {
        emit(AuthUnauthenticated());
      }
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      emit(AuthLoading());
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        await _authService.saveUserLoggedInStatus(true);
        emit(AuthAuthenticated(userCredential.user!.uid));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      emit(AuthLoading());
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        // Add additional user details to Firestore if needed
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': name,
          'email': email,
        });

        await _authService.saveUserLoggedInStatus(true);

        emit(AuthAuthenticated(userCredential.user!.uid));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _authService.clearUserLoggedInStatus();
    emit(AuthUnauthenticated());
  }
}
