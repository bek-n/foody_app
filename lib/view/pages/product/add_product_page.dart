import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_app/view/components/custom_textform.dart';
import 'package:provider/provider.dart';

import '../../../controller/product_controller.dart';
import '../../components/custom_category.dart';
import '../../components/custom_type_dropdown.dart';

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
  final TextEditingController newCategoryTextEditController =
      TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductController>().getCategory();
    });
    super.initState();
  }

  @override
  void dispose() {
    nameTextEditController.dispose();
    descTextEditController.dispose();
    priceTextEditController.dispose();
    categoryTextEditController.dispose();
    typeEditController.dispose();
    newCategoryTextEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              50.verticalSpace,
              CustomTextFrom(
                controller: nameTextEditController,
                label: "name",
                hintext: '',
              ),
              50.verticalSpace,
              CustomTextFrom(
                controller: descTextEditController,
                label: "desc",
                hintext: '',
              ),
              50.verticalSpace,
              CustomTextFrom(
                controller: priceTextEditController,
                label: "price",
                keyboardType: TextInputType.number,
                hintext: '',
              ),
              50.verticalSpace,
              Customcategory(),
              50.verticalSpace,
             
             
             50.verticalSpace,
              CustomTextFrom(
                controller: categoryTextEditController,
                label: "category",
                hintext: '',
              ),
              50.verticalSpace,
              CustomType(),
              30.verticalSpace,
              ElevatedButton(onPressed: () {}, child: Text("Save"))
            ],
          ),
        ),
      ),
    ));
  }
}
