import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unit_test/login_screen.dart';
import 'screens/personal_data_screen.dart';

class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.data == null) {
            return LoginScreen();
          } else if (userSnapshot.hasData) {
            return PersonalDataScreen();
          } else if (userSnapshot.hasError) {
            return Center(
              child: Text(
                'An error has been occured',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
          );
        });
  }
}
