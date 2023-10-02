import 'package:flutter/material.dart';
import 'package:travel_app/pages/login_page.dart';

class ResponsiveButton extends StatelessWidget {
  bool isResponsive;
  double? width;
  ResponsiveButton({super. key, this.width, this.isResponsive=false, this.onPressed});
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Flexible(
    // updated alignment
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF000040),
                    Color(0xFF000020),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage(),
                  ),
                );
              },

              child:const Center(
                child: Text(
                  'GET  STARTED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
