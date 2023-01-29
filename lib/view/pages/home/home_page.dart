import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_app/view/pages/auth/sign_in.dart';
import 'package:foody_app/view/style/style.dart';
import 'package:provider/provider.dart';

import '../../../controller/user_controller.dart';
import '../../components/akciya_builder.dart';
import '../../components/popular_menu_builder.dart';
import '../../components/restaurant_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserController>().getUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage('assets/image/Group.png'))),
        child: Scaffold(
          body: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Row(
                    children: [
                      24.horizontalSpace,
                      Container(
                        height: 80.r,
                        width: 80.r,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(context
                                        .watch<UserController>()
                                        .user
                                        ?.avatar ??
                                    ""),
                                fit: BoxFit.cover)),
                      ),
                      24.horizontalSpace,
                      Column(
                        children: [
                          Text('Hello👋',
                              style: Style.textStyleRegular(size: 26)),
                          Text(
                              context.watch<UserController>().user?.username ??
                                  '',
                              style: Style.textStyleRegular(size: 26)),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xffF6F8FB),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Icon(
                            Icons.notifications_active,
                            color: Color(0xffF43F5E),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            context.read<UserController>().logOut(() {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SignInPage()),
                                  (route) => false);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xffF6F8FB),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Icon(
                              Icons.logout_outlined,
                              color: Color(0xffF43F5E),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  32.verticalSpace,
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 20),
                        child: Container(
                          height: 45.h,
                          width: 316.w,
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xffF4F6F9),
                                contentPadding: EdgeInsets.only(
                                  left: 28,
                                ),
                                suffixIcon: Icon(Icons.search_rounded),
                                hintText: 'Search',
                                hintStyle: Style.textStyleRegular2(size: 14),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xffF4F6F9),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xffF4F6F9),
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(100)))),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Color(0xffF43F5E).withOpacity(0.1)),
                        child: Icon(
                          Icons.filter_list,
                          color: Color(0xffF43F5E),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          32.verticalSpace,
                          SizedBox(height: 244, child: AkciyaListView()),
                          32.verticalSpace,
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24),
                                child: Text('Popular Restaurant',
                                    style: Style.textStyleRegular(
                                        size: 20, textColor: Style.blackColor)),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 24),
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: ((context) =>
                                    //             PopularRestaurantPage())));
                                  },
                                  child: Text('See all',
                                      style: Style.textStyleRegular(
                                          size: 16,
                                          textColor: Style.primaryColor)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: 248.h, child: const RestaurantListview()),
                          32.verticalSpace,
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24),
                                child: Text('Popular Menu',
                                    style: Style.textStyleRegular(size: 20)),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 24),
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: ((context) =>
                                    //             PopMenuPage())));
                                  },
                                  child: Text('See all',
                                      style: Style.textStyleRegular2(
                                          textColor: Style.primaryColor)),
                                ),
                              ),
                            ],
                          ),
                          MenuListView()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
