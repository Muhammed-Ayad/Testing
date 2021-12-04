import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unit_test/widgets/custtom_material_button.dart';

void main() {
  testWidgets('Custom Material Button', (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomMaterialButton(
            keyName: 'signIn',
            onPressed: () => pressed = true,
            title: 'Button',
          ),
        ),
      ),
    );

    final button = find.byType(MaterialButton);
    await tester.tap(button);
    expect(pressed, true);
    
  });
}
