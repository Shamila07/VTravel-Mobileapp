import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travel_app/pages/booking_page.dart';
import 'package:travel_app/pages/confirmation_page.dart';
import 'package:travel_app/pages/contact_us.dart';
import 'package:travel_app/pages/login_page.dart';
import 'package:travel_app/pages/home_page.dart';
import 'package:travel_app/nav_pages/explore_page.dart';
import 'package:travel_app/nav_pages/wishlist_page.dart';
import 'package:travel_app/nav_pages/notifications.dart';
import 'package:travel_app/nav_pages/profile.dart';
import 'package:travel_app/nav_pages/destination.dart';
import 'package:travel_app/pages/welcome_page.dart';
import 'package:travel_app/backend/destination_controller.dart';
import 'package:travel_app/backend/firebase_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(DestinationController());
  Get.put(FirebaseStorageService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VTravel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/welcome',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/explore', page: () => const ExplorePage()),
        GetPage(name: '/wishlist', page: () => const WishlistPage()),
        GetPage(name: '/notifications', page: () => const Notifications()),
        GetPage(name: '/settings', page: () => Profile()),
        GetPage(name: '/destination', page: () => const Destination()),
        GetPage(name: '/booking', page: () => const BookingPage()),
        GetPage(name: '/confirmation', page: () => const ConfirmationPage()),
        GetPage(name: '/welcome', page: () => const WelcomePage()),
        GetPage(name: '/profile', page: () => const Profile()),
        GetPage(name: '/contact', page: () => const ContactUs()),
      ],
    );
  }
}
