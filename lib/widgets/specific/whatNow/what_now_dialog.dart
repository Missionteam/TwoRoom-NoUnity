import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tworoom/widgets/image_buttom.dart';

class WhatNowDialog extends StatefulWidget {
  WhatNowDialog(
      {Key? key,
      this.Screenpadding =
          const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
      required this.childrenWork,
      required this.childrenRoutine,
      required this.childrenEmotion})
      : super(key: key);
  EdgeInsetsGeometry Screenpadding;
  List<Widget> childrenWork;
  List<Widget> childrenRoutine;
  List<Widget> childrenEmotion;

  @override
  State<WhatNowDialog> createState() => _WhatNowDialogState();
}

class _WhatNowDialogState extends State<WhatNowDialog> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    final _context = context;
    List<Widget> childrenwork = (isGirl == true)
        ? [
            ///girl
            ImageButton(
              imageName: '${workTimepath}WorkGirl1Free.png',
              onPressd: (() {
                setActive('WorkTime/WorkGirl1Free');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkGirl118.png',
              onPressd: (() {
                setActive('WorkTime/WorkGirl118');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkGirl119.png',
              onPressd: (() {
                setActive('WorkTime/WorkGirl119');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkGirl120.png',
              onPressd: (() {
                setActive('WorkTime/WorkGirl120');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkGirl121.png',
              onPressd: (() {
                setActive('WorkTime/WorkGirl121');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkGirl124.png',
              onPressd: (() {
                setActive('WorkTime/WorkGirl124');
                Navigator.of(context).pop();
              }),
            ),
          ]
        :

        ///boy
        [
            ImageButton(
              imageName: '${workTimepath}WorkBoy1Free.png',
              onPressd: (() {
                setActive('WorkTime/WorkBoy1Free');
                GoRouter.of(context).pop('/Home1/Home11');
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkBoy118.png',
              onPressd: (() {
                setActive('WorkTime/WorkBoy118');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkBoy119.png',
              onPressd: (() {
                setActive('WorkTime/WorkBoy119');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkBoy120.png',
              onPressd: (() {
                setActive('WorkTime/WorkBoy120');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkBoy121.png',
              onPressd: (() {
                setActive('WorkTime/WorkBoy121');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkBoy124.png',
              onPressd: (() {
                setActive('WorkTime/WorkBoy124');
                Navigator.of(context).pop();
              }),
            ),
          ];
    List<Widget> children = (index == 0)
        ? widget.childrenWork
        : (index == 1)
            ? widget.childrenRoutine
            : (index == 2)
                ? widget.childrenEmotion
                : widget.childrenWork;

    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: widget.Screenpadding,
        child: Column(
          children: [
            Container(
              height: 570,
              color: Colors.white,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                padding:
                    EdgeInsets.only(bottom: 30, left: 30, right: 30, top: 50),
                children: children,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 238, 225),
                  ),
                  onPressed: () {
                    setState(() {
                      index = 0;
                    });
                  },
                  child: Text(
                    '仕事',
                    style: GoogleFonts.nunito(color: Colors.black),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 238, 225),
                  ),
                  onPressed: () {
                    setState(() {
                      index = 1;
                    });
                    ;
                  },
                  child: Text(
                    '日常',
                    style: GoogleFonts.nunito(color: Colors.black),
                  ),
                ),
                // TextButton(
                //   style: TextButton.styleFrom(
                //     backgroundColor: Color.fromARGB(255, 255, 238, 225),
                //   ),
                //   onPressed: () {
                //     setState(() {
                //       index = 2;
                //     });
                //   },
                //   child: Text(
                //     '感情',
                //     style: GoogleFonts.nunito(color: Colors.black),
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
