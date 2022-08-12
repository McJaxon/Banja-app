///  ZOFI CASH APP
///
// / Created by Ronnie Zad Muhanguzi .
// / 2022, Zofi Cash App. All rights reserved.
///
///  Unless required by applicable law or agreed to in writing, software
///  distributed under the License is distributed on an "AS IS" BASIS,
///  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'dart:async';
import 'package:flutter/material.dart';

class Animator extends StatefulWidget {
  ///#### Animator Animation
///This is the [Animator] animation class which uses the [AnimatedBuilder] to create a custom
///animation. This takes a curve, builder, and  delay of type [int] which is the Duration
/// of the animation
  const Animator(
      {Key? key,
      this.curve = Curves.linear,
      required this.builder,
      required this.delay})
      : super(key: key);
  final int delay;
  final Curve curve;
  final Function(BuildContext context, Widget? child, double value) builder;
  @override
  State<Animator> createState() => _AnimatorState();
}

class _AnimatorState extends State<Animator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late Timer timer;

  @override
  void initState() {

    //here we initialize the controller
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.delay),
        upperBound: .99,
        lowerBound: .1);
    animation = CurvedAnimation(parent: controller, curve: widget.curve);
    timer = Timer(const Duration(milliseconds: 200), controller.forward);

    super.initState();
  }

  @override
  void dispose() {
    //we dispose the animation controller after it has been used
    controller.dispose();

    //we cancel the timer after removing this widget from the tree so as to avoid leaks
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return widget.builder(context, child, animation.value);
      },
    );
  }
}
