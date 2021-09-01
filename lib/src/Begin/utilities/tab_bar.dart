import 'package:flutter/material.dart';
import '../begin.dart';

List<Tab> tabsData(double width,double height) {
double letterspace = width / 250;
double tabBarFontSize = orientedCar ? width / 18 : height / 35.5;

  return [
    Tab(
      child: Text(
        "MANSION",
        style: TextStyle(
          fontSize: tabBarFontSize,
          letterSpacing: letterspace,
          fontFamily: 'RalewaySB',
        ),
      ),
    ),
    Tab(
      child: Text(
        "TRACKS",
        style: TextStyle(
          letterSpacing: letterspace,
          fontSize: tabBarFontSize,
          fontFamily: 'RalewaySB',
        ),
      ),
    ),
    Tab(
      child: Text(
        "ALBUMS",
        style: TextStyle(
          letterSpacing: letterspace,
          fontSize: tabBarFontSize,
          fontFamily: 'RalewaySB',
        ),
      ),
    ),
    Tab(
      child: Text(
        "ARTISTS",
        style: TextStyle(
          letterSpacing: letterspace,
          fontSize: tabBarFontSize,
          fontFamily: 'RalewaySB',
        ),
      ),
    ),
    Tab(
      child: Text(
        "GENRES",
        style: TextStyle(
          letterSpacing: letterspace,
          fontSize: tabBarFontSize,
          fontFamily: 'RalewaySB',
        ),
      ),
    ),
    Tab(
      child: Text(
        "PLAYLISTS",
        style: TextStyle(
          letterSpacing: letterspace,
          fontSize: tabBarFontSize,
          fontFamily: 'RalewaySB',
        ),
      ),
    ),
  ];
}
