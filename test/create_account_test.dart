import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:unit_test/auth.dart';
import 'package:unit_test/login_screen.dart';

class MockAuth extends Mock implements BaseAuth {}

void main() {
  Firebase.initializeApp();

  Widget makeWidget({required Widget child}) {
    return ChangeNotifierProvider(
      create: (_) => Auth(),
      child: MaterialApp(
        home: child,
      ),
    );
  }

 

  testWidgets('Create an account', (WidgetTester tester) async {
    //1
    final emailField = find.byKey(Key('email'));
    final passwordField = find.byKey(Key('password'));
    final addUserButton = find.byKey(Key('CreateUser'));
    const email = 'test@test.com';
    const password = 'password';
    MockAuth mockAuth = MockAuth();
    bool didSignIn = false;
    LoginScreen page = LoginScreen(onSignedIn: () => didSignIn = true);
    //2
    await tester.pumpWidget(makeWidget(child: page));
    await tester.enterText(emailField, email);
    await tester.enterText(passwordField, password);
    await tester.tap(addUserButton);
    await tester.pump();
    //3
    verifyNever(mockAuth.createUserWithEmailAndPassword(email, password))
        .called(1);
    expect(didSignIn, true);
  });
}
