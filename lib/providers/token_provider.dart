//thiss provider is for  storing the JWT(Including shared preferences handling)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getTokenFromStorage() async {
  final prefs = await SharedPreferences.getInstance();
  final userToken = prefs.getString("userToken");
  if (userToken != null) {
    return userToken;
  } else {
    return null;
  }
}

final tokenProvider = StateNotifierProvider<TokenNotifier, String?>((ref) {
  final tokenFuture = getTokenFromStorage();
  return TokenNotifier(tokenFuture);
});

class TokenNotifier extends StateNotifier<String?> {
  TokenNotifier(Future<String?> tokenFuture) : super(null) {
    _loadTokenFromSharedPreferences(tokenFuture);
  }

  Future<void> _loadTokenFromSharedPreferences(
      Future<String?> tokenFuture) async {
    final user = await tokenFuture;
    state = user;
  }

  void setToken(String token) {
    state = token;
    _saveTokenToSharedPreferences(token);
  }

  void deleteToken() {
    state = null;
    _removeTokenFromSharedPreferences();
  }

  void _saveTokenToSharedPreferences(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("userToken", token.replaceAll('"', ""));
  }

  void _removeTokenFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("userToken");
  }
}
