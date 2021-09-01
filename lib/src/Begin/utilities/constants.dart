import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The default Black Color
Color kMaterialBlack = Color(0xFF000000);

/// You're Always right Color (SPOTIFY)
Color kCorrect = Color(0xFF1DB954);

/// Roundedness of widgets
double kRounded = 12;

/// Phoenix Color
Color kPhoenixColor = Color(0xFF028ac4);
// 02c9d3

/// Crossfade Duration.
int crossfadeDuration = 300;

/// Shadow for NowArt
BoxShadow nowArtShadow =
    BoxShadow(color: Colors.black54, blurRadius: 13.0, offset: kShadowOffset);

/// blur constant for artwork background
double artworkBlurConst = 16;

/// Shadow Offset of every glassmorphic widgets
Offset kShadowOffset = Offset(0, 3);

/// Aesthetic Quotes.
Map quotes = {
  "I don't wanna believe. I wanna Know.": "Carl Sagan",
  "The truth is like a black bouquet, Money's got us all enslaved The bullets and the bombs we make, oh, no.":
      "Stephen Swartz",
  "I don't care for your drugs, I don't care for your fame. Do you care for the truth if you're not entertained?":
      "Stephen Swartz",
  "No child of ours should have to starve, should have to die for us.":
      "Stephen Swartz",
  "What I cannot create, I do not understand.": "Richard Feynman",
  "Can I trust what I'm given? \n When faith still needs a gun.":
      "Stephen Swartz"
};

/// Changelogs
Map<String, String> changelogs = {
  "HERTZ - 2.0.0": "• Initial 2.0.0 release.\n• Rebuilt entire app."
};
