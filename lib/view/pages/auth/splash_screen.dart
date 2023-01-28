import 'package:flutter/material.dart';
import 'package:foody_app/view/pages/auth/sign_up.dart';
import 'package:foody_app/view/pages/home/home_page.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../controller/local_store/local.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}




class _SplashScreenState extends State<SplashScreen> {


   void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String? docId = await LocalStore.getDocId();
      if (docId == null) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const SignUpPage()),
            (route) => false);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
            (route) => false);
      }
    });

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    'assets/image/LogoMainPage.png',
                    height: 334,
                    width: 346.52
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: LoadingAnimationWidget.inkDrop(
                        color: const Color(0XFFF43F5E), size: 35),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}