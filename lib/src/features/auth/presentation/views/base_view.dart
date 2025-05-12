import 'package:event_app/src/features/events/presentation/event_view.dart';
import 'package:event_app/src/features/auth/presentation/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BaseView extends StatefulWidget {
  const BaseView({super.key});

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    final user = FirebaseAuth.instance.currentUser;

    // Optional: Add delay to show splash
    await Future.delayed(const Duration(seconds: 2));

    if (user != null) {
      // User is logged in
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const EventView()),
        );
      }
    } else {
      // User is not logged in
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginView()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
