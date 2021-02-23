import 'package:RBS/colors.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;

  const CustomButtonWidget(
      {Key key,
      this.text,
      this.press,
      this.color = kColorRed,
      this.textColor = kColorWhite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
            color: color == kPrimaryColor ? kColorRed : kPrimaryColor),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width,
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
