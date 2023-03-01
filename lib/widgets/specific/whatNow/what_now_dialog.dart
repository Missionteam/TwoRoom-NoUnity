import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  int index = 0;
  @override
  Widget build(BuildContext context) {
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
                    // showDialog(
                    //     context: context,
                    //     builder: (_) => WhatNowDialog(children: children));
                  },
                  child: Text(
                    '日常',
                    style: GoogleFonts.nunito(color: Colors.black),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 238, 225),
                  ),
                  onPressed: () {
                    setState(() {
                      index = 2;
                    });
                  },
                  child: Text(
                    '感情',
                    style: GoogleFonts.nunito(color: Colors.black),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
