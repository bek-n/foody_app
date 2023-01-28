import 'package:flutter/material.dart';
import 'package:foody_app/view/pages/auth/splash_screen.dart';
import 'package:provider/provider.dart';

import '../../../controller/user_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: context.watch<UserController>().isLoading
          ? const CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(context.watch<UserController>().user?.name ?? ""),
                Text(context.watch<UserController>().user?.username ?? ""),
                Text(context.watch<UserController>().user?.phone ?? ""),
                Text(context.watch<UserController>().user?.email ?? ""),
                ElevatedButton(
                    onPressed: () {
                      context.read<UserController>().logOut(() {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SplashScreen()),
                            (route) => false);
                      });
                    },
                    child: const Text("Log out"))
              ],
            ),
    );
  }
}
