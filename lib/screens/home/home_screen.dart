import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screenshot/screenshot.dart';

import '../../services/widget_save_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/size_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScreenshotController screenshotController = ScreenshotController();

  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.c_E5FDFF,
      appBar: AppBar(
        backgroundColor: AppColors.c_FDFDFD,
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(AppImages.menu),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              String base64Image =
                  await screenshotControllerToString(screenshotController);
              WidgetSaverService.openWidgetAsImage(
                context: context,
                widgetKey: _globalKey,
                fileId: base64Image,
              );
            },
            icon: SvgPicture.asset(AppImages.pdf),
          ),
        ],
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Column(
          children: [
            36.getH(),
            Center(
              child:ClipRRect(child:  Image.asset(AppImages.my,width: 300,height: 300,fit: BoxFit.cover,),borderRadius: BorderRadius.circular(450),),
            ),
            36.getH(),
            Text(
              textAlign: TextAlign.center,
              "Jasurbek Qochqorov",
              style: TextStyle(
                color: AppColors.c_000072,
                fontSize: 30.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            16.getH(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "UX/UI Mobile Developer",
                    style: TextStyle(
                      color: AppColors.black.withOpacity(.95),
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  16.getH(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> screenshotControllerToString(
    ScreenshotController controller) async {
  Uint8List? imageBytes = await controller.capture();
  String base64Image = base64Encode(imageBytes!);
  return base64Image;
}
