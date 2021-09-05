import 'package:phoenix/src/Begin/begin.dart';
import 'package:phoenix/src/Begin/widgets/artwork_background.dart';
import 'package:phoenix/src/Begin/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/src/Begin/utilities/provider/provider.dart';
import 'package:provider/provider.dart';

class Interface extends StatefulWidget {
  @override
  _InterfaceState createState() => _InterfaceState();
}

class _InterfaceState extends State<Interface> {
  @override
  void initState() {
    rootCrossfadeState = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    rootCrossfadeState = Provider.of<Leprovider>(context);
    if (MediaQuery.of(context).orientation != Orientation.portrait) {
      orientedCar = true;
      deviceHeight = MediaQuery.of(context).size.width;
      deviceWidth = MediaQuery.of(context).size.height;
    } else {
      orientedCar = false;
      deviceHeight = MediaQuery.of(context).size.height;
      deviceWidth = MediaQuery.of(context).size.width;
    }

    bool darkModeOn = true;
    return Consumer<Leprovider>(builder: (context, taste, _) {
      globaltaste = taste;
      return Scaffold(
        backgroundColor: kMaterialBlack,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: darkModeOn ? Colors.white : kMaterialBlack,
          ),
          shadowColor: Colors.transparent,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Hero(
            tag: "crossfire-",
            child: Text(
              "Interface",
              style: TextStyle(
                color: darkModeOn ? Colors.white : Colors.black,
                inherit: false,
                fontSize: deviceWidth / 18,
                fontFamily: "UrbanSB",
              ),
            ),
          ),
        ),
        body: Theme(
          data: themeOfApp,
          child: Container(
            height: deviceHeight,
            child: Stack(
              children: [
                BackArt(),
                ListView(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                        activeColor: kCorrect,
                        checkColor: darkModeOn ? kMaterialBlack : Colors.white,
                        subtitle: Text(
                          "A fluid bouncing animation on scrolling",
                          style: TextStyle(
                            fontFamily: 'UrbanR',
                            color: darkModeOn ? Colors.white38 : Colors.black38,
                          ),
                        ),
                        title: Text(
                          "Fluid",
                          style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                              fontFamily: "UrbanR"),
                        ),
                        value: musicBox.get("fluidAnimation") ?? true,
                        onChanged: (newValue) {
                          setState(() {
                            musicBox.put("fluidAnimation", newValue);
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                        activeColor: kCorrect,
                        checkColor: darkModeOn ? kMaterialBlack : Colors.white,
                        subtitle: Text(
                          "Use albumart as background",
                          style: TextStyle(
                            fontFamily: 'UrbanR',
                            color: darkModeOn ? Colors.white38 : Colors.black38,
                          ),
                        ),
                        title: Text(
                          "Dynamic Background",
                          style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                              fontFamily: "UrbanR"),
                        ),
                        value: musicBox.get("dynamicArtDB") ?? true,
                        onChanged: (newValue) {
                          setState(() {
                            musicBox.put("dynamicArtDB", newValue);
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                        activeColor: kCorrect,
                        checkColor: darkModeOn ? kMaterialBlack : Colors.white,
                        subtitle: Text(
                          "Square shaped artwork in lists",
                          style: TextStyle(
                            fontFamily: 'UrbanR',
                            color: darkModeOn ? Colors.white38 : Colors.black38,
                          ),
                        ),
                        title: Text(
                          "Square Art",
                          style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                              fontFamily: "UrbanR"),
                        ),
                        value: musicBox.get("squareArt") ?? true,
                        onChanged: (newValue) {
                          setState(() {
                            musicBox.put("squareArt", newValue);
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                        activeColor: kCorrect,
                        checkColor: darkModeOn ? kMaterialBlack : Colors.white,
                        subtitle: Text(
                          "Position icons for driver's ease",
                          style: TextStyle(
                            fontFamily: 'UrbanR',
                            color: darkModeOn ? Colors.white38 : Colors.black38,
                          ),
                        ),
                        title: Text(
                          "Left Steering",
                          style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                              fontFamily: "UrbanR"),
                        ),
                        value: musicBox.get("androidAutoLefty") ?? true,
                        onChanged: (newValue) {
                          setState(() {
                            musicBox.put("androidAutoLefty", newValue);
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                        activeColor: kCorrect,
                        checkColor: darkModeOn ? kMaterialBlack : Colors.white,
                        subtitle: Text(
                          "Show additional song data in now playing.",
                          style: TextStyle(
                            fontFamily: 'UrbanR',
                            color: darkModeOn ? Colors.white38 : Colors.black38,
                          ),
                        ),
                        title: Text(
                          "Audiophile Data",
                          style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                              fontFamily: "UrbanR"),
                        ),
                        value: musicBox.get("audiophileData") ?? true,
                        onChanged: (newValue) {
                          setState(() {
                            musicBox.put("audiophileData", newValue);
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                        activeColor: kCorrect,
                        checkColor: darkModeOn ? kMaterialBlack : Colors.white,
                        subtitle: Text(
                          "Use regular mini-player design.",
                          style: TextStyle(
                            fontFamily: 'UrbanR',
                            color: darkModeOn ? Colors.white38 : Colors.black38,
                          ),
                        ),
                        title: Text(
                          "Classix Mini-Player",
                          style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                              fontFamily: "UrbanR"),
                        ),
                        value: musicBox.get("classix") ?? true,
                        onChanged: (newValue) {
                          setState(() {
                            musicBox.put("classix", newValue);
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ],
                  physics: musicBox.get("fluidAnimation") ?? true
                      ? BouncingScrollPhysics()
                      : ClampingScrollPhysics(),
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
