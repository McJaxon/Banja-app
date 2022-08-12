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

class DelayedFade extends StatefulWidget {
  ///#### Delayed Fade Animation
  ///This is the [DelayedFade] animation class which uses the [FadeTransition] and [SlideTransition]
  ///transitions to smoothly fade and slide in a given widget. This takes a [child] which is the widget
  ///to animated and delay of type [int] which is the Duration of the animation
  const DelayedFade({Key? key, required this.child, required this.delay})
      : super(key: key);
  final Widget child;
  final int delay;

  @override
  State<DelayedFade> createState() => _DelayedFadeState();
}

class _DelayedFadeState extends State<DelayedFade>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

//we initialize the animation controller
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _controller);
    _animOffset = Tween<Offset>(begin: const Offset(0.0, 0.1), end: Offset.zero)
        .animate(curve);

    Timer(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    });
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
