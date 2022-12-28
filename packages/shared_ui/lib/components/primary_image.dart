import 'package:flutter/cupertino.dart';

import '../path/image_path.dart';

class PrimaryImage extends StatelessWidget {
  const PrimaryImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Image.asset(
        ImagePath.image.assetName,
      ),
    );
  }
}
