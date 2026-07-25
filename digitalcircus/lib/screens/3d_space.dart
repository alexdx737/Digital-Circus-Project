import 'dart:math' as math;

import 'package:flutter/material.dart';

class Space3DDemo extends StatefulWidget {
  const Space3DDemo({super.key});

  @override
  State<Space3DDemo> createState() => _Space3DDemoState();
}

class _Space3DDemoState extends State<Space3DDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double _speed = 1.0;
  double _tilt = 0.2;
  double _distance = 3.6;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3D Space Demo')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: constraints.maxWidth > 780 ? 460 : 320,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF131826), Color(0xFF0A0C14)],
                          ),
                        ),
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, _) {
                            return CustomPaint(
                              painter: _WireframeCubePainter(
                                tick: _controller.value,
                                speed: _speed,
                                extraTilt: _tilt,
                                distance: _distance,
                              ),
                              child: const SizedBox.expand(),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Demo 3D tipo videojuego (wireframe) en Flutter Web',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    _LabeledSlider(
                      label: 'Velocidad',
                      value: _speed,
                      min: 0.2,
                      max: 2.5,
                      onChanged: (v) => setState(() => _speed = v),
                    ),
                    _LabeledSlider(
                      label: 'Inclinacion',
                      value: _tilt,
                      min: -0.8,
                      max: 0.8,
                      onChanged: (v) => setState(() => _tilt = v),
                    ),
                    _LabeledSlider(
                      label: 'Zoom',
                      value: _distance,
                      min: 2.4,
                      max: 5.2,
                      onChanged: (v) => setState(() => _distance = v),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LabeledSlider extends StatelessWidget {
  const _LabeledSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 90, child: Text(label)),
        Expanded(
          child: Slider(value: value, min: min, max: max, onChanged: onChanged),
        ),
        SizedBox(
          width: 50,
          child: Text(value.toStringAsFixed(2), textAlign: TextAlign.end),
        ),
      ],
    );
  }
}

class _WireframeCubePainter extends CustomPainter {
  _WireframeCubePainter({
    required this.tick,
    required this.speed,
    required this.extraTilt,
    required this.distance,
  });

  final double tick;
  final double speed;
  final double extraTilt;
  final double distance;

  static const List<_Vec3> _baseVertices = [
    _Vec3(-1, -1, -1),
    _Vec3(1, -1, -1),
    _Vec3(1, 1, -1),
    _Vec3(-1, 1, -1),
    _Vec3(-1, -1, 1),
    _Vec3(1, -1, 1),
    _Vec3(1, 1, 1),
    _Vec3(-1, 1, 1),
  ];

  static const List<List<int>> _edges = [
    [0, 1],
    [1, 2],
    [2, 3],
    [3, 0],
    [4, 5],
    [5, 6],
    [6, 7],
    [7, 4],
    [0, 4],
    [1, 5],
    [2, 6],
    [3, 7],
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final unit = math.min(size.width, size.height) * 0.2;
    final angle = tick * math.pi * 2.0 * speed;

    final points = <Offset>[];
    final depths = <double>[];

    for (final v in _baseVertices) {
      final rotatedY = _rotateY(v, angle);
      final rotatedX = _rotateX(rotatedY, angle * 0.72 + extraTilt);
      final rotatedZ = _rotateZ(rotatedX, angle * 0.24);
      final z = rotatedZ.z + distance;
      final projection = unit / z;
      final screen = Offset(
        center.dx + rotatedZ.x * projection * size.width * 0.16,
        center.dy + rotatedZ.y * projection * size.width * 0.16,
      );
      points.add(screen);
      depths.add(z);
    }

    final glowPaint = Paint()
      ..color = const Color(0xFF65E2FF).withOpacity(0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final linePaint = Paint()
      ..color = const Color(0xFF8BE8FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    final scanlinePaint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..strokeWidth = 1;

    for (double y = 0; y < size.height; y += 4) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), scanlinePaint);
    }

    for (final edge in _edges) {
      canvas.drawLine(points[edge[0]], points[edge[1]], glowPaint);
    }

    for (final edge in _edges) {
      canvas.drawLine(points[edge[0]], points[edge[1]], linePaint);
    }

    final nodePaint = Paint()..color = const Color(0xFFDFF9FF);
    for (var i = 0; i < points.length; i++) {
      final radius = 2.2 + (4.5 - depths[i]).clamp(0.0, 2.2);
      canvas.drawCircle(points[i], radius, nodePaint);
    }
  }

  _Vec3 _rotateX(_Vec3 v, double a) {
    final c = math.cos(a);
    final s = math.sin(a);
    return _Vec3(v.x, v.y * c - v.z * s, v.y * s + v.z * c);
  }

  _Vec3 _rotateY(_Vec3 v, double a) {
    final c = math.cos(a);
    final s = math.sin(a);
    return _Vec3(v.x * c + v.z * s, v.y, -v.x * s + v.z * c);
  }

  _Vec3 _rotateZ(_Vec3 v, double a) {
    final c = math.cos(a);
    final s = math.sin(a);
    return _Vec3(v.x * c - v.y * s, v.x * s + v.y * c, v.z);
  }

  @override
  bool shouldRepaint(covariant _WireframeCubePainter oldDelegate) {
    return tick != oldDelegate.tick ||
        speed != oldDelegate.speed ||
        extraTilt != oldDelegate.extraTilt ||
        distance != oldDelegate.distance;
  }
}

class _Vec3 {
  const _Vec3(this.x, this.y, this.z);

  final double x;
  final double y;
  final double z;
}
