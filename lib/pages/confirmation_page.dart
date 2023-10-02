import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:travel_app/pages/booking_page.dart';
import 'package:travel_app/widgets/app_text.dart';
import 'package:travel_app/widgets/app_large_text.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({Key? key}) : super(key: key);

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  DateTime? selectedDate;
  int adultsCount = 1;
  int childrenCount = 0;
  double adultPrice = 8.00;
  double childrenPrice = 4.00;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    initializeNotifications();
    setupNotificationListener();
  }

  void setupNotificationListener() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['payload'] == 'booking_details') {
        navigateToBookingDetails();
      }
    });
  }
  void navigateToBookingDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingDetailsPage(
          date: selectedDate,
          totalPrice: totalPrice,
        ),
      ),
    );
  }


  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> displayNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',

      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'notification',
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _decrementAdultsCount() {
    if (adultsCount > 1) {
      setState(() {
        adultsCount--;
      });
    }
  }

  void _incrementAdultsCount() {
    setState(() {
      adultsCount++;
    });
  }

  void _decrementChildrenCount() {
    if (childrenCount > 0) {
      setState(() {
        childrenCount--;
      });
    }
  }

  void _incrementChildrenCount() {
    setState(() {
      childrenCount++;
    });
  }

  double get totalAdultPrice => adultPrice * adultsCount;
  double get totalChildrenPrice => childrenPrice * childrenCount;
  double get totalPrice => totalAdultPrice + totalChildrenPrice;

  Future<void> sendBookingConfirmationNotification() async {
    const String channelId = 'your_channel_id';
    const String channelName = 'your_channel_name';

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Your Booking Has Been Confirmed',
      'Your booking has been done for visiting Sigiriya on ${selectedDate?.toString().split(' ')[0]}. Total Charge is \$${totalPrice.toStringAsFixed(2)}',
      platformChannelSpecifics,
      payload: 'booking_details',
    );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingPage(),
                      ),
                    );
                  },
                  child: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
                ),
                const SizedBox(width: 10),
                AppText(
                  text: 'Booking Confirmation',
                  size: 22,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Image.asset(
                  'lib/images/Sigiriya.jpg',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 45),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppLargeText(text: 'Destination', size: 22),
                    const SizedBox(height: 5),
                    AppText(text: 'Sigiriya', size: 20, color: const Color(0xFF000040)),
                    const SizedBox(height: 20),
                    AppText(
                      text: 'Destination Type',
                      size: 18,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 5),
                    AppText(text: "World Heritage Site", color: const Color(0xFF000040)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'Select Reservation Date: ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 50),
                ElevatedButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      selectedDate != null ? const Color(0xFF000020) : const Color(0xFF000040),
                    ),
                  ),
                  child: Text(
                    selectedDate != null ? selectedDate!.toString().split(' ')[0] : 'Select Date',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            // ... rest of the code

            const SizedBox(height: 10),
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
            ),
            const SizedBox(height: 10),
            AppLargeText(text: 'QR Code', size: 20),
            const SizedBox(height: 10),
            Column(
              children: [
                Image.asset(
                  'lib/images/qrcode.png',
                  width: 180,
                  height: 180,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: sendBookingConfirmationNotification,
                  child: const Text('Send Booking Confirmation'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BookingDetailsPage extends StatelessWidget {
  final DateTime? date;
  final double totalPrice;

  const BookingDetailsPage({
    Key? key,
    required this.date,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Booking Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (date != null)
              Text(
                'Your booking has been done to visit Sigiriya on ${date?.toString().split(' ')[0]}.',
                style: TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 10),
            Text(
              'Total Charge: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}