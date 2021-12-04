import 'package:flutter/material.dart';

class PersonalDataItem extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String governorate;
  final String city;

  PersonalDataItem({
    required this.firstName,
    required this.lastName,
    required this.governorate,
    required this.city,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ),
          title: Text('$firstName $lastName'),
          subtitle: Text('Governorate :$governorate ,city:$city '),
        ),
      ),
    );
  }
}
