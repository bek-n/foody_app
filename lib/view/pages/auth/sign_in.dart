import 'package:flutter/material.dart';
import 'package:foody_app/view/pages/auth/sign_up.dart';
import 'package:foody_app/view/pages/home/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../controller/auth_controller.dart';
import '../../components/custom_textform.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  bool value = false;
  bool visibilityOfpasswor = false;
  bool isPhoneEmpty = false;
  bool isPasswordEmpty = false;

  @override
  void dispose() {
    phone.dispose();
    password.dispose();
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
                height: 192,
                width: 199.2,
              ),
            ),
            Text(
              'Sign in to your account',
              style: GoogleFonts.sourceSansPro(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48, top: 32),
              child: Row(
                children: [
                  Text(
                    'Phone',
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff2C3A4B)),
                  ),
                  Text(
                    '*',
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffDA1414)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
              child: CustomTextFrom(
                onchange: (value) {
                  isPhoneEmpty = false;
                  setState(() {});
                },
                controller: phone,
                keyboardType: TextInputType.phone,
                label: 'Phone Number',
              ),
            ),
            isPhoneEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 24, top: 8, right: 24),
                    child: Container(
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.error,
                              color: Color(0xff394452),
                            ),
                          ),
                          Text(
                            'Please fill the Password',
                            style: GoogleFonts.sourceSansPro(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff394452)),
                          ),
                        ],
                      ),
                      padding:
                          const EdgeInsets.only(top: 6, bottom: 6, left: 36),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Color(0xffEBEEF2)),
                    ),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.only(left: 48, top: 20),
              child: Row(
                children: [
                  Text(
                    'Password',
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff2C3A4B)),
                  ),
                  Text(
                    '*',
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffDA1414)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
              child: CustomTextFrom(
                onchange: (value) {
                  isPasswordEmpty = false;
                  setState(() {});
                },
                suffixicon: IconButton(
                    onPressed: (() {
                      setState(() {
                        visibilityOfpasswor = !visibilityOfpasswor;
                      });
                    }),
                    icon: Icon(visibilityOfpasswor
                        ? Icons.visibility
                        : Icons.visibility_off)),
                controller: password,
                obscureText: !visibilityOfpasswor,
                obscuringCharacter: '*',
                keyboardType: TextInputType.emailAddress,
                label: 'Password',
              ),
            ),
            isPasswordEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 24, top: 8, right: 24),
                    child: Container(
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.error,
                              color: Color(0xff394452),
                            ),
                          ),
                          Text(
                            'Please fill the Password',
                            style: GoogleFonts.sourceSansPro(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff394452)),
                          ),
                        ],
                      ),
                      padding:
                          const EdgeInsets.only(top: 6, bottom: 6, left: 36),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Color(0xffEBEEF2)),
                    ),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.only(left: 48, top: 22),
              child: Row(
                children: [
                  Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      side: MaterialStateBorderSide.resolveWith(
                        (states) => const BorderSide(
                          width: 1.0,
                          color: Color(0xffFF1843),
                        ),
                      ),
                      activeColor: const Color(0xffFF1843),
                      value: this.value,
                      onChanged: ((value) {
                        setState(() {
                          this.value = value!;
                        });
                      })),
                  Text(
                    'Remember me',
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff2C3A4B)),
                  ),
                ],
              ),
            ),
            context.watch<AuthController>().errorText != null
                ? Text(context.watch<AuthController>().errorText ?? "")
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: InkWell(
                onTap: () {
                  if (phone.text.isEmpty) {
                    isPhoneEmpty = true;
                  } else if (password.text.isEmpty) {
                    isPasswordEmpty = true;
                  }
                  setState(() {});
                  context
                      .read<AuthController>()
                      .login(phone.text, password.text, () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                        (route) => false);
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 130),
                  decoration: BoxDecoration(
                    color: phone.text.isEmpty || password.text.isEmpty
                        ? const Color.fromARGB(244, 235, 134, 164)
                        : const Color(0xffFF1843),
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                  ),
                  child: Center(
                    child: context.watch<AuthController>().isLoading
                        ? Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: LoadingAnimationWidget.inkDrop(
                                color: const Color(0XFFF43F5E), size: 35),
                          )
                        : Text(
                            'Sign in',
                            style: GoogleFonts.sourceSansPro(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Forgot the password?',
                style: GoogleFonts.sourceSansPro(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffF43F5E)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Text(
                'or continue with',
                style: GoogleFonts.sourceSansPro(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
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
                        builder: ((context) => const SignUpPage())));
                  }),
                  child: Text(
                    'Sign up',
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