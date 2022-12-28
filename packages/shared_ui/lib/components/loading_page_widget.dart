import 'package:flutter/cupertino.dart';
import 'package:shared_ui/colors/colors.dart';

class LoadingPageWidget extends StatelessWidget {
  const LoadingPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        radius: 15,
        color: greenColor,
      ),
    );
  }
}
