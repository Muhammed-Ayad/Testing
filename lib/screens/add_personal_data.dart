import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unit_test/model/personal_data.dart';

class FirstNameValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return 'first Name is empty';
    }
    if (value.length < 5) {
      return 'first Name is less 5';
    }
  }
}

class LastNameValidator {
  static String? validate(String value) {
    return value.isEmpty ? 'last Name is empty' : null;
  }
}

class CityNameValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return 'city Name is empty';
    }
    if (value.contains(value.toLowerCase())) {
      return 'city Name is not toLowerCase';
    }
  }
}

class AddPersonalData extends StatefulWidget {
  static const id = 'add-data';

  @override
  _AddPersonalDataState createState() => _AddPersonalDataState();
}

class _AddPersonalDataState extends State<AddPersonalData> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _governorateController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _governorateController.dispose();
    _cityController.dispose();
  }

  // void setData(BuildContext context) {
  //   final personalData = Provider.of<PersonalDataProvider>(context);
  //   if (_formKey.currentState!.validate()) {
  //     personalData.addPersonalData(
  //       firstName: _firstNameController.text,
  //       lastName: _lastNameController.text,
  //       governorate: _governorateController.text,
  //       city: _cityController.text,
  //     );
  //     Navigator.pop(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final personalData = Provider.of<PersonalDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
          child: Column(
            children: [
              TextFormField(
                key: Key('firstName'),
                decoration: InputDecoration(labelText: 'FirstName'),
                controller: _firstNameController,
                validator: (value) => FirstNameValidator.validate(value!),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                key: Key('lastName'),
                decoration: InputDecoration(labelText: 'LastName'),
                controller: _lastNameController,
                validator: (value) => LastNameValidator.validate(value!),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                key: Key('governorate'),
                decoration: InputDecoration(labelText: 'Governorate'),
                controller: _governorateController,
                validator: (value) =>
                    value!.isEmpty ? 'Governorate is empty' : null,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                key: Key('city'),
                decoration: InputDecoration(labelText: 'City'),
                controller: _cityController,
                validator: (value) => CityNameValidator.validate(value!),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('SendData'),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            personalData.addPersonalData(
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              governorate: _governorateController.text,
              city: _cityController.text,
            );
            Navigator.pop(context);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
