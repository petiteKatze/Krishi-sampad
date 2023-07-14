import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_test/providers/token_provider.dart';
import 'package:map_test/providers/user_provider.dart';
import 'package:map_test/status/status_enums.dart';

import '../models/user.model.dart';

const baseUrl = "http://192.168.29.205:5000/api/v1";
final dio = Dio();

formatPhoneNumber(String phoneNumber) {
  if (!phoneNumber.startsWith("91")) {
    phoneNumber = "91$phoneNumber";
  }
  return phoneNumber;
}

Future<Status> loginUser(String phoneNumber, WidgetRef ref) async {
  try {
    final res = await dio.post<String>("$baseUrl/login", data: {
      "phoneNumber": formatPhoneNumber(phoneNumber),
    });

    if (res.data != null) {
      ref.read(tokenProvider.notifier).setToken(res.data!);
      return Status.success;
    }
  } catch (error) {
    if (error is DioException) {
      if (error.response != null) {
        if (kDebugMode) {
          print(
              'Request failed with status code ${error.response!.statusCode}');
          print('Response data: ${error.response!.data}');
        }
        //409 error
        if (error.response?.statusCode == 409) {
          return Status.userNotregistered;
        }
      } else {
        if (kDebugMode) {
          print('Request failed: ${error.message}');
        }
        return Status.error;
      }
    } else {
      if (kDebugMode) {
        print('Unexpected error: $error');
      }
    }
    return Status.error404;
  }
  return Status.error;
}

Future<Status> otpVerify(
  String otp,
  WidgetRef ref,
) async {
  final token = ref.read(tokenProvider);
  try {
    final res = await dio.get<User>(
      "$baseUrl/verifyOTP",
      queryParameters: {"code": otp},
      options: Options(
          headers: {'Authorization': "Bearer ${token!.replaceAll('"', "")}"}),
    );
    if (res.data != null) {
      ref.read(userProvider.notifier).updateUser(res.data!);
    }
    return Status.success;
  } catch (error) {
    if (error is DioException) {
      if (error.response != null) {
        if (kDebugMode) {
          print(
              'Request failed with status code ${error.response!.statusCode}');
          print('Response data: ${error.response!.data}');
        }
        //400 error
        if (error.response?.statusCode == 400) {
          return Status.invalidOTP;
        }
      } else {
        if (kDebugMode) {
          print('Request failed: ${error.message}');
        }
        return Status.error404;
      }
    } else {
      if (kDebugMode) {
        print('Unexpected error: $error');
      }
    }
    return Status.error;
  }
}

Future<Status> signUp(
    WidgetRef ref,
    String phoneNumber,
    String fullName,
    String address,
    String email,
    String district,
    String? landSize,
    int zipCode,
    List<Commodities>? commoditySelling,
    Role role,
    Lang lang) async {
  try {
    final res = await dio.post<String>("$baseUrl/signup", data: {
      "phoneNumber": formatPhoneNumber(phoneNumber),
      "fullName": fullName,
      "address": address,
      "email": email,
      "district": district,
      "landSize": landSize,
      "zipCode": zipCode,
      "commoditySelling": commoditySelling,
      "role": role,
      "lang": lang,
    });

    if (res.data != null) {
      ref.read(tokenProvider.notifier).setToken(res.data!);
      return Status.success;
    }
  } catch (error) {
    if (error is DioException) {
      if (error.response != null) {
        if (kDebugMode) {
          print(
              'Request failed with status code ${error.response!.statusCode}');
          print('Response data: ${error.response!.data}');
        }
        //409 error
        if (error.response?.statusCode == 422) {
          return Status.alreadyRegistered;
        }
      } else {
        if (kDebugMode) {
          print('Request failed: ${error.message}');
        }
        return Status.error;
      }
    } else {
      if (kDebugMode) {
        print('Unexpected error: $error');
      }
    }
    return Status.error404;
  }
  return Status.error;
}
