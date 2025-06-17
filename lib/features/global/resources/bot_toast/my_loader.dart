import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../resources.dart';


class MyLoader extends StatefulWidget {
  final Color color;

  const MyLoader({super.key, this.color = Colors.red});

  @override
  MyLoaderState createState() => MyLoaderState();
}

class MyLoaderState extends State<MyLoader> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: R.appColors.black.withOpacity(.1),
      child: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SpinKitCubeGrid(color: widget.color),
        ),
      ),
    );
  }
}
