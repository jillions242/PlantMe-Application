import 'package:flutter/material.dart';
import 'package:plantme/constants/icons.dart';
import 'package:plantme/constants/colors.dart';
import 'package:plantme/constants/icons.dart';


List<Icon> getIcons() {
  return const [
    Icon(IconData(sunIcon, fontFamily: 'FontAwesomeSolid',fontPackage: 'font_awesome_flutter'), color: orange),
    Icon(IconData(wateringIcon, fontFamily: 'FontAwesomeSolid',fontPackage: 'font_awesome_flutter'), color: blue),
    Icon(IconData(heartIcon, fontFamily: 'FontAwesomeSolid',fontPackage: 'font_awesome_flutter'), color: deepPink),
    Icon(IconData(cutIcon, fontFamily: 'FontAwesomeSolid',fontPackage: 'font_awesome_flutter'), color: yellow),
    Icon(IconData(fertilizerIcon, fontFamily: 'FontAwesomeSolid',fontPackage: 'font_awesome_flutter'), color: green),
    
  ];
}
