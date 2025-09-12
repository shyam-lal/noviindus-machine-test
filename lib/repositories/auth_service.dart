import 'package:novindus_machine_test/config/constants/shared_pref_constants.dart';
import 'package:novindus_machine_test/config/constants/url_constants.dart';
import 'package:novindus_machine_test/utils/shared_preferences_utils.dart';
import 'package:novindus_machine_test/config/webservices/api_client.dart';
import 'package:novindus_machine_test/config/webservices/api_request.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // static const String _loginUrl = 'https://flutter-amr.noviindus.in/api/Login';

  String? _token;

  String? get token => _token;

  Future<void> init() async {
    _token = await SharedPreferencesUtils.getString(
      SharedPrefConstants.authToken,
    );
  }

  /// Login and store token
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final request = ApiRequest(
        url: Uri.parse(BaseUrl.v1 + EndPoint.login),
        body: {'username': email, 'password': password},
      );

      final response = await ApiClient.postData<Map<String, dynamic>>(
        request: request,
        fromJson: (json) => json as Map<String, dynamic>,
        needsHeader: false,
        formUrlEncoded: true,
      );

      if (response?.data != null && response!.data!['status'] == true) {
        _token = response.data!['token'];
        await SharedPreferencesUtils.saveString(
          SharedPrefConstants.authToken,
          _token!,
        );
        return {'success': true, 'token': _token};
      } else {
        return {
          'success': false,
          'error': response?.data?['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }

  /// Logout
  Future<void> logout() async {
    _token = null;
    await SharedPreferencesUtils.remove(SharedPrefConstants.authToken);
  }

  /// Check if user is logged in
  bool isLoggedIn() {
    return _token != null;
  }
}
