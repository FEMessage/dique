import 'dart:math' as Math;
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ExplosionWidget extends StatefulWidget {
  final Widget child;
  final Rect bound;
  final String tag;
//  final Function onExplosionFun;
  final VoidCallback onComplete;
  final bool start;

  const ExplosionWidget({Key key,@required this.child, this.bound, this.tag, @required this.onComplete, @required this.start = false})
      : super(key: key);

  @override
  _ExplosionWidgetState createState() => _ExplosionWidgetState();
}

class _ExplosionWidgetState extends State<ExplosionWidget>
    with SingleTickerProviderStateMixin {
  ByteData _byteData;
  Size _imageSize;
  AnimationStatus _status = AnimationStatus.forward;

  AnimationController _animationController;

  GlobalObjectKey globalKey;

  @override
  void initState() {
    super.initState();
    globalKey = GlobalObjectKey(widget.tag);
    _animationController =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    _animationController.addStatusListener((status){
      debugPrint("动画状态:${status}");
      _status = status;
      if(status == AnimationStatus.completed){
        _animationController.stop();
        widget.onComplete();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    globalKey?.currentState?.dispose();
  }

  void onExplosion() {
    if (_byteData == null || _imageSize == null) {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      boundary.toImage().then((image) {
        _imageSize = Size(image.width.toDouble(), image.height.toDouble());
        image.toByteData().then((byteData) {
          _byteData = byteData;
          _animationController.value = 0;
          _animationController.forward();
          setState(() {});
        });
      });
    } else {
      _animationController.value = 0;
      _animationController.forward();
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(ExplosionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tag != oldWidget.tag) {
      _byteData = null;
      _imageSize = null;
      globalKey = GlobalObjectKey(widget.tag);
    }
  }

  @override
  Widget build(BuildContext context) {

    if(widget.start){
      onExplosion();
    }
    return Container(
        alignment: Alignment.center,
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return ExplosionRenderObjectWidget(
                key: globalKey,
                child:  widget.child ,
                byteData: _byteData,
                imageSize: _imageSize,
                progress: _animationController.value,
              );
            }));
  }
}

class ExplosionRenderObjectWidget extends RepaintBoundary {
  final ByteData byteData;
  final Size imageSize;
  final double progress;
  final Rect bound;

  const ExplosionRenderObjectWidget(
      {Key key,
      Widget child,
      this.byteData,
      this.imageSize,
      this.progress,
      this.bound})
      : super(key: key, child: child);

  @override
  _ExplosionRenderObject createRenderObject(BuildContext context) =>
      _ExplosionRenderObject(
          byteData: byteData, imageSize: imageSize, bound: bound);

  @override
  void updateRenderObject(
      BuildContext context, _ExplosionRenderObject renderObject) {
    renderObject.update(byteData, imageSize, progress);
  }
}

class _ExplosionRenderObject extends RenderRepaintBoundary {
  ByteData byteData;
  Size imageSize;
  double progress;
  List<_Particle> particles;
  Rect bound;

  _ExplosionRenderObject(
      {this.byteData, this.imageSize, this.bound, RenderBox child})
      : super(child: child);

  void update(ByteData byteData, Size imageSize, double progress) {
    this.byteData = byteData;
    this.imageSize = imageSize;
    this.progress = progress;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (byteData != null &&
        imageSize != null &&
        progress != 0 &&
        progress != 1) {
      if (particles == null) {
        if (bound == null) {
          bound = Rect.fromLTWH(0, 0, size.width, size.height * 2);
        }
        particles = initParticleList(bound, byteData, imageSize);
      }
      draw(context.canvas, particles, progress);
    } else {
      if (child != null) {
        context.paintChild(child, offset);
      }
    }
  }
}

const double END_VALUE = 1.4;
const double V = 2;
const double X = 5;
const double Y = 20;
const double W = 1;

List<_Particle> initParticleList(
    Rect bound, ByteData byteData, Size imageSize) {
  int partLen = 15;
  List<_Particle> particles = List(partLen * partLen);
  Math.Random random = new Math.Random(DateTime.now().millisecondsSinceEpoch);
  int w = imageSize.width ~/ (partLen + 2);
  int h = imageSize.height ~/ (partLen + 2);
  for (int i = 0; i < partLen; i++) {
    for (int j = 0; j < partLen; j++) {
      particles[(i * partLen) + j] = generateParticle(
          getColorByPixel(byteData, imageSize,
              Offset((j + 1) * w.toDouble(), (i + 1) * h.toDouble())),
          random,
          bound);
    }
  }
  return particles;
}

Color getColorByPixel(ByteData byteData, Size size, Offset pixel) {
  //rawRgba
  assert(byteData.lengthInBytes == size.width * size.height * 4);
  assert(pixel.dx < size.width && pixel.dy < size.height);
  int index = ((pixel.dy * size.width + pixel.dx) * 4).toInt();
  int r = byteData.getUint8(index);
  int g = byteData.getUint8(index + 1);
  int b = byteData.getUint8(index + 2);
  int a = byteData.getUint8(index + 3);
  return Color.fromARGB(a, r, g, b);
}


bool draw(Canvas canvas, List<_Particle> particles, double progress) {
  Paint paint = Paint();
  for (int i = 0; i < particles.length; i++) {
    _Particle particle = particles[i];
    particle.advance(progress);
    if (particle.alpha > 0) {
      paint.color = particle.color
          .withAlpha((particle.color.alpha * particle.alpha).toInt());
      canvas.drawCircle(
          Offset(particle.cx, particle.cy), particle.radius, paint);
    }
  }
  return true;
}

_Particle generateParticle(Color color, Math.Random random, Rect bound) {
  _Particle particle = _Particle();
  particle.color = color;
  particle.radius = V;
  if (random.nextDouble() < 0.2) {
    particle.baseRadius = V + ((X - V) * random.nextDouble());
  } else {
    particle.baseRadius = W + ((V - W) * random.nextDouble());
  }
  double nextDouble = random.nextDouble();
  particle.top = bound.height * ((0.18 * random.nextDouble()) + 0.2);
  particle.top = nextDouble < 0.2
      ? particle.top
      : particle.top + ((particle.top * 0.2) * random.nextDouble());
  particle.bottom = (bound.height * (random.nextDouble() - 0.5)) * 1.8;
  double f = nextDouble < 0.2
      ? particle.bottom
      : nextDouble < 0.8 ? particle.bottom * 0.6 : particle.bottom * 0.3;
  particle.bottom = f;
  particle.mag = 4.0 * particle.top / particle.bottom;
  particle.neg = (-particle.mag) / particle.bottom;
  f = bound.center.dx + (Y * (random.nextDouble() - 0.5));
  particle.baseCx = f;
  particle.cx = f;
  f = bound.center.dy + (Y * (random.nextDouble() - 0.5));
  particle.baseCy = f;
  particle.cy = f;
  particle.life = END_VALUE / 10 * random.nextDouble();
  particle.overflow = 0.4 * random.nextDouble();
  particle.alpha = 1;
  return particle;
}

class _Particle {
  double alpha;
  Color color;
  double cx;
  double cy;
  double radius;
  double baseCx;
  double baseCy;
  double baseRadius;
  double top;
  double bottom;
  double mag;
  double neg;
  double life;
  double overflow;

  void advance(double factor) {
    double f = 0;
    double normalization = factor / END_VALUE;
    if (normalization < life || normalization > 1 - overflow) {
      alpha = 0;
      return;
    }
    normalization = (normalization - life) / (1 - life - overflow);
    double f2 = normalization * END_VALUE;
    if (normalization >= 0.7) {
      f = (normalization - 0.7) / 0.3;
    }
    alpha = 1 - f;
    f = bottom * f2;
    cx = baseCx + f;
    cy = (baseCy - this.neg * Math.pow(f, 2.0)) - f * mag;
    radius = V + (baseRadius - V) * f2;
  }
}
