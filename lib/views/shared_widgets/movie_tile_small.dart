import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MovieTileSmallWidget extends StatelessWidget {
  final String name;
  final String image;

  const MovieTileSmallWidget({
    Key key,
    this.name,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 180.0,
            width: 200.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    image,
                  ),
                ),
                borderRadius: BorderRadius.circular(30)),
          ).pOnly(bottom: 5),
          SizedBox(
              width: 180,
              child: Text(name).text.xs.bold.white.make().pOnly(bottom: 10)),
        ]));
  }
}
