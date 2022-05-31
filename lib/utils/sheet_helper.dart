//  DISABILITY INFORMATION MANAGEMENT SYSTEM - DMIS
//
//  Created by Ronnie Zad.
//  2021, Centric Solutions-UG. All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CupertinoBottomSheet extends StatelessWidget {
  const CupertinoBottomSheet(
      {Key? key,
      required this.child,
      this.backgroundColor,
      this.topPadding = 10})
      : super(key: key);

  final Color? backgroundColor;

  /// Widget to render
  final Widget child;

  /// Add padding to the top of [child], this is also the height of visible
  /// content behind [child]
  ///
  /// Defaults to 10
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    final topSafeAreaPadding = MediaQuery.of(context).padding.top;
    final topPadding = this.topPadding + topSafeAreaPadding;
    const radius = Radius.circular(12);
    const shadow =
        BoxShadow(blurRadius: 10, color: Colors.black12, spreadRadius: 5);
    final backgroundColor = this.backgroundColor ??
        CupertinoTheme.of(context).scaffoldBackgroundColor;

    final decoration =
        BoxDecoration(color: backgroundColor, boxShadow: const [shadow]);

    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: ClipRRect(
        borderRadius:
            const BorderRadius.only(topLeft: radius, topRight: radius),
        child: Container(
          decoration: decoration,
          width: double.infinity,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: child,
          ),
        ),
      ),
    );
  }
}

class CupertinoModalTransition extends StatelessWidget {
  const CupertinoModalTransition({
    Key? key,
    required this.animation,
    required this.child,
    required this.behindChild,
    this.animationCurve,
  }) : super(key: key);

  final Animation<double> animation;
  final Curve? animationCurve;
  final Widget behindChild;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var startRoundCorner = 0.0;
    final paddingTop = MediaQuery.of(context).padding.top;
    if (Theme.of(context).platform == TargetPlatform.iOS && paddingTop > 20) {
      startRoundCorner = 12.5;
    }

    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: animationCurve ?? Curves.bounceIn,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AnimatedBuilder(
        animation: curvedAnimation,
        child: child,
        builder: (context, child) {
          final progress = curvedAnimation.value;
          final yOffset = progress * paddingTop;
          final scale = 1 - progress / 10;
          final radius = progress == 0
              ? 0.0
              : (1 - progress) * startRoundCorner + progress * 12;
          return Stack(
            children: [
              GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Container(color: Colors.black),
              ),
              GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Transform.translate(
                  offset: Offset(0, yOffset),
                  child: Transform.scale(
                    scale: scale,
                    alignment: Alignment.topCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radius),
                      child: behindChild,
                    ),
                  ),
                ),
              ),
              child!,
            ],
          );
        },
      ),
    );
  }
}
