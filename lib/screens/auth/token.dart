import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthToken {
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

 //   print(prefs.getString('auth_token'));
    return prefs.getString('auth_token') ?? '';
  }

  saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("save token methode");
    await prefs.setString('auth_token', token);
  }

  loadUserInfo(var userInfo) async {
    LoginModel user = await AuthUtility.getUserInfo();

    userInfo = user.toJson();
    print(userInfo.toString());
  }
}
