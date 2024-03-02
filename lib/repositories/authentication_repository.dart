// authentication_repository.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oasis_uz_mobile/constants/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository {
  static const String _tokenKey = 'jwt_token';

  Future<String?> authenticateUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$api/api/auth/login'),
        body: jsonEncode({'email': username, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String accessToken = data['accessToken'];

        await _storeToken(accessToken);
        return accessToken;
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

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
