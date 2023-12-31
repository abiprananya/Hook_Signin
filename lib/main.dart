
import 'package:flutter/material.dart';
import 'package:hook_login/screens/dashboard/dashboard_screen.dart';
import 'package:hook_login/screens/login/login_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'features/user/repositories/auth_repository.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ref
          .watch(
        getIsAuthenticatedProvider,
      )
          .when(
        data: (bool isAuthenticated) =>
        isAuthenticated ? const DashboardScreen() : const LoginScreen(),
        loading: () {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        error: (error, stacktrace) => const LoginScreen(),
      ),
      routes: {
        "Home": (context) => const DashboardScreen(),
        "Login": (context) => const LoginScreen(),
      },
    );
  }
}
