//  DISABILITY INFORMATION MANAGEMENT SYSTEM - DMIS
//
//  Created by Ronnie Zad.
//  2021, Centric Solutions-UG. All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'package:banja/utils/sheet_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationSheet extends StatefulWidget {
  const NotificationSheet({
    Key? key,
  }) : super(key: key);

  @override
  _NotificationSheetSheet createState() => _NotificationSheetSheet();
}

class _NotificationSheetSheet extends State<NotificationSheet> {
  bool isDialogPopped = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoBottomSheet(
      topPadding: 0,
      child: NotificationListener<DraggableScrollableNotification>(
        onNotification: (DraggableScrollableNotification notification) {
          if (!isDialogPopped &&
              notification.extent == notification.minExtent) {
            isDialogPopped = true;
            Navigator.of(context).pop();
          }
          return false;
        },
        child: CupertinoApp(
          theme: const CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                  textStyle: TextStyle(fontFamily: 'Poppins'))),
          debugShowCheckedModeBanner: false,
          title: 'Tuula Credit App',
          color: const Color(0xFFf5f6fb),
          home: CupertinoScrollbar(
            child: CustomScrollView(shrinkWrap: false, slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: Text('NOTIFICATION AREA',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 30.sp)),
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text('DONE',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: const Color(0xff007981),
                          fontWeight: FontWeight.w800,
                          fontSize: 20.sp)),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Stack(
                    children: [
                      Column(children: [
                        SizedBox(
                          height: 102.h,
                        ),
                        const Center(
                            child: Text(
                          'Your new notifications and messages will appear here',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        SizedBox(
                          height: 30.h,
                        ),
                      ]),
                    ],
                  ),
                )
              ]))
            ]),
          ),
        ),
      ),
    );
  }
}
