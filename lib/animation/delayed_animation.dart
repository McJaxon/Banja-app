//  ZOFI CASH APP
//
//  Created by Ronnie Zad Muhanguzi .
//  2022, Zofi Cash App. All rights reserved.
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'dart:async';
import 'package:flutter/material.dart';

class DelayedAnimation extends StatefulWidget {
  ///#### Delayed Animation
  ///This is the [DelayedAnimation] animation class which uses the [FadeTransition] and [SlideTransition]
  ///transitions to smoothly fade and slide in a given widget. This takes a [child] which is the widget
  ///to animated and delay of type [int] which is the Duration of the animation
  final Widget child;
  final int delay;

  const DelayedAnimation({Key? key, required this.child, required this.delay})
      : super(key: key);

  @override
  State<DelayedAnimation> createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
//we initialize the animation controller
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _controller);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

    Timer(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    //we dispose the animation controller after it has been used
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}
