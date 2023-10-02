import 'package:flutter/material.dart';
import 'package:travel_app/pages/booking_page.dart';

import 'package:travel_app/widgets/app_buttons.dart';
import 'package:travel_app/widgets/app_large_text.dart';
import 'package:travel_app/widgets/app_text.dart';


import '../Components/action_button.dart';

class Destination extends StatefulWidget {
  const Destination({Key? key}) : super(key: key);

  @override
  DestinationState createState() => DestinationState();
}

class DestinationState extends State<Destination> {
  int gottenStars = 4;
  int selectedIndex = -1;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              left: 20,
              top: 50,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 370,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/images/Sigiriya.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 330,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 500,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppLargeText(text: "Sigiriya", size: 26,),
                        AppLargeText(text: "\$ 25", color: Colors.blueAccent)
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on, color: Colors.blueAccent,),
                        const SizedBox(width: 5,),
                        AppText(text: "Dambulla, Sri Lanka",
                          color: Colors.grey,
                          size: 16,)
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(5, (index) {
                            return Icon(Icons.star, color: index < gottenStars
                                ? Colors.amber
                                : Colors.grey, size: 20);
                          }),
                        ),
                        const SizedBox(width: 10,),
                        AppText(text: "(4.9)", color: Colors.grey, size: 12,),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    AppLargeText(text: "Members", size: 20,),
                    const SizedBox(height: 5,),
                    AppText(text: "Number of members in your travel group",
                      color: Colors.grey.withOpacity(0.8),
                      size: 14,),
                    const SizedBox(height: 10,),
                    Wrap(
                      children: List.generate(5, (index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: AppButtons(
                              size: 50,
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                              backgroundColor: selectedIndex == index ? Color(0xFF000040): Colors.grey.withOpacity(0.5),
                              borderColor: selectedIndex == index
                                  ? Color(0xFF000040)
                                  : Colors.grey.withOpacity(0.5),
                              text: (index + 1).toString(),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Column(
                        children: [
                          AppLargeText(text: "Description", size: 20,),
                          const SizedBox(height: 20,),
                          AppText(
                            text: "Sigiriya or Sinhagiri is an ancient rock fortress located in the northern Matale District near the town"
                                " of"
                            "Dambulla in the Central Province, Sri Lanka. "
                                "It is a site of historical and archaeological significance that is dominated by a massive column of "
                                "granite rock approximately 180 m high.",
                            color: Colors.black.withOpacity(0.8),
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  AppButtons(
                    size: 60,
                    color: const Color(0xFF878593),
                    backgroundColor: Colors.white,
                    borderColor: const Color(0xFF878593),
                    icon: Icons.favorite_border,
                    isIcon: true,
                  ),
                  SizedBox(width: 20,),
                  ElevatedButton(
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
                          builder: (context) => BookingPage(),
                        ),
                      );
                    },
                    child: const SizedBox(
                      width: 200,
                      height: 50,
                    child:Center(
                    child: const Text('Proceed'),
                    ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  }
