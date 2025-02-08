import 'package:flutter/material.dart';

enum RestaurantColors {
  primary("Primary", Color(0xFF2A5CAA)),
  secondary("Secondary", Color(0xFFFFC107)),
  background("Background", Color(0xFFF6F6F6)),
  surface("Surface", Colors.white),
  error("Error", Color(0xFFFF3C48)),
  onPrimary("OnPrimary", Colors.white),
  onSecondary("OnSecondary", Color(0xFF37474F)),
  onError("OnError", Colors.white),
  locationIcon("LocationIcon", Color(0xFFFF4E3A)),
  ratingIcon("RatingIcon", Color(0xFFFFD700)),
  onAlert("OnAlert", Color(0xFF546E7A));

  const RestaurantColors(this.name, this.color);

  final String name;
  final Color color;
}
