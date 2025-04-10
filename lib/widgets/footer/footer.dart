import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ecomercy_app_flutter/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/route.dart';
import '../../services/theme_service.dart';
import '../Text/primary_text.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(context) {
    return Column(
      children: [
        SizedBox(height: 20,),
        Align(
          alignment: Alignment.center, // Căn lề trái
          child: Container(
            width: 200, // Điều chỉnh chiều dài của thanh gạch
            height: 1,
            color: Theme.of(context).colorScheme.onSurface,
            margin: EdgeInsets.only(top: 8), // Cách lề trên một chút
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {  },
              child: PrimaryText(
                'Tìm hiểu',
                fontWeight: FontWeight.w400,
                fontSize: 22,
              ),
            ),
            TextButton(
              onPressed: (){},
              child: PrimaryText(
                'Liên hệ',
                fontWeight: FontWeight.w400,
                fontSize: 22,
              ),
            ),
            TextButton(
              onPressed: () { Get.toNamed(Routes.blogs.sp); },
              child: PrimaryText(
                'Blog',
                fontWeight: FontWeight.w400,
                fontSize: 22,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 35,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 1,
          height: 40,
          color: Colors.white60,
          child: Center(
              child: PrimaryText(
            'Copyright© OpenUI All Rights Reserved.',
            fontWeight: FontWeight.w300,
          )),
        )
      ],
    );
  }
}
