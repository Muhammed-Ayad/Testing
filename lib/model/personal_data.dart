import 'dart:ui';

import 'package:flutter/foundation.dart';

class PersonalData {
  final String firstName;
  final String lastName;
  final String governorate;
  final String city;

  PersonalData({
    required this.firstName,
    required this.lastName,
    required this.governorate,
    required this.city,
  });

  @override
  int get hashCode => hashValues(firstName, lastName, governorate, city);

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final PersonalData? otherJob = other as PersonalData?;
    return firstName == otherJob!.firstName &&
        lastName == otherJob.lastName &&
        governorate == otherJob.governorate &&
        city == otherJob.city;
  }
}

class PersonalDataProvider with ChangeNotifier {
  List<PersonalData> _items = [
    PersonalData(
      firstName: 'Mohamed',
      lastName: 'Ayad',
      governorate: 'Damietta ',
      city: ' Faraskour',
    ),
    PersonalData(
      firstName: 'Mohamed',
      lastName: 'Ayad',
      governorate: 'Damietta ',
      city: ' Faraskour',
    ),
  ];

  List<PersonalData> get items {
    return [..._items];
  }

  void addPersonalData({
    required String firstName,
    required String lastName,
    required String governorate,
    required String city,
  }) {
    PersonalData personalData = PersonalData(
      firstName: firstName,
      lastName: lastName,
      governorate: governorate,
      city: city,
    );
    _items.add(personalData);
    notifyListeners();
  }
}
