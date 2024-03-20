abstract class LoginRepository {
  Future<bool> fetchLogin(String email, String password);
  Future<void> saveName(Map<String, dynamic> nameUser);
  Future<void> saveEmail(Map<String, dynamic> emailUser);
  Future<void> savePhoneNumber(Map<String, dynamic> phoneUser);
}
