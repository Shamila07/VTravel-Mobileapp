import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/widgets/app_text.dart';



class ActionButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  final VoidCallback? onPressed;
   ActionButton ({super. key, this.width , this.isResponsive=false,this.onPressed, });
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
          width:isResponsive==true?double.maxFinite:width,
          height: 60,
          decoration: BoxDecoration(
            gradient:  LinearGradient(
                colors: [
                  Color(0xFF000040),
                  Color(0xFF000020),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment:isResponsive==true?MainAxisAlignment.spaceBetween:MainAxisAlignment.center,
            children:[
              AppText(text: "Reserve Here ", color: Colors.white,),

            ]
          )

        )
    );
  }
}
