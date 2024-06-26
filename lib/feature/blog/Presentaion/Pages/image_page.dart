

import 'package:flutter/material.dart';
import 'package:widget_zoom/widget_zoom.dart';

class SelectImage extends StatelessWidget {
  final imageUrl;
  const SelectImage({super.key,required this.imageUrl});
  static rout(String imageurl)=>MaterialPageRoute(builder: (context)=>SelectImage(imageUrl: imageurl,));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: WidgetZoom(
          heroAnimationTag: 'tag',
          zoomWidget: Image.network(imageUrl,fit: BoxFit.fitWidth,))),
    );
  }
}
