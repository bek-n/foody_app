import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_app/view/pages/auth/sign_in.dart';
import 'package:foody_app/view/pages/auth/verify_page.dart';
import 'package:foody_app/view/style/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../controller/auth_controller.dart';
import '../../components/auth_button.dart';
import '../../components/ckeck_box.dart';
import '../../components/custom_textform.dart';
import '../../components/warning_container.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController phone = TextEditingController();
  bool isPhoneEmpty = false;

  @override
  void dispose() {
    phone.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 114.4, vertical: 24),
              child: Image.asset(
                'assets/image/LogoMainPage.png',
                height: 192.h,
                width: 199.2.w,
              ),
            ),
            Text('Sign up for free',
                style: Style.textStyleRegular(
                    size: 23, textColor: Style.blackColor)),
            32.verticalSpace,
            Padding(
              padding: const EdgeInsets.only(
                left: 48,
              ),
              child: Row(
                children: [
                  Text('Phone',
                      style: Style.textStyleRegular2(
                          textColor: const Color(0xff2C3A4B))),
                  Text('*',
                      style: Style.textStyleRegular2(
                          size: 14, textColor: Style.primaryColor)),
                ],
              ),
            ),
            8.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomTextFrom(
                onchange: (value) {
                  isPhoneEmpty = false;
                  setState(() {});
                },
                controller: phone,
                keyboardType: TextInputType.phone,
                hintext: 'Phone Number',
              ),
            ),
            8.verticalSpace,
            isPhoneEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Warning(
                      text: 'Please fill the Phone',
                    ))
                : const SizedBox.shrink(),
            22.verticalSpace,
            const Padding(
                padding: EdgeInsets.only(
                  left: 48,
                ),
                child: CkeckBox()),
            context.watch<AuthController>().errorText == null
                ? const SizedBox.shrink()
                : Text(
                    context.watch<AuthController>().errorText ?? "",
                    style:
                        Style.textStyleRegular2(textColor: Style.primaryColor),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: InkWell(
                  onTap: () {
                    if (phone.text.isEmpty) {
                      isPhoneEmpty = true;
                    }
                    setState(() {});
                    if (phone.text.isNotEmpty) {
                      context.read<AuthController>().sendSms(phone.text, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const VerifyPage()));
                      });
                    }
                  },
                  child: AuthButton(
                    controller: phone,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text('Forgot the password?',
                  style:
                      Style.textStyleRegular2(textColor: Style.primaryColor)),
            ),
            32.verticalSpace,
            Text('or continue with',
                style: Style.textStyleRegular2(textColor: Style.blackColor)),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 37.5, right: 12),
                          child: Image.asset(
                            'assets/image/facebook.png',
                            height: 25,
                            width: 25,
                          ),
                        ),
                        Text(
                          'Facebook',
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    height: 57,
                    width: 178,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 221, 206, 206)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                  ),
                  Container(
                    height: 57,
                    width: 178,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 221, 206, 206)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 37.5, right: 12),
                          child: Image.asset(
                            'assets/image/google.png',
                            height: 25,
                            width: 24,
                          ),
                        ),
                        Text(
                          'Google',
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 32,
              ),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Don’t have an account?',
                  style: GoogleFonts.sourceSansPro(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff858C94)),
                ),
                TextButton(
                  onPressed: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const SignInPage())));
                  }),
                  child: Text(
                    'Sign in',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffF43F5E),
                    ),
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
