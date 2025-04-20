import 'package:ecomercy_app_flutter/widgets/Text/primary_text.dart';
import 'package:flutter/cupertino.dart';

class InfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset("assets/Logo.png"),
          PrimaryText("v1.0.0"),
        ],
      ),
    );
  }

}