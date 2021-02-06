import 'package:RBS/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final FormFieldValidator validator;
  final String initialValue;
  final bool isPassword;
  TextEditingController controller;

  CustomTextField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.validator,
    this.initialValue,
    this.isPassword = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? true : false,
        initialValue: initialValue,
        validator: validator,
        onChanged: onChanged,
        cursorColor: kColorWhite,
        style: TextStyle(color: kColorWhite),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kColorWhite,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: kColorWhite),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
