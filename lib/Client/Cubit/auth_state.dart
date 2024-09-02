import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

// حالة البداية
class AuthInitial extends AuthState {}

// حالة التحميل
class AuthLoading extends AuthState {}

// حالة عند تسجيل الدخول
class AuthAuthenticated extends AuthState {
  final String userId;

  AuthAuthenticated(this.userId);

  @override
  List<Object> get props => [userId];
}

// حالة عند تسجيل الخروج
class AuthUnauthenticated extends AuthState {}

// حالة عند حدوث خطأ
class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object> get props => [message];
}
