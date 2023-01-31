import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_app/view/components/custom_textform.dart';
import 'package:provider/provider.dart';

import '../../../controller/product_controller.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameTextEditController = TextEditingController();
  final TextEditingController descTextEditController = TextEditingController();
  final TextEditingController priceTextEditController = TextEditingController();
  final TextEditingController categoryTextEditController =
      TextEditingController();
  final TextEditingController typeEditController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductController>().getCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            30.verticalSpace,
            CustomTextFrom(
              controller: nameTextEditController,
              label: "name",
              hintext: '',
            ),
            30.verticalSpace,
            CustomTextFrom(
              controller: descTextEditController,
              label: "desc",
              hintext: '',
            ),
            30.verticalSpace,
            CustomTextFrom(
              controller: priceTextEditController,
              label: "price",
              keyboardType: TextInputType.number,
              hintext: '',
            ),
            30.verticalSpace,
            DropdownButtonFormField(
              value: context.watch<ProductController>().listOfCategory.first,
              items: context
                  .watch<ProductController>()
                  .listOfCategory
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (s) {},
              decoration: InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            30.verticalSpace,
            CustomTextFrom(
              controller: categoryTextEditController,
              label: "category",
              hintext: '',
            ),
            30.verticalSpace,
            CustomTextFrom(
              controller: typeEditController,
              label: "type",
              hintext: '',
            ),
            30.verticalSpace,
            ElevatedButton(onPressed: () {}, child: Text("Save"))
          ],
        ),
      ),
    ));
  }
}
