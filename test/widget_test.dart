import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:iot_monitoring_app/main.dart';

void main() {
  testWidgets('dashboard displays dummy sensor and MQTT information',
      (WidgetTester tester) async {
    await tester.pumpWidget(const IoTMonitoringApp());

    expect(tester.getSize(find.byType(CustomScrollView)).width, 680);
    expect(find.text('IoT Monitoring'), findsOneWidget);
    expect(find.text('Connected'), findsOneWidget);
    expect(find.text('30.5°C'), findsNWidgets(2));
    expect(find.text('75%'), findsOneWidget);
    expect(find.text('broker.hivemq.com'), findsOneWidget);
    expect(find.text('kampus/iot/kelas1/sensor'), findsOneWidget);
    expect(find.text('Monitoring history'), findsOneWidget);
    expect(find.text('28.0°C'), findsOneWidget);
    expect(find.text('10:15'), findsWidgets);

    await tester.tap(find.byTooltip('Refresh dummy data'));
    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}
