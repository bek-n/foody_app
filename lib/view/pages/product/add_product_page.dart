import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_app/view/components/custom_textform.dart';
import 'package:provider/provider.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/product_controller.dart';
import '../../components/custom_category.dart';
import '../../components/custom_elevated_button_addnew_category.dart';
import '../../components/custom_type1_dropdown.dart';
import '../../components/custom_type_dropdown.dart';
import '../../components/edit_photo_product.dart';
import '../../components/photo_editing.dart';
import '../../components/product_dialog.dart';

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
              context.watch<AuthController>().imagePath.isEmpty
                  ? ProductImageDialog()
                  : Stack(
                      children: [
                        Container(
                          width: 250.w,
                          height: 250.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: FileImage(
                                  File(context
                                      .watch<ProductController>()
                                      .imagePath),
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        EditPhotoProduct()
                      ],
                    ),
              30.verticalSpace,
              CustomTextFrom(
                controller: nameTextEditController,
                label: "Name",
                hintext: '',
              ),
              30.verticalSpace,
              CustomTextFrom(
                controller: descTextEditController,
                label: "Description",
                hintext: '',
              ),
              30.verticalSpace,
              CustomTextFrom(
                controller: priceTextEditController,
                label: "Price",
                keyboardType: TextInputType.number,
                hintext: '',
              ),
              30.verticalSpace,
              const Customcategory(),
              30.verticalSpace,
              const CustomNewCategory(),
              30.verticalSpace,
              const TypeDropdown(),
              20.verticalSpace,
              ElevatedButton(
                  onPressed: () {
                    context.read<ProductController>().createProduct(
                        name: nameTextEditController.text,
                        desc: descTextEditController.text,
                        price: priceTextEditController.text);
                  },
                  child: context.watch<ProductController>().isSaveLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Save"))
            ],
          ),
        ),
      ),
    ));
  }
}
