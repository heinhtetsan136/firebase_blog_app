import 'package:flutter/material.dart';

class AnimatePage extends StatefulWidget {
  const AnimatePage({super.key});

  @override
  State<AnimatePage> createState() =>
      _AnimatePageState();
}

class _AnimatePageState extends State<AnimatePage>
    with TickerProviderStateMixin {
  bool _isFirst = true;
  double width = 300;
  double height = 300;
  double _radius = 30;
  Color color = Colors.red;
  Duration duration = Duration(milliseconds: 300);
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
      lowerBound: 0,
      upperBound: 3,
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          animationController.repeat(
            reverse: true,
          );
          setState(() {
            width = width == 300 ? 200 : 300;
            height = height == 300 ? 200 : 300;
            color = color == Colors.red
                ? Colors.green
                : Colors.red;
            duration =
                duration.inMilliseconds == 300
                ? Duration(milliseconds: 600)
                : Duration(milliseconds: 800);
            _radius = _radius == 10 ? 30 : 10;
            _isFirst = !_isFirst;
          });
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius:
                      BorderRadius.circular(
                        _radius,
                      ),
                ),
                duration: duration,
                width: width,
                height: height,
              ),
              SizedBox(height: 20),
              AnimatedCrossFade(
                firstCurve: Curves.easeInOut,
                secondCurve: Curves.bounceOut,
                firstChild: FlutterLogo(
                  size: 100,
                ),
                secondChild: Icon(
                  Icons.phone,
                  size: 100,
                ),
                crossFadeState: _isFirst
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: duration,
              ),
              Padding(
                padding: const EdgeInsets.all(
                  8.0,
                ),
                child: AnimatedBuilder(
                  animation: animationController,
                  builder: (_, child) {
                    return Transform.scale(
                      scale: animationController
                          .value,
                      child: child,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(
                      8.0,
                    ),
                    child: FlutterLogo(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ClipPath(
                clipper: FiveRect(),
                child: Container(
                  width: 300,
                  height: 300,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FiveRect extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double width = size.width;
    double height = size.height;

    Path path = Path();
    path.moveTo(width / 2, 0);
    path.lineTo(0, height * 0.35);
    path.lineTo(width * 0.2, height);
    path.quadraticBezierTo(
      width / 2,
      height * 0.8,
      width * 0.8,
      height,
    );

    path.lineTo(width, height * 0.35);
    path.close();

    path.close();
    return path;
  }

  @override
  bool shouldReclip(
    covariant CustomClipper<dynamic> oldClipper,
  ) {
    return true;
  }
}
