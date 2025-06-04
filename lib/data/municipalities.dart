import 'package:flutter/material.dart';
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


final Map<int, String> municipalitiesData = {
  1: "Ghbayre Municipality",
  2: "Kheyam Municipality",
  3: "Houla Municipality",
  4: "Kawneen Municipality",
  5: "Bleeda Municipality",
  6: "Arabsalim Municipality",
  7: "MachGhara Municipality",
  8: "Sohmor Municipality",
  9: "Yoneen Municipality",
  10: "Aytaroon Municipality",
  11: "Taybi Municipality",
  12: "Edaysi Municipality",
  13: "Aynata Municipality",
  14: "DeerAnoon Municipality",
  15: "Bazoryi Municipality",
  16: "Barasheet Municipality",
  17: "Ayta Alshaeb Municipality",
  18: "Betleef Municipality",
};
