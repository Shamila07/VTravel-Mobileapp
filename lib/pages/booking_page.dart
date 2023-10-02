import 'package:flutter/material.dart';
import 'package:travel_app/Components/responsive_button.dart';
import 'package:travel_app/pages/confirmation_page.dart';
import 'package:travel_app/widgets/app_text.dart';
import '../widgets/app_large_text.dart';
import 'package:travel_app/nav_pages/destination.dart';
import 'package:http/http.dart';
import 'dart:convert';




class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  bool showUSD = true; // Track whether to show USD or EURO

  void toggleCurrency() {
    setState(() {
      showUSD = !showUSD;
    });
  }

  DateTime? selectedDate;
  int adultsCount = 1;
  int childrenCount = 0;
  double adultPrice = 25.00;
  double childrenPrice = 10.00;

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
                        builder: (context) => Destination(),
                      ),
                    );
                  },
                  child: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
                ),
                  const SizedBox(width: 10),
                AppText(
                  text: 'Confirm And Pay',
                  size: 22,
                ),
                SizedBox(width:60),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: toggleCurrency,
                      child: Text(
                        showUSD ? ' EURO' : ' USD',
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          selectedDate != null ? const Color(0xFF000020) : const Color(0xFF000040),
                        ),
                      ),
                    ),
                  ),
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
            const SizedBox(height: 15),
            AppLargeText(text: 'Number of Members', size: 20),
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
            ),
            Row(
              children: [
                AppText(
                  text: 'Adults',
                  size: 18,
                  color: Colors.black,
                ),
                const SizedBox(width: 150),
                ElevatedButton(
                  onPressed: _decrementAdultsCount,
                  child: const Text(
                    '-',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: const EdgeInsets.all(12),
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  adultsCount.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: _incrementAdultsCount,
                  child: const Text(
                    '+',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: const EdgeInsets.all(12),
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
        Text(
          '\$${totalAdultPrice.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                AppText(
                  text: 'Children',
                  size: 18,
                  color: Colors.black,
                ),
                const SizedBox(width: 135),
                ElevatedButton(
                  onPressed: _decrementChildrenCount,
                  child: const Text(
                    '-',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  childrenCount.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: _incrementChildrenCount,
                  child: const Text(
                    '+',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
            Text(
              '\$${totalChildrenPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),


            const SizedBox(height: 10),
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
            ),
             const SizedBox(height: 10),
            AppLargeText(text: 'Pay Here', size: 20),
            const SizedBox(height: 10),
            Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'lib/images/visa_logo.png',
                      width: 100,
                      height: 50,
                    ),
                    const SizedBox(width: 190),
                    FloatingActionButton(
                      onPressed: () {
                        // Handle VISA selection
                      },
                      child: const Icon(Icons.adjust),
                      backgroundColor: Color(0xFF000040),
                      foregroundColor: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Image.asset(
                      'lib/images/mastercard_logo.png',
                      width: 100,
                      height: 50,
                    ),
                    const SizedBox(width: 190),
                    FloatingActionButton(
                      onPressed: () {
                        // Handle Mastercard selection
                      },
                      child: const Icon(Icons.adjust),
                      backgroundColor: Color(0xFF000040),
                      foregroundColor: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(
                  color: Colors.grey,
                  height: 20,
                  thickness: 1,
                ),
              ],
            ),
             Center(
               child: ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Color(0xFF000040),
                   foregroundColor: Colors.white,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(32.0),
                   ),
                 ),
              onPressed: () {
              Navigator.push(
               context,
               MaterialPageRoute(
               builder: (context) => ConfirmationPage(),
                ),
                );
                },
                child: const Text('Proceed'),
             ),
            ),
                      ],
    ),
  ),
    );
  }
}
