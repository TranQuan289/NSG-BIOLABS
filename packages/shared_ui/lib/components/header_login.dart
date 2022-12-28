import 'package:flutter/material.dart';
import 'package:shared_ui/path/image_path.dart';

class HeaderLogin extends StatelessWidget {
  const HeaderLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(ImagePath.polygon1.assetName),
        fit: BoxFit.fill,
      )),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
              top: 0,
              left: -50,
              height: 160,
              width: 400,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(ImagePath.polygon2.assetName),
                )),
              )),
        ],
      ),
    );
  }
}
