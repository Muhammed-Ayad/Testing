import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:unit_test/auth.dart';
import 'package:unit_test/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

/*
EXCEPTION :
The following _TypeError was thrown running a test:
type 'Null' is not a subtype of type 'Future<String>'
 */

/*

1- Future<String?>?
2-flutter pub add build_runner --dev 

 */

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

  testWidgets('email or password is empty', (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();

    bool didSignIn = false;
    LoginScreen page = LoginScreen(onSignedIn: () => didSignIn = true);

    await tester.pumpWidget(makeWidget(child: page));

    await tester.tap(find.byKey(Key('signIn')));

    verifyNever(mockAuth.signInWithEmailAndPassword('', ''));
    expect(didSignIn, false);
  });

  testWidgets('non-empty email and password , Answer ',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    when(mockAuth.signInWithEmailAndPassword('email', 'password'))
        .thenAnswer((invocation) => Future.value('id'));

    bool didSignIn = false;
    LoginScreen page = LoginScreen(onSignedIn: () => didSignIn = true);

    await tester.pumpWidget(makeWidget(child: page));

    Finder emailField = find.byKey(Key('email'));
    await tester.enterText(emailField, 'email');

    Finder passwordField = find.byKey(Key('password'));
    await tester.enterText(passwordField, 'password');

    await tester.tap(find.byKey(Key('signIn')));

    verifyNever(mockAuth.signInWithEmailAndPassword('email', 'password'))
        .called(1);
    expect(didSignIn, true);
  });

  testWidgets('non-empty email and password , Error ',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    when(mockAuth.signInWithEmailAndPassword('email', 'password'))
        .thenThrow(StateError('Error '));

    bool didSignIn = false;
    LoginScreen page = LoginScreen(onSignedIn: () => didSignIn = true);

    await tester.pumpWidget(makeWidget(child: page));

    Finder emailField = find.byKey(Key('email'));
    await tester.enterText(emailField, 'email');

    Finder passwordField = find.byKey(Key('password'));
    await tester.enterText(passwordField, 'password');

    await tester.tap(find.byKey(Key('signIn')));

    verifyNever(mockAuth.signInWithEmailAndPassword('email', 'password'))
        .called(1);
    expect(didSignIn, false);
  });
}
