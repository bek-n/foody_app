import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../controller/home_controller.dart';
import '../../components/cached_network_image.dart';
import '../../components/custom_textform.dart';
import '../../style/style.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final TextEditingController search = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>()
        ..getProduct(isLimit: false)
        ..getCategory(isLimit: false)
        ..getUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    final event = context.read<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextFrom(
                    controller: search,
                    label: "Search",
                    onChange: (s) {
                      event.searchCategory(search.text);
                    },
                    hintext: '',
                  ),
                ),
                IconButton(
                    onPressed: () {
                      event.setFilterChange();
                    },
                    icon: Icon(Icons.menu)),
              ],
            ),
          ),
          state.setFilter || (state.selectIndex == -1)
              ? const SizedBox.shrink()
              : Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.pinkAccent),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child:
                      Text(state.listOfCategory[state.selectIndex].name ?? ""),
                ),
          Expanded(
            child: state.setFilter
                ? Wrap(
                    children: [
                      for (int i = 0; i < state.listOfCategory.length; i++)
                        InkWell(
                          onTap: () {
                            event.changeIndex(i);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: state.selectIndex == i
                                  ? Colors.pinkAccent
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Colors.pinkAccent),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            child: Text(state.listOfCategory[i].name ?? ""),
                          ),
                        )
                    ],
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        context.watch<HomeController>().listOfProduct.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        height: 88.h,
                        width: 380.w,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 50,
                                  offset: const Offset(0, 6),
                                  color:
                                      const Color(0xff5A6CEA).withOpacity(0.08))
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            color: Colors.white),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            12.horizontalSpace,
                            Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: context
                                            .watch<HomeController>()
                                            .listOfProduct[index]
                                            .image ==
                                        null
                                    ? const SizedBox.shrink()
                                    : CustomImageNetwork(
                                        image: context
                                                .watch<HomeController>()
                                                .listOfProduct[index]
                                                .image ??
                                            "",
                                        height: 64.h,
                                        width: 64.w,
                                      )),
                            20.horizontalSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                      context
                                              .watch<HomeController>()
                                              .listOfProduct[index]
                                              .name ??
                                          "",
                                      style: Style.textStyleRegular()),
                                ),
                                4.verticalSpace,
                                Text(
                                    context
                                            .watch<HomeController>()
                                            .listOfProduct[index]
                                            .desc ??
                                        "",
                                    style: Style.textStyleRegular2(
                                        size: 14,
                                        textColor: const Color(0xff858C94)))
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 32, top: 22),
                              child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  '\$${context.watch<HomeController>().listOfProduct[index].price.toString()}',
                                  style: Style.textStyleRegular(
                                      size: 20, textColor: Style.primaryColor)),
                            )
                          ],
                        ),
                      );
                    }),
          )
        ],
      ),
    );
  }
}
