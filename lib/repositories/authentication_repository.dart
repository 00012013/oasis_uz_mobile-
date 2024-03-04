// authentication_repository.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oasis_uz_mobile/constants/api_constants.dart';
import 'package:oasis_uz_mobile/repositories/modules/token.dart';
import 'package:oasis_uz_mobile/repositories/modules/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository {
  static const String _tokenKey = 'jwt_token';
  static const String _userKey = 'user';

  Future<User?> authenticateUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$api/api/auth/login'),
        body: jsonEncode({'email': username, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String accessToken = data['accessToken'];
        final String userName = data['fullName'];
        await _storeToken(accessToken);
        return User(null, userName, null, null);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> retrieveToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> saveUser(User? user) async {
    final prefs = await SharedPreferences.getInstance();
    if (user == null) {
      return;
    }
    await prefs.setString(_userKey, json.encode(user.toJson()));
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  Future<User?> checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userString = prefs.getString(_userKey);
    if (userString != null) {
      var user = parseUserFromString(userString);
      var token = await retrieveToken();

      const String url = '$api/api/auth/token';

      final TokenDto tokenDto = TokenDto(token, token);
      final headers = <String, String>{
        'Content-Type': 'application/json',
      };
      final body = jsonEncode(tokenDto.toJson());
      try {
        final response =
            await http.post(Uri.parse(url), headers: headers, body: body);
        if (response.statusCode == 200) {
          return user;
        } else {
          return null;
        }
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  User? parseUserFromString(String jsonString) {
    try {
      final Map<String, dynamic> userData = json.decode(jsonString);
      return User.fromJson(userData);
    } catch (e) {
      print('Error parsing user from string: $e');
      return null;
    }
  }
}
