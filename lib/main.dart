import 'package:flutter/material.dart';

void main() {
  runApp(const IoTMonitoringApp());
}

class IoTMonitoringApp extends StatelessWidget {
  const IoTMonitoringApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF1677E8);

    return MaterialApp(
      title: 'IoT Monitoring',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          surface: const Color(0xFFF7F9FC),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        fontFamily: 'Roboto',
      ),
      home: const DashboardPage(),
    );
  }
}

class SensorReading {
  const SensorReading(this.time, this.temperature);

  final String time;
  final double temperature;
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _lastUpdated = '10:15:30';

  static const _readings = <SensorReading>[
    SensorReading('10:00', 28),
    SensorReading('10:05', 29),
    SensorReading('10:10', 28.5),
    SensorReading('10:15', 30.5),
  ];

  void _refreshData() {
    final now = TimeOfDay.now();
    final time =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    setState(() => _lastUpdated =
        '$time:${DateTime.now().second.toString().padLeft(2, '0')}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: SizedBox(
              width: double.infinity,
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          _DashboardHeader(
                            onRefresh: _refreshData,
                          ),
                          const SizedBox(height: 22),
                          const _SectionHeading(
                            title: 'Live readings',
                            subtitle: 'Current sensor values',
                          ),
                          const SizedBox(height: 12),
                          const Row(
                            children: [
                              Expanded(
                                child: _SensorCard(
                                  title: 'Temperature',
                                  value: '30.5',
                                  unit: '°C',
                                  caption: 'Sensor DHT11',
                                  icon: Icons.thermostat_rounded,
                                  color: Color(0xFF1677E8),
                                  background: Color(0xFFE7F2FF),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: _SensorCard(
                                  title: 'Humidity',
                                  value: '75',
                                  unit: '%',
                                  caption: 'Sensor DHT11',
                                  icon: Icons.water_drop_outlined,
                                  color: Color(0xFF148653),
                                  background: Color(0xFFE8F7EF),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _ConnectionCard(lastUpdated: _lastUpdated),
                          const SizedBox(height: 22),
                          const _HistoryCard(readings: _readings),
                          const SizedBox(height: 18),
                          const Center(
                            child: Text(
                              'IoT Monitoring • Demo mode',
                              style: TextStyle(
                                color: Color(0xFF8A94A3),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({required this.onRefresh});

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFE7F2FF),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.sensors_rounded,
            color: Color(0xFF1677E8),
            size: 25,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'IoT Monitoring',
                style: TextStyle(
                  color: Color(0xFF172334),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Dashboard monitoring sensor',
                style: TextStyle(color: Color(0xFF788394), fontSize: 12),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Refresh dummy data',
          onPressed: onRefresh,
          icon: const Icon(Icons.refresh_rounded),
          color: const Color(0xFF596779),
        ),
      ],
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF172334),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(color: Color(0xFF8A94A3), fontSize: 11),
        ),
      ],
    );
  }
}

class _SensorCard extends StatelessWidget {
  const _SensorCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.caption,
    required this.icon,
    required this.color,
    required this.background,
  });

  final String title;
  final String value;
  final String unit;
  final String caption;
  final IconData icon;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 150),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: color),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: color.withOpacity(0.9),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text.rich(
              TextSpan(
                text: value,
                style: TextStyle(
                  color: color,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.8,
                ),
                children: [
                  TextSpan(
                    text: unit,
                    style: const TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            caption,
            style: TextStyle(
              color: color.withOpacity(0.68),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class _ConnectionCard extends StatelessWidget {
  const _ConnectionCard({required this.lastUpdated});

  final String lastUpdated;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE9EDF2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'MQTT connection',
                  style: TextStyle(
                    color: Color(0xFF172334),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F6ED),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.circle, size: 7, color: Color(0xFF159450)),
                    SizedBox(width: 6),
                    Text(
                      'Connected',
                      style: TextStyle(
                        color: Color(0xFF137A45),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          const _InfoRow(label: 'Broker', value: 'broker.hivemq.com'),
          const SizedBox(height: 9),
          const _InfoRow(label: 'Topic', value: 'kampus/iot/kelas1/sensor'),
          const SizedBox(height: 9),
          _InfoRow(label: 'Last update', value: lastUpdated),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Color(0xFF8390A0), fontSize: 12),
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFF354255),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.readings});

  final List<SensorReading> readings;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE9EDF2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Monitoring history',
                      style: TextStyle(
                        color: Color(0xFF172334),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Temperature (°C)',
                      style: TextStyle(color: Color(0xFF8390A0), fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F3F7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Dummy data',
                  style: TextStyle(
                    color: Color(0xFF647184),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Simulated sensor readings for dashboard preview.',
            style: TextStyle(color: Color(0xFF647184), fontSize: 12),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            width: double.infinity,
            child: CustomPaint(
              painter: _TemperatureChartPainter(readings: readings),
            ),
          ),
          const SizedBox(height: 6),
          const Center(
            child: Text(
              'Time',
              style: TextStyle(
                color: Color(0xFF647184),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE9EDF2)),
          const SizedBox(height: 4),
          for (final reading in readings) _ReadingRow(reading: reading),
        ],
      ),
    );
  }
}

class _ReadingRow extends StatelessWidget {
  const _ReadingRow({required this.reading});

  final SensorReading reading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF0F2F5))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              reading.time,
              style: const TextStyle(
                color: Color(0xFF354255),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '${reading.temperature}°C',
              style: const TextStyle(color: Color(0xFF354255), fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _TemperatureChartPainter extends CustomPainter {
  const _TemperatureChartPainter({required this.readings});

  final List<SensorReading> readings;

  @override
  void paint(Canvas canvas, Size size) {
    const left = 28.0;
    const right = 8.0;
    const top = 8.0;
    const bottom = 25.0;
    final chart = Rect.fromLTRB(
      left,
      top,
      size.width - right,
      size.height - bottom,
    );

    final axisPaint = Paint()
      ..color = const Color(0xFFE5EAF0)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(chart.left, chart.top),
      Offset(chart.left, chart.bottom),
      axisPaint,
    );
    canvas.drawLine(
      Offset(chart.left, chart.bottom),
      Offset(chart.right, chart.bottom),
      axisPaint,
    );

    if (readings.isEmpty) return;

    final minValue = readings
        .map((reading) => reading.temperature)
        .reduce((a, b) => a < b ? a : b);
    final maxValue = readings
        .map((reading) => reading.temperature)
        .reduce((a, b) => a > b ? a : b);
    final range = (maxValue - minValue).clamp(1.0, double.infinity);
    final points = <Offset>[];

    for (var index = 0; index < readings.length; index++) {
      final x = readings.length == 1
          ? chart.center.dx
          : chart.left + chart.width * index / (readings.length - 1);
      final normalized = (readings[index].temperature - minValue) / range;
      final y = chart.bottom - (normalized * chart.height * 0.78) - 6;
      points.add(Offset(x, y));
    }

    final linePaint = Paint()
      ..color = const Color(0xFF1677E8)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final point in points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }
    canvas.drawPath(path, linePaint);

    final pointPaint = Paint()..color = const Color(0xFF1677E8);
    for (var index = 0; index < points.length; index++) {
      canvas.drawCircle(points[index], 4, pointPaint);
      final label = TextPainter(
        text: TextSpan(
          text: readings[index].time,
          style: const TextStyle(color: Color(0xFF8994A3), fontSize: 9),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      label.paint(
        canvas,
        Offset(
          (points[index].dx - label.width / 2)
              .clamp(chart.left, chart.right - label.width),
          chart.bottom + 7,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TemperatureChartPainter oldDelegate) {
    return oldDelegate.readings != readings;
  }
}
