import 'package:flutter_test/flutter_test.dart';
import 'package:unit_test/model/personal_data.dart';
import 'package:unit_test/screens/add_personal_data.dart';

void main() {
  group('Name', () {
    test('empty First Name', () {
      var result = FirstNameValidator.validate('');
      expect(result, 'first Name is empty');
    });
    test(' First Name', () {
      var result = FirstNameValidator.validate('first');
      expect(result, null);
    });

    test('empty Last Name', () {
      var result = LastNameValidator.validate('');
      expect(result, 'last Name is empty');
    });
  });

  group('City Name', () {
    test('City Name', () {
      var result = CityNameValidator.validate('');
      expect(result, 'city Name is empty');
    });
    test('City Name LowerCase', () {
      var result = CityNameValidator.validate('City');
      expect(result, null);
    });
  });

  test('Personal Data', () {
    final result = PersonalData(
      firstName: 'Mohamed',
      lastName: 'Ayad',
      governorate: 'Damietta ',
      city: ' Faraskour',
    );
    expect(
      result,
      PersonalData(
        firstName: 'Mohamed',
        lastName: 'Ayad',
        governorate: 'Damietta ',
        city: ' Faraskour',
      ),
    );
  });
}
