import 'package:flutter/material.dart';

class IconAnimation extends StatefulWidget {
  final bool show;
  final VoidCallback onComplete;
  final IconData icon;
  final Color color;

  IconAnimation({
    required this.show,
    required this.onComplete,
    required this.icon,
    required this.color,
  });

  @override
  _IconAnimationState createState() => _IconAnimationState();
}

class _IconAnimationState extends State<IconAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, -3),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.5,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
        _controller.reset();
      }
    });

    if (widget.show) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(IconAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.show
        ? Positioned(
            top: MediaQuery.of(context).size.height / 2 - 24,
            left: MediaQuery.of(context).size.width / 2 - 24,
            child: SlideTransition(
              position: _slideAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Icon(
                  widget.icon,
                  color: widget.color,
                  size: 52.0,
                ),
              ),
            ),
          )
        : Container();
  }
}
