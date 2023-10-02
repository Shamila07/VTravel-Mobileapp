import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/nav_pages/destination.dart%20';
import 'package:travel_app/pages/login_page.dart';
import 'package:travel_app/widgets/app_large_text.dart';
import 'package:travel_app/widgets/app_text.dart';

import '../nav_pages/explore_page.dart';
import '../nav_pages/notifications.dart';
import '../nav_pages/profile.dart';
import '../nav_pages/wishlist_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var image = {
    "trending.png": "Trending",
    "landscape.png": "Nature",
    "temple.png": "Religious",
    "beach.png": "Seaside",
  };

  int currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ExplorePage(),
    WishlistPage(),
    Notifications(),
    Profile(),
  ];

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
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menu text
            Container(
              padding: const EdgeInsets.only(top: 50, left: 20),
              child: Row(
                children: [
                  GestureDetector(
                  onTap: () {
                    Navigator.push(
                       context,
                         MaterialPageRoute(
                           builder: (context) => LoginPage(),
                 ),
                );
               },
                 child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black54,
                  ),
                  ),
                  SizedBox(
                    width: 170,
                  ),
                  Image.asset(
                    "lib/images/Logo.png",
                    width: 170,
                    height: 80,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: AppLargeText(
                text: "Discover",
                size: 36,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                controller: tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicator:
                CircleTabIndicator(color: Colors.blueAccent, radius: 4),
                tabs: const [
                  Tab(
                    text: "All",
                  ),
                  Tab(
                    text: "Popular",
                  ),
                  Tab(
                    text: "Categories",
                  ),
                  Tab(
                    text: "Promotions",
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              height: 300,
              width: double.maxFinite,
              child: TabBarView(
                controller: tabController,
                children: [
                  // Tab 1: All
                  ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // Handle image tap navigation
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Destination(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 20, top: 10),
                          width: 200,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blueAccent,
                            image: const DecorationImage(
                              image: AssetImage(
                                "lib/images/Sigiriya.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Tab 2: Popular
                  ListView.builder(
                    itemCount: 3, // Update with appropriate count
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // Handle image tap navigation
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Destination(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 20, top: 10),
                          width: 200,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blueAccent,
                            image: const DecorationImage(
                              image: AssetImage(
                                "lib/images/Kandy.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Tab 3: Categories
                  ListView.builder(
                    itemCount: 3, // Update with appropriate count
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // Handle image tap navigation
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Destination(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 20, top: 10),
                          width: 200,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blueAccent,
                            image: const DecorationImage(
                              image: AssetImage(
                                "lib/images/Sigiriya.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Tab 4: Promotions
                  ListView.builder(
                    itemCount: 3, // Update with appropriate count
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // Handle image tap navigation
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Destination(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 20, top: 10),
                          width: 200,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blueAccent,
                            image: const DecorationImage(
                              image: AssetImage(
                                "lib/images/Sigirya.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppLargeText(
                    text: "Explore more",
                    size: 18,
                  ),
                  AppText(
                    text: "View all",
                    size: 14,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              width: double.maxFinite,
              margin: const EdgeInsets.only(left: 20),
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 40),
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage(
                                "lib/images/" +
                                    image.keys.elementAt(index),
                              ),

                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: AppText(
                            text: image.values.elementAt(index),
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
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

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;
  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(
      Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius / 2);
    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
