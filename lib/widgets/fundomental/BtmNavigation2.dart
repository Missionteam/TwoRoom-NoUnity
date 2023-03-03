import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tworoom/allConstants/all_constants.dart';

class ScaffoldWithNavBar2 extends ConsumerStatefulWidget {
  /// Constructs an [ScaffoldWithNavBar2].
  const ScaffoldWithNavBar2({
    required this.child,
    Key? key,
  }) : super(key: key);

  /// The widget to display in the body of the Scaffold.
  /// In this sample, it is a Navigator.
  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScaffoldWithNavBar2State();

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location.startsWith('/Home1')) {
      return 1;
    }
    if (location.startsWith('/Chat1')) {
      return 3;
    }
    if (location.startsWith('/RoomGrid1')) {
      return 0;
    }
    if (location.startsWith('/MyRoom1')) {
      return 2;
    }
    // if (location.startsWith('/Setting')) {
    //   return 4;
    // }
    return 1;
  }
}

class _ScaffoldWithNavBar2State extends ConsumerState<ScaffoldWithNavBar2> {
  @override
  Widget build(BuildContext context) {
    // const backgroundColor = Color.fromARGB(255, 238, 192, 191);
    const backgroundColor = AppColors.main;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: widget.child,
        bottomNavigationBar: Container(
          color: AppColors.main,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color.fromARGB(147, 59, 59, 59),
                  blurRadius: 8,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Container(
                height: 120,
                child: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.import_contacts_rounded),
                      label: 'Rooms',
                      backgroundColor: Color.fromARGB(255, 180, 35, 35),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                      backgroundColor: backgroundColor,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.textsms_rounded),
                      label: 'Note',
                      backgroundColor: backgroundColor,
                    ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.account_circle_outlined),
                    //   label: 'Settings',
                    //   backgroundColor: backgroundColor,
                    // ),
                  ],
                  currentIndex:
                      ScaffoldWithNavBar2._calculateSelectedIndex(context),
                  backgroundColor: backgroundColor,
                  elevation: 10,
                  type: BottomNavigationBarType.fixed,
                  onTap: (int idx) => _onItemTapped(idx, context),
                  fixedColor: AppColors.red,
                  unselectedItemColor: Color.fromARGB(255, 150, 167, 175),
                  showUnselectedLabels: false,
                  showSelectedLabels: false,
                  selectedIconTheme: IconThemeData(size: 40),
                  unselectedIconTheme: IconThemeData(size: 30),
                  unselectedLabelStyle: GoogleFonts.nunito(
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 90, 90, 90),
                  ),
                  selectedLabelStyle: GoogleFonts.nunito(
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 90, 90, 90),
                  ),
                  enableFeedback: false,
                ),
              ),
            ),
          ),
        ));
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 1:
        GoRouter.of(context).go('/Home1');
        break;
      case 3:
        GoRouter.of(context).go('/Chat1');
        break;
      case 0:
        GoRouter.of(context).go('/RoomGrid1');
        break;
      case 2:
        GoRouter.of(context).go('/MyRoom1');
        break;
      case 4:
        GoRouter.of(context).go('/Setting');
        break;
    }
  }
}
