import 'package:flutter/material.dart';
import 'package:learningdart/constants/routes.dart';
import 'package:learningdart/services/auth/auth_service.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
          children:[
            const Text("A verification email has been sent to your email address."),
            const Text("Press the button below to resend the verification email."),
            TextButton(onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            }, child: const Text('Send verification email')),
            TextButton(onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            }, child: const Text('Restart')),
          ]
        ),
    );
  }
}