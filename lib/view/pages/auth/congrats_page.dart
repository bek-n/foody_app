import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_app/view/pages/home/general_page.dart';
import 'package:foody_app/view/style/style.dart';
import 'package:google_fonts/google_fonts.dart';


class CongratsPage extends StatelessWidget {
  const CongratsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/Group.png'),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/image/done.png',
                      height: 173.h,
                      width: 177.75.w,
                    ),
                    24.verticalSpace,
                    Text(
                      'Congrats!',
                      style: Style.textStyleRegular(size: 32,textColor: Style.primaryColor),
                    ),
                    24.verticalSpace,
                    Text(
                      'Your profile is ready to use!',
                      style:Style.textStyleRegular(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => const GeneralPage())));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 134),
                  decoration: const BoxDecoration(
                    gradient: Style.linearGradient,
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                  ),
                  child: Center(
                    child: Text(
                      'Go homepage',
                      style: Style.textStyleRegular(textColor: Style.whiteColor)
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
