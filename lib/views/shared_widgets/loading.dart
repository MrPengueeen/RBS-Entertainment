import 'package:flutter/material.dart';
import 'package:RBS/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(kSecondaryColor)))
        .center();
  }
}
