library circle_wave_progress;

import 'dart:math';

import 'package:flutter/material.dart';

class CircleWaveProgress extends StatefulWidget {
  final double size;
  final Color backgroundColor;
  final Color waveColor;
  final Color borderColor;
  final borderWidth;
  final double progress;

  CircleWaveProgress(
      {this.size = 200.0,
      this.backgroundColor = Colors.blue,
      this.waveColor = Colors.white,
      this.borderColor = Colors.white,
      this.borderWidth = 10.0,
      this.progress = 50.0})
      :assert(progress >= 0 && progress <= 100,
            'Valid range of progress value is [0.0, 100.0]');

  @override
  _WaveWidgetState createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<CircleWaveProgress>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    /// Only run the animation if the progress > 0. Since we don't need to draw the wave when progress = 0
    if (widget.progress > 0) {
      _animationController.repeat();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      child: ClipPath(
        clipper: CircleClipper(),
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, Widget child) {
              return CustomPaint(
                painter: WaveWidgetPainter(
                    animation: _animationController,
                    backgroundColor: widget.backgroundColor,
                    waveColor: widget.waveColor,
                    borderColor: widget.borderColor,
                    borderWidth: widget.borderWidth,
                    progress: widget.progress),
              );
            }),
      ),
    );
  }
}

class WaveWidgetPainter extends CustomPainter {
  Animation<double> animation;
  Color backgroundColor, waveColor, borderColor;
  double borderWidth;
  double progress;

  WaveWidgetPainter(
      {this.animation,
      this.backgroundColor,
      this.waveColor,
      this.borderColor,
      this.borderWidth,
      this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    /// Draw background
    Paint backgroundPaint = Paint()
      ..color = this.backgroundColor
      ..style = PaintingStyle.fill;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, backgroundPaint);

    /// Draw wave
    Paint wavePaint = new Paint()..color = waveColor;
    double amp = 15.0;
    double p = progress / 100.0;
    double baseHeight = (1 - p) * size.height;

    Path path = Path();
    path.moveTo(0.0, baseHeight);
    for (double i = 0.0; i < size.width; i++) {
      path.lineTo(
          i,
          baseHeight +
              sin((i / size.width * 2 * pi) + (animation.value * 2 * pi)) *
                  amp);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    canvas.drawPath(path, wavePaint);

    /// Draw border
    Paint borderPaint = Paint()
      ..color = this.borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = this.borderWidth;

    canvas.drawCircle(center, radius, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(new Rect.fromCircle(
          center: new Offset(size.width / 2, size.height / 2),
          radius: size.width / 2));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
