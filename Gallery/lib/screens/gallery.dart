import 'package:flutter/material.dart';
import 'package:gallery/keys.dart';
import 'package:gallery/provider/gallery_data.dart';
import 'package:provider/provider.dart';

import '../services/network_helper.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemCount: context.watch<GalleryData>().photos.length,
            itemBuilder: (context, index) => Image.network(
              //Provider.of<GalleryData>(context, listen: true).photos[index]
              context.watch<GalleryData>().photos[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
