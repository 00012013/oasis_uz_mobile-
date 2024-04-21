// authentication_repository.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oasis_uz_mobile/constants/api_constants.dart';
import 'package:oasis_uz_mobile/repositories/enums/auth_enum.dart';
import 'package:oasis_uz_mobile/repositories/models/idTokenDto.dart';
import 'package:oasis_uz_mobile/repositories/models/token.dart';
import 'package:oasis_uz_mobile/repositories/models/user.dart';
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
        final int userId = data['userId'];
        final String userRole = data['role'];
        UserRole role = UserRole.USER;
        if (userRole == 'ADMIN') {
          role = UserRole.ADMIN;
        }
        await _storeToken(accessToken);
        var user = User(userId, userName, null, null, role);
        await saveUser(user);
        return user;
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

  Future<String?> registerUser(User user) async {
    final url = Uri.parse('$api/api/auth/register');
    var jsonUser = json.encode(user.toJson());
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonUser);

    if (response.statusCode == 200) {
      return null;
    } else {
      return 'Failed to register user: ${response.statusCode}';
    }
  }

  Future<User?> authenticateWithGoogle(String? idToken) async {
    try {
      IdTokenDto dto = IdTokenDto(idToken!);
      var requestBody = json.encode(dto.toJson());
      final response = await http.post(
        Uri.parse('$api/api/auth/auth/google'),
        body: requestBody,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String accessToken = data['accessToken'];
        final String userName = data['fullName'];
        final int id = data['userId'];
        await _storeToken(accessToken);
        var user = User(id, userName, null, null, UserRole.USER);
        saveUser(user);
        return user;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
