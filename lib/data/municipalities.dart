import 'package:flutter/material.dart';
import 'package:tayseer__app/models/municipalityInfo.dart';
enum Category {
  donations,
  services,
  volunteer,
  tenders,
}

final Map<Category, IconData> categoryIcons = {
  Category.donations: Icons.volunteer_activism,
  Category.services: Icons.build,
  Category.volunteer: Icons.group,
  Category.tenders: Icons.assignment,
};


final Map<int, MunicipalityInfo> municipalitiesData = {
  1: MunicipalityInfo(name: "Ghbayre Municipality", imagePath: "assets/images/ghbayri.png"),
  2: MunicipalityInfo(name: "Kheyam Municipality", imagePath: "assets/images/kheyam.png"),
  3: MunicipalityInfo(name: "Houla Municipality", imagePath: "assets/images/houla.png"),
  4: MunicipalityInfo(name: "Kawneen Municipality", imagePath: "assets/images/kawneen.png"),
  5: MunicipalityInfo(name: "Arabsalim Municipality", imagePath: "assets/images/arabsalim.png"),
  6: MunicipalityInfo(name: "Bleeda Municipality", imagePath: "assets/images/bleeda.png"),
  7: MunicipalityInfo(name: "MayslJabal Municipality", imagePath: "assets/images/maysljabal.png"),
  8: MunicipalityInfo(name: "Sohmor Municipality", imagePath: "assets/images/sohmor.png"),
  9: MunicipalityInfo(name: "Ghazeyi Municipality", imagePath: "assets/images/ghazeyi.png"),
  
  
};