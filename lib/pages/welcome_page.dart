import 'package:flutter/material.dart';
import 'package:travel_app/Components/responsive_button.dart';
import 'package:travel_app/pages/login_page.dart';
import 'package:travel_app/widgets/app_text.dart';



class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 3,
        itemBuilder: (_, index) {
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/Welcome.jpg" ),
                opacity: 0.4,
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 150 , left: 20 , right: 20),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "lib/images/Logo.png",
                      width:200,
                      height:80,
                    ),
                    AppText(text: "Enjoy your travel Journey", size: 20,color:Color(0xFF000040),),
                    const SizedBox(height: 20,),
                    AppText(text:
                    "All Travel Destinations from a "
                        "single place",
                      size: 14, color: Colors.blueGrey,),
                    const SizedBox(height: 20,),
                    ResponsiveButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
                  ],
                ),

              ),
            ),
          );
        },
      ),

    );
  }
}
