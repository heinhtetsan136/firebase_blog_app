import 'package:flutter/material.dart';

class AnimatePage extends StatefulWidget {
  const AnimatePage({super.key});

  @override
  State<AnimatePage> createState() =>
      _AnimatePageState();
}

class _AnimatePageState
    extends State<AnimatePage> {
  bool _isFirst = true;
  double width = 300;
  double height = 300;
  double _radius = 30;
  Color color = Colors.red;
  Duration duration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
            ],
          ),
        ),
      ),
    );
  }
}
