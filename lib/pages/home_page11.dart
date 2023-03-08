import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tworoom/models/whatNow.dart';

import '../models/gage_model.dart';
import '../providers/users_provider.dart';
import '../widgets/specific/whatNow/what_now_dialog.dart';

class HomePage11 extends ConsumerStatefulWidget {
  const HomePage11({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage11> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  // late UnityWidgetController unityWidgetController;
  bool isWoman = true;

  // @override
  // void dispose() {
  //   unityWidgetController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final gage = ref.watch(GageProvider).gage;
    final isUserWhatNow = ref.watch(isUserWhatNowProvider).isUser;
    final WhatNowName = ref.watch(whatNowNameProvider(isUserWhatNow));
    final displayName = ref.watch(whatNowDisplayNameProvider(isUserWhatNow));

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Container(
          width: double.infinity,
          // color: AppColors.main,
          color: Color.fromARGB(255, 255, 239, 225),
          child: Stack(alignment: Alignment.center, children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 350,
                  child: SizedBox(
                    height: 370,
                    width: 270,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // UnityWidget(
                        //   onUnityCreated: onUnityCreated,
                        //   fullscreen: false,
                        // ),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Image.asset(
                                  'images/whatNowStamp/${WhatNowName}'),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(displayName),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () => showWhatNow(context),
                          onHorizontalDragEnd: (details) {
                            ref
                                .watch(isUserWhatNowProvider.notifier)
                                .IsUserChange();
                          },
                        ),

                        // MaterialButton(
                        //   height: 200,
                        //   minWidth: 200,
                        //   onPressed: () => showWhatNow(context),
                        // )
                      ],
                    ),
                  ),
                ),
                // MaterialButton(
                //   // elevation: 8.0,
                //   child: Container(
                //     height: 50,
                //     width: 250,
                //     decoration: BoxDecoration(
                //       image: DecorationImage(
                //         image: AssetImage('images/SorryForLate.png'),
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),
                //   onPressed: () {
                //     showDialog(
                //         context: context,
                //         builder: (_) {
                //           return SorryGirdDialog();
                //           // return EngageDialog();
                //         });
                //   },
                //   // onPressed: () {}
                // ),
              ],
            ),
            // Positioned(
            //     right: 50,
            //     top: 30,
            //     child: CustomPaint(
            //       size: Size(40, 40),
            //       painter: DrawTriangle(ref),
            //     )),
            // Positioned(
            //     left: 120,
            //     top: 80,
            //     width: 200,
            //     child: Image.asset('images/whatNowStamp/WaitReply.png')),
            Positioned(
                width: 70,
                height: 70,
                left: 50,
                top: 220,
                child: ref.watch(EngageStampProvider)

                // ),
                )
          ]),
        ),
      ),
    );
  }

  Future<dynamic> showWhatNow(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return WhatNowDialog();
          // return EngageDialog();
        });
  }

  void setActive(String stampname) {
    final currentUserDoc = ref.watch(CurrentAppUserDocProvider).value;
    ref.watch(isUserWhatNowProvider.notifier).IsUserTrue();
    currentUserDoc?.reference.update({'whatNow': '${stampname}.png'});
  }
  // void setActive(String object) {
  //   ///Activeは最後に実行。
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'VanishWaitGirl',
  //     '',
  //   );
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'VanishWalkGirl',
  //     '',
  //   );
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'VanishWorkGirl',
  //     '',
  //   );
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'VanishSleepGirl',
  //     '',
  //   );
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'VanishWaitBoy',
  //     '',
  //   );
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'VanishWalkBoy',
  //     '',
  //   );
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'VanishWorkBoy',
  //     '',
  //   );
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'VanishSleepBoy',
  //     '',
  //   );

  //   ///Active
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'Active${object}',
  //     object,
  //   );
  // }

  // void setVanish(String object) {
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'Vanish${object}',
  //     object,
  //   );
  // }

  // void onUnitySceneLoaded(SceneLoaded scene) {
  //   print('Received scene loaded from unity: ${scene.name}');
  //   print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
  // }

  // void onUnityCreated(controller) {
  //   controller.resume();
  //   unityWidgetController = controller;
  // }
}
