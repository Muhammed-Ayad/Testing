import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unit_test/auth.dart';

import 'widgets/custtom_material_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({this.onSignedIn});
  final VoidCallback? onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

enum FormType {
  login,
  register,
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  String? _email;
  String? _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        var auth = Provider.of<Auth>(context, listen: false);
        if (_formType == FormType.login) {
          await auth.signInWithEmailAndPassword(_email!, _password!);
        } else {
          await auth.createUserWithEmailAndPassword(_email!, _password!);
        }
        widget.onSignedIn!();
      } catch (e) {
        print('error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState!.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState!.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter login demo'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildInputs() + buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        key: Key('email'),
        decoration: InputDecoration(labelText: 'Email'),
        validator: (value) => value!.isEmpty ? 'email is empty' : null,
        onSaved: (value) => _email = value,
      ),
      TextFormField(
        key: Key('password'),
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) => value!.isEmpty ? 'Password is empty' : null,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        CustomMaterialButton(
          keyName: 'signIn',
          onPressed: validateAndSubmit,
          title: 'Login',
        ),
        CustomMaterialButton(
          keyName: 'null',
          onPressed: moveToRegister,
          title: 'Create an account',
        ),
      ];
    } else {
      return [
        CustomMaterialButton(
          keyName: 'CreateUser',
          onPressed: validateAndSubmit,
          title: 'Create an account',
        ),
        CustomMaterialButton(
          keyName: 'null',
          onPressed: moveToLogin,
          title: 'Have an account? Login',
        ),
      ];
    }
  }
}
