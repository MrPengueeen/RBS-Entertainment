import 'package:RBS/colors.dart';
import 'package:RBS/custom_icons_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
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
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hidePass;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hidePass = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        //color: kPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: hidePass,
        initialValue: widget.initialValue,
        validator: widget.validator,
        onChanged: widget.onChanged,
        cursorColor: kColorWhite,
        style: TextStyle(color: kColorWhite),
        decoration: InputDecoration(
          // icon: Icon(
          //   icon,
          //   color: kColorWhite,
          // ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(CustomIcons.showPassword, color: kColorText),
                  onPressed: () {
                    setState(() {
                      hidePass = !hidePass;
                    });
                  })
              : null,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: kColorText.withOpacity(0.5)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 2, color: kColorText),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 2, color: kColorRed),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 2, color: kColorRed),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 2, color: kColorRed),
          ),
        ),
      ),
    );
  }
}
