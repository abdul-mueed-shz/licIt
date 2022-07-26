import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

class MySlideTransition extends StatefulWidget {
  final Widget child;
  final Offset offset;

  /// delay in milliseconds
  final int delay;

  /// duration in milliseconds
  final int duration;

  const MySlideTransition({
    required this.child,
    this.offset = const Offset(0.5, 0.0),
    this.delay = 600,
    this.duration = 300,
    Key? key,
  }) : super(key: key);

  @override
  _MySlideTransitionState createState() => _MySlideTransitionState();
}

class _MySlideTransitionState extends State<MySlideTransition>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration.milliseconds,
    vsync: this,
  );

  @override
  void initState() {
    super.initState();

    widget.delay.milliseconds.delay.then((value) => _controller.forward());
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: widget.offset
            .tweenTo(Offset.zero)
            .curved(Curves.easeOutExpo)
            .animatedBy(_controller),
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
