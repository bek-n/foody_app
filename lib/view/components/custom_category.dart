import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/product_controller.dart';

class Customcategory extends StatelessWidget {
  const Customcategory({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      borderRadius: const BorderRadius.all(Radius.circular(28)),
      autofocus: true,
      value: context.watch<ProductController>().listOfCategory.first,
      items: context
          .watch<ProductController>()
          .listOfCategory
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (s) {},
      decoration: const InputDecoration(
        labelText: "Category",
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 221, 206, 206)),
            borderRadius: BorderRadius.all(Radius.circular(100))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 221, 206, 206)),
            borderRadius: BorderRadius.all(Radius.circular(100))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 221, 206, 206)),
            borderRadius: BorderRadius.all(Radius.circular(100))),
      ),
    );
  }
}
