import 'package:localstorage/localstorage.dart';

class AuthService {
  final LocalStorage storage = LocalStorage('my_app');

  Future<void> saveUserLoggedInStatus(bool isLoggedIn) async {
    await storage.ready;
    await storage.setItem('isLoggedIn', isLoggedIn);
  }

  Future<bool> isUserLoggedIn() async {
    await storage.ready;
    return storage.getItem('isLoggedIn') ?? false;
  }

  Future<void> clearUserLoggedInStatus() async {
    await storage.ready;
    await storage.deleteItem('isLoggedIn');
  }
}
