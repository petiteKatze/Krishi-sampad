import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_test/api/auth.dart';
import 'package:map_test/models/user.model.dart';
import 'package:map_test/providers/token_provider.dart';

import '../providers/user_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  void refChange(WidgetRef ref) {
    ref.read(userProvider.notifier).updateUser(const User(
        userName: "diptanshuMahish",
        phoneNumber: "9029302",
        address: "some",
        district: "hello",
        email: "dip",
        fullName: "Diptanshu Mahish",
        lang: Lang.bn,
        role: Role.farmer,
        accCreationDate: "23232",
        isAccountDisabled: false,
        zipCode: 23232));
  }

  void refUpdate(WidgetRef ref) {
    ref.read(userProvider.notifier).updateFullName("Hola");
  }

  void refDelete(WidgetRef ref) {
    ref.read(userProvider.notifier).deleteUser();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tRef = ref.watch(userProvider);
    final tok = ref.watch(tokenProvider);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          tok ?? "hi",
          style: TextStyle(fontSize: 25),
        ),
        Text(
          tRef?.fullName ?? "hi",
          style: TextStyle(fontSize: 25),
        ),
        // ElevatedButton(
        //     onPressed: () {
        //       refChange(ref);
        //     },
        //     child: Text("update")),
        // ElevatedButton(
        //     onPressed: () {
        //       refUpdate(ref);
        //     },
        //     child: Text("update full name")),
        // ElevatedButton(
        //     onPressed: () {
        //       refDelete(ref);
        //     },
        //     child: Text("Delete")),
        ElevatedButton(
            onPressed: () async {
              final res = await loginUser("8961603453", ref);
              print(res);
            },
            child: Text("Login")),
        ElevatedButton(
            onPressed: () async {
              final token = ref.read(tokenProvider);
              final res = await otpVerify(
                "4488",
                ref,
              );
              print(res);
            },
            child: Text("otp"))
      ],
    ));
  }
}
