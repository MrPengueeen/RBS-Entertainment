import 'package:RBS/colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class NotificationWidget extends StatefulWidget {
  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ClipPath(
      clipper: CustomClipPath(),
      child: Container(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        height: size.height * 0.7,
        width: size.width * 0.8,
        color: kColorWhite,
        child: Container(
          margin: EdgeInsets.only(top: 20),
          color: kPrimaryColor,
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 30,
                    itemBuilder: (_, index) {
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/logos/logo_big.png',
                                  height: 50,
                                  width: 70,
                                ),
                                Flexible(
                                  child: Text(
                                          'New notification from user ${index + 1}')
                                      .text
                                      .white
                                      .make(),
                                ),
                              ],
                            ).pOnly(bottom: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Divider(
                                color: kColorText,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              Container(
                height: 70,
                width: size.width,
                decoration: BoxDecoration(
                  border: Border.all(width: 0, color: Colors.white),
                  color: Colors.white,
                ),
                child: TextButton(
                  child: Text('Show all', style: TextStyle(color: kColorRed))
                      .text
                      .bold
                      .make(),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width - 20, 30);
    path.lineTo(10, 30);
    path.quadraticBezierTo(0, 30, 0, 40);
    path.lineTo(0, size.height - 10);
    path.quadraticBezierTo(0, size.height, 10, size.height);
    path.lineTo(size.width - 10, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 10);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
