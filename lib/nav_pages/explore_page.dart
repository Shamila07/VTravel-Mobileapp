import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/widgets/app_text.dart';
import 'package:travel_app/nav_pages/notifications.dart';
import 'package:travel_app/nav_pages/profile.dart';
import 'package:travel_app/nav_pages/wishlist_page.dart';
import 'package:travel_app/backend/destination_controller.dart';

import '../pages/home_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> destinationList = [
    {"name": "Kandy", "image": "Kandy.jpg"},
    {"name": "Sigiriya", "image": "Sigiriya.jpg"},
    {"name": "Baddagana", "image": "baddagana.jpg"},

  ];

  final List<Widget> _pages = [
    HomePage(),
    ExplorePage(),
    WishlistPage(),
    Notifications(),
    Profile(),
  ];

  final DestinationController _destinationController = Get.find<DestinationController>();

  void _navigateToPage(int index) {
    setState(() {
      currentIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _pages[index]),
    );
  }

  @override
  void initState() {
    _destinationController.getAllDestinations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate back to the previous page
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
                ),
                const SizedBox(width: 10),
                AppText(
                  text: 'Explore',
                  size: 22,
                  color: Colors.black,
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    onChanged: (value) {
                      // Handle search field input
                      // You can filter the destinationList based on the search value here
                      // and update the displayed list accordingly.
                    },
                  ),
                ),
                DefaultTabController(
                  length: 4,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: CircleTabIndicator(color: Color(0xFF000040), radius: 4),
                        tabs: const [
                          Tab(text: "Trending"),
                          Tab(text: "Nature"),
                          Tab(text: "Religious"),
                          Tab(text: "Seaside"),
                        ],
                      ),
                      SizedBox(
                        height: 600.0,
                        child: TabBarView(
                          children: [
                            buildDestinationList(),
                            buildDestinationList(),
                            buildDestinationList(),
                            buildDestinationList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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

  Widget buildDestinationList() {
    return ListView.builder(
      itemCount: destinationList.length,
      itemBuilder: (context, index) {
        final destination = destinationList[index];
        final destinationName = destination['name'];
        final imageUrl = destination['image'];

        return ListTile(
          leading: Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage('assets/images/$imageUrl'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(destinationName!),
          subtitle: Text('100km from Colombo'),
        );
      },
    );
  }
}
