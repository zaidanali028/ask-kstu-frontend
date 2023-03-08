import 'dart:convert';
import 'package:first_app/models/api_response.dart';
import 'package:first_app/models/constant.dart';
import 'package:first_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

  Future<ApiResponse> login(String email, String password) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response = await http.post(Uri.parse(loginUrl), headers: {
        'Accept': 'application/json',
      }, body: {
        "email": email,
        "password": password
      });

      switch (response.statusCode) {
        case 200:
          apiResponse.data = User.fromJson(jsonDecode(response.body));
          break;
        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)["message"];
          break;
        default:
          apiResponse.error = somethingWentwrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }

  Future<dynamic> getUserDetail() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(Uri.parse(userUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

      switch (response.statusCode) {
        case 200:
          apiResponse.data = User.fromJson(jsonDecode(response.body));

          break;
        case 401:
          apiResponse.error = unauthorized;
          break;
        default:
          apiResponse.error = somethingWentwrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }

  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token") ?? '';
  }

  Future<int> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('id') ?? 0;
  }

  Future<bool> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.remove('token');
  }

  // Future<void> savedUserDetails(User user) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   await pref.setString("username", user.name ?? '');
  //   await pref.setString("email", user.email ?? '');
  //   await pref.setString("studentNumber", user.studentNumber ?? '');
  //   await pref.setString("profileImage", user.profileImage ?? '');
  // }
