import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unit_test/model/personal_data.dart';
import 'package:unit_test/screens/add_personal_data.dart';
import 'package:unit_test/widgets/personal_data_item.dart';

import '../auth.dart';

class PersonalDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final personalData = Provider.of<PersonalDataProvider>(context);
    var auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Data'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: personalData.items.length,
        itemBuilder: (context, i) {
          return PersonalDataItem(
            firstName: personalData.items[i].firstName,
            lastName: personalData.items[i].lastName,
            governorate: personalData.items[i].governorate,
            city: personalData.items[i].city,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('FloatButton'),
        onPressed: () {
          Navigator.of(context).pushNamed(AddPersonalData.id);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
