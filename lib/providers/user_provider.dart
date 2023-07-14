//this provider stores the user Object. (Also done with the shared preferences handling)
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_test/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<User?> getUserFromStorage() async {
  final prefs = await SharedPreferences.getInstance();
  final userData = prefs.getString("userData");
  if (userData != null) {
    final decodedData = json.decode(userData);
    final jsonString = json.encode(decodedData);
    return User.fromJson(jsonString);
  } else {
    return null;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  final userFuture = getUserFromStorage();
  return UserNotifier(userFuture);
});

class UserNotifier extends StateNotifier<User?> {
  UserNotifier(Future<User?> userFuture) : super(null) {
    _loadUserFromSharedPreferences(userFuture);
  }

  Future<void> _loadUserFromSharedPreferences(Future<User?> userFuture) async {
    final user = await userFuture;
    state = user;
  }

  void updateUser(User u) {
    state = u;
    _saveUserToSharedPreferences(u);
  }

  void deleteUser() {
    state = null;
    _removeUserFromSharedPreferences();
  }

  void _saveUserToSharedPreferences(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("userData", json.encode(user));
  }

  void _removeUserFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("userData");
  }

  void updatePhoneNumber(String newPhoneNumber) {
    if (state != null) {
      final updatedUser = state!.copyWith(phoneNumber: newPhoneNumber);
      state = updatedUser;
      _saveUserToSharedPreferences(updatedUser);
    }
  }

  void updateFullName(String newFullName) {
    if (state != null) {
      final updatedUser = state!.copyWith(fullName: newFullName);
      state = updatedUser;
      _saveUserToSharedPreferences(updatedUser);
    }
  }

  void updateAddress(String newAddress) {
    if (state != null) {
      final updatedUser = state!.copyWith(address: newAddress);
      state = updatedUser;
      _saveUserToSharedPreferences(updatedUser);
    }
  }

  void updateZipCode(int newZipCode) {
    if (state != null) {
      final updatedUser = state!.copyWith(zipCode: newZipCode);
      state = updatedUser;
      _saveUserToSharedPreferences(updatedUser);
    }
  }

  void updateEmail(String newEmail) {
    if (state != null) {
      final updatedUser = state!.copyWith(email: newEmail);
      state = updatedUser;
      _saveUserToSharedPreferences(updatedUser);
    }
  }

  void updateDistrict(String newDistrict) {
    if (state != null) {
      final updatedUser = state!.copyWith(district: newDistrict);
      state = updatedUser;
      _saveUserToSharedPreferences(updatedUser);
    }
  }

  void updateLandSize(String? newLandSize) {
    if (state != null) {
      final updatedUser = state!.copyWith(landSize: newLandSize);
      state = updatedUser;
      _saveUserToSharedPreferences(updatedUser);
    }
  }

  void updateLang(Lang newLang) {
    if (state != null) {
      final updatedUser = state!.copyWith(lang: newLang);
      state = updatedUser;
      _saveUserToSharedPreferences(updatedUser);
    }
  }

  void updateCommoditySelling(List<Commodities>? newCommoditySelling) {
    if (state != null) {
      final updatedUser =
          state!.copyWith(commoditySelling: newCommoditySelling);
      state = updatedUser;
      _saveUserToSharedPreferences(updatedUser);
    }
  }

  void updateVaultContent(Map<Commodities, int>? newVaultContent) {
    if (state != null) {
      final updatedUser = state!.copyWith(vaultContent: newVaultContent);
      state = updatedUser;
      _saveUserToSharedPreferences(updatedUser);
    }
  }
}
