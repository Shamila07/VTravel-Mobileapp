import 'package:flutter/material.dart';

class BookingDetailsPage extends StatelessWidget {
  final DateTime? selectedDate;
  final double totalPrice;

  const BookingDetailsPage({
    Key? key,
    required this.selectedDate,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your booking has been done to visit Sigiriya on ${selectedDate?.toString().split(' ')[0]}.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              'Total Charge: \$${totalPrice.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
