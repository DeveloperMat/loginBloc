class AuthRepository {
  Future<void> login() async {
    print('attempting login');
    await Future.delayed(Duration(seconds: 3));
    print('Logged in');
    throw Exception('Failed Login');
  }
}
