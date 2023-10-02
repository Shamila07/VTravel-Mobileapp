import 'package:flutter/material.dart';
import 'package:travel_app/nav_pages/profile.dart';
import 'package:travel_app/nav_pages/wishlist_page.dart';
import 'package:travel_app/nav_pages/explore_page.dart';
import 'package:travel_app/pages/home_page.dart';
import 'package:travel_app/widgets/app_text.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key});

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<String> notifications = [
    "You have a new message",
    "Your booking has been confirmed",
    "Reminder: opening at 7AM",
  ];
  int currentIndex = 3;

  final List<Widget> _pages = [
    HomePage(),
    ExplorePage(),
    WishlistPage(),
    Notifications(),
    Profile(),
  ];

  void _navigateToPage(int index) {
    if (index != currentIndex) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => _pages[index]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const SizedBox(height: 20),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
            ),
            const SizedBox(width: 10),
            AppText(
              text: 'Notifications',
              size: 22,
              color: Colors.black,
            ),
          ],
        ),
        ListView.builder(
          itemCount: notifications.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(notifications[index]),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Do something when the notification is clicked
              },
            );
          },
        ),
      ],
      ),
      ),
    bottomNavigationBar: BottomNavigationBar(
    unselectedFontSize: 0,
    selectedFontSize: 0,
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color(0xFF000040),
    onTap: _navigateToPage,
    currentIndex: currentIndex,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey.withOpacity(0.5),
    showUnselectedLabels: false,
    showSelectedLabels: false,
    elevation: 0,
    items: const [
    BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.explore),
    label: 'Explore',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.apps),
    label: 'Apps',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.add_alert),
    label: 'Alerts',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.bookmark_add_rounded),
    label: 'Bookmarks',
    ),
    ],
    ),
    );

  }
}
