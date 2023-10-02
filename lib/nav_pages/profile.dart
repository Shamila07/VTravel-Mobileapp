import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/widgets/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/pages/login_page.dart';
import 'package:travel_app/pages/home_page.dart';
import 'package:travel_app/nav_pages/explore_page.dart';
import 'package:travel_app/nav_pages/wishlist_page.dart';
import 'package:travel_app/nav_pages/notifications.dart';
import 'package:travel_app/nav_pages/profile.dart';
import 'package:travel_app/pages/contact_us.dart'; // Import the ContactUsPage

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser;

  int currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ExplorePage(),
    WishlistPage(),
    Notifications(),
    Profile(),
  ];

  void _navigateToPage(int index) {
    if (index != 4) {
      setState(() {
        currentIndex = index;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => _pages[index]),
      );
    }
  }

  void _navigateToOption(String option) {
    switch (option) {
      case 'Personal Information':
      // Navigate to Personal Information page
        break;
      case 'Booking History':
      // Navigate to Booking History page
        break;
      case 'Notifications':
      // Navigate to Notifications page
        break;
      case 'Privacy & Sharing':
      // Navigate to Privacy & Sharing page
        break;
      case 'Contact Us':
      // Navigate to Contact Us page
        Navigator.pushNamed(context, '/contact');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  "lib/images/user.png",
                  width: 80,
                  height: 80,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: 'Amesh', size: 20),
                    SizedBox(height: 5),
                    AppText(text: 'Show Profile', size: 12),
                  ],
                ),
                Spacer(),
                MaterialButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                          (Route<dynamic> route) => false,
                    );
                  },
                  color: Color(0xFF000040),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            profileOptionRow(
              Icons.person,
              'Personal Information',
            ),
            SizedBox(height: 20),
            profileOptionRow(
              Icons.history,
              'Booking History',
            ),
            SizedBox(height: 20),
            profileOptionRow(
              Icons.notifications,
              'Notifications',
            ),
            SizedBox(height: 20),
            profileOptionRow(
              Icons.privacy_tip,
              'Privacy & Sharing',
            ),
            SizedBox(height: 20),
            profileOptionRow(
              Icons.mail,
              'Contact Us',
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

  Widget profileOptionRow(IconData icon, String text) {
    return GestureDetector(
      onTap: () {
        _navigateToOption(text);
      },
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Color(0xFF000040),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, size: 30, color: Colors.white),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppText(
                  text: text,
                  size: 16,
                  color: Colors.black87,
                ),
                Icon(Icons.arrow_forward, size: 20, color: Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
