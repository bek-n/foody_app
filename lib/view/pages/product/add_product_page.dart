import 'package:flutter/material.dart';
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
        child: Column(
          children: [
            CustomTextFrom(
              controller: nameTextEditController,
              hintext: '',
              label: 'Product Name',
            )
          ],
        ),
      ),
    );
  }
}
