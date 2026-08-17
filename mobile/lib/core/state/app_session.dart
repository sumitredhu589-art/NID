import 'package:flutter/foundation.dart';

class AppSession extends ChangeNotifier {
  String? accessToken;
  String? refreshToken;
  String? phoneNumber;

  bool get isAuthenticated => accessToken != null;

  void setTokens({
    required String newAccessToken,
    required String newRefreshToken,
    required String newPhoneNumber,
  }) {
    accessToken = newAccessToken;
    refreshToken = newRefreshToken;
    phoneNumber = newPhoneNumber;
    notifyListeners();
  }

  void clear() {
    accessToken = null;
    refreshToken = null;
    phoneNumber = null;
    notifyListeners();
  }
}
