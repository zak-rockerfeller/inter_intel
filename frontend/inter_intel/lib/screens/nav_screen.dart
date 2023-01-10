import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:inter_intel/screens/screens.dart';

class NavScreen extends StatefulWidget {
  int selectedIndex;

  NavScreen({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  NavScreenState createState() => NavScreenState();
}

class NavScreenState extends State<NavScreen> {
  static final List<Widget> _widgetOptions = <Widget>[
    const InfoScreen(),
    const DesignScreen(),
    const ResponseScreen(),
    const DictionaryScreen(),
  ];



  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: _widgetOptions.elementAt(widget.selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.blue,
              gap: 5,
              activeColor: Colors.blue,
              iconSize: 25,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.blue,
              tabs: const [
                GButton(
                  icon:  Icons.info_outline_rounded,
                  text: 'Info',
                ),
                GButton(
                  icon: Icons.design_services_rounded,
                  text: 'Design',
                ),
                GButton(
                  icon: Icons.message_rounded,
                  text: 'Response',
                ),
                GButton(
                  icon: Icons.book_online_rounded,
                  text: 'Dictionary',
                ),
              ],
              selectedIndex: widget.selectedIndex,
              onTabChange: (index) {
                setState(() {
                  widget.selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
