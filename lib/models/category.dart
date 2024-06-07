import 'package:flutter/material.dart';

class Category {
  String name;
  IconData icon;

  Category({
    required this.name,
    required this.icon,
  });

// This model only for Exammple........
// ###################################################

  static List<Category> getCategories() {
    List<Category> categories = [];

    categories.add(Category(
      name: "Cricket",
      icon: Icons.sports_cricket,
    ));

    categories.add(Category(
      name: "Football",
      icon: Icons.sports_football_outlined,
    ));

    categories.add(Category(
      name: "Volleyball",
      icon: Icons.sports_volleyball_rounded,
    ));

    categories.add(Category(
      name: "Kabaddi",
      icon: Icons.sports_kabaddi_sharp,
    ));

    categories.add(Category(
      name: "Baseball",
      icon: Icons.sports_baseball,
    ));

    return categories;
  }
}

//#####################################################
