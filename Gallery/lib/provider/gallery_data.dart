import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../keys.dart';
import '../services/network_helper.dart';

class GalleryData extends ChangeNotifier {
  List<String> photos = [];

  Future<void> getImages() async {
    List<String> images = [];

    String url = "https://pixabay.com/api/?key=$pixabyApiKey&per_page=80&image_type=photo&q=room";

    NetworkHelper networkHelper = NetworkHelper(url: url);

    dynamic data = await networkHelper.data();

    List<dynamic> hitsList = data["hits"] as List;

    for (int i = 0; i < hitsList.length; i++) {
      images.add(hitsList[i]["largeImageURL"]);
    }

    photos = images;

    notifyListeners();
  }

}