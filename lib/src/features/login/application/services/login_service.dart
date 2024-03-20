// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'package:dio/dio.dart';
import 'package:task5_application/src/features/login/data/repositories/login_repository.dart';
import 'package:task5_application/src/utils/shared_preferences/login_local_storage.dart';

class LoginService implements LoginRepository {
  static const String loginUrl = 'https://demo.treblle.com/api/v1/auth/login';
  @override
  Future<bool> fetchLogin(String emailValue, String passwordValue) async {
    try {
      Dio _dio = Dio();
      Response loginResponse = await _dio.post(loginUrl,
          queryParameters: {'email': emailValue, 'password': passwordValue});
      print('Login Response Data: ${loginResponse.data}');
      print('Status message: ${loginResponse.data['status']}');
      if (loginResponse.statusCode == 200 &&
          loginResponse.data['status'] == true) {
        await saveName(loginResponse.data);
        await saveEmail(loginResponse.data);
        await savePhoneNumber(loginResponse.data);
        return true;
      }
      return false;
    } on DioException catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Future<void> saveEmail(Map<String, dynamic> emailUser) async {
    final emailData = emailUser['user']['email'];
    await LoginLocalStorage.setUserEmail(emailData);
  }

  @override
  Future<void> saveName(Map<String, dynamic> nameUser) async {
    final nameData = nameUser['user']['name'];
    await LoginLocalStorage.setUserName(nameData);
  }

  @override
  Future<void> savePhoneNumber(Map<String, dynamic> phoneUser) async {
    final phoneNumberData = phoneUser['user']['phone_number'];
    await LoginLocalStorage.setUserPhoneNumber(phoneNumberData);
  }
}
