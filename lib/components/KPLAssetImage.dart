import 'package:flutter/material.dart';

class KPLAssetImage extends StatelessWidget {
  final double width;
  final double height;
  final String name;
  final String folderName;
  String get path {
    return 'assets/$folderName/$name.png';
  }

  final BoxFit fit;
  KPLAssetImage(this.name,
      {this.folderName = 'images',
      this.width,
      this.height,
      this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      height: height,
      width: width,
      fit: fit,
    );
  }

  static generateImage(name,
      {folderName = 'images',
      width = 28.0,
      height = 28.0,
      fit = BoxFit.contain}) {
    return Image.asset(
      'assets/$folderName/$name.png',
      height: height,
      width: width,
      fit: fit,
    );
  }
}
