import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only( top: 80, right: 220),
      child: ListView.builder(
          itemCount: 6,
          scrollDirection: Axis.vertical,
          itemBuilder: (_, index) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 50),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      image: const DecorationImage(
                          image: AssetImage(
                              "lib/images/Sigiriya.jpg"),
                          fit: BoxFit.cover
                      )
                  ),
                ),
              ],
            );
          }
          ),

    );

  }
}
