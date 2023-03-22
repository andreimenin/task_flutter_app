import 'package:flutter/material.dart';

class Skeleton extends StatefulWidget {

  const Skeleton({Key? key }) : super(key: key);

  @override
  createState() => SkeletonState();
}

class SkeletonState extends State<Skeleton> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;

  late Animation gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 700), vsync: this);

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear
      ),
    )..addListener(() {
      setState(() {});
    });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.forward();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
        constraints: const BoxConstraints.expand(), 
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(gradientPosition.value, 0),
            end: const Alignment(-1, 0),
            colors: const [Colors.black12, Colors.black26, Colors.black12]
          )
        ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}