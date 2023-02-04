import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:foody_app/view/style/style.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class CustomImageNetworkMessage extends StatelessWidget {
  final String? image;
  final double height;
  final double width;
  final double radius;
  VoidCallback onDelete;
  bool isOwner;

  CustomImageNetworkMessage(
      {Key? key,
      required this.image,
      required this.onDelete,
      required this.isOwner,
      this.height = 120,
      this.width = 120,
      this.radius = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
       blurSize: 10,
      duration: const Duration(milliseconds: 300),
      onPressed: () {},
      menuItems: isOwner
          ? [
             
              FocusedMenuItem(title: const Text("Delete"), onPressed: onDelete),
            ]
          : [
              FocusedMenuItem(title: const Text("Delete"), onPressed: onDelete),
            ],
      child: SizedBox(
        height: height,
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: image ?? "",
            progressIndicatorBuilder: (context, text, DownloadProgress value) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: LiquidCircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Style.primaryColor),
                    value: value.progress ?? 0,
                  ),
                ),
              );
            },
            errorWidget: (context, _, __) {
              return Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Style.primaryColor),
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: const Center(child: Icon(Icons.error)));
            },
          ),
        ),
      ),
    );
  }
}